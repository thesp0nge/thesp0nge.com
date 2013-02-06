---
layout: post
title: "Announce: ciphersurfer v1.0.0"
date: 2012-02-01 07:48
comments: true
categories: tool h4f appsec ciphersurfer announce release opensource ssl https security pentest information-gathering
---

After a week since the first
[post](http://thesp0nge.com/blog/2012/01/25/is-my-connection-really-secure/)
about ciphersurfer and the early stage of testing an HTTPS communication, the
first **major** release it's available.

The project goals are now slightly different than just enumerating ciphers an
HTTPS server supports. Now a full evaluation is performed over the SSL
configuration giving a score using [SSLabs document](https://www.ssllabs.com/downloads/SSL_Server_Rating_Guide_2009.pdf)
as reference guide. 

<!-- more -->

The HTTPS connection is evaluated for _three_ KPIs:

* protocols the server supports
* cipher length
* certificate key length

The application you can find to the [SSLabs website](https://www.ssllabs.com)
also gives an additional score for the certificate but, since the last one
doesn't infere with the overall security score, I decided not to hack further
and hit the web with a 1.0.0 release.

For the ones scared about what the tool does in order to evaluate your website
security configuration, ciphersurfer performs neither of the followings:

* denial of service attacks
* cross site scripting or injection attempts
* data manipulation or leakage

The requests the tool makes are just an HTTP GET / of target website to ensure
the server accept an HTTP communication given a SSL protocol and cipher
proposed by the client. No more. Really, ciphersurer won't hurt your webserver,
nor your business. 

If you don't trust this disclaimer, just check the source code.

## Installing ciphersurfer

ciphersurfer is deployed as standard gem served by
[rubygems](http://rubygems.org). 

To install latest ciphersurfer stable release, just issue this command:

```
gem install ciphersurfer
```

If you want to install a _pre_ release, such as a _release candidate_ you can do it this way:

```
gem install ciphersurfer --pre
```

I recommend you to install [rvm](https://rvm.beginrescueend.com/) in order to
have your gem binaries tool installed in your home directory, otherwise
ciphersurfer will try to install itself in standard /usr/bin directory if no
other flags are passed to gem command.

## Using ciphersurfer

After ciphersurfer has been installed, using it it's very simple.

To evaluate secure communication with the target host _test-this.com_ at the
standard HTTPS port, you just give the tool the target name as option:

``` 
ciphersurfer test-this.com
``` 

As output you will see an evaluation for HTTPS test-this.com configuration. 
The evaluation scale is:

* A: _prime class_ HTTPS configuration. Servers handling **very** sensitive
  information
* B: strong HTTPS configuration, suitable for must production servers
* C: quite goot HTTPS configuration. If your web server is a private server and
  for development or testing purposes, it can be acceptable. If your server is
  exposed to the Internet, you want to improve your SSL configuration.
* D: poor HTTPS configuration. Suitable **only** for development machines.
* E: weak HTTPS configuration. You really don't want to have this score

As example, this is the evaluation for [www.pec.it](https://www.pec.it), ran
with official 1.0.0 ruby gem.

{% img http://thesp0nge.com/images/ciphersurfer_eval.png %}

You can also just listen ciphers supported by your web server instead of having
an SSL evaluation:

``` 
$ ciphersurfer -l gmail.com 

"Evaluating secure communication with gmail.com:443"
"[+] accepted RC4-MD5"
"[+] accepted AES256-SHA"
"[+] accepted DES-CBC3-SHA"
"[+] accepted AES128-SHA"
"[+] accepted RC4-SHA"
``` 

## Show me the code dude

Funny isn't it? Well the code has changed a lot since last post.

The first _major_ change is that for all regular HTTP GETs, the ruby library
**httpclient** has been used instead of cooking a connection using Net::HTTP
class. This because httpclient makes me easy to grab the server certificate
since it bundles all root CAs without them Net::HTTP class won't give me
anything as peer certificate.

This is the routine available at Ciphersurfer::Scanner.alive? It just checks if
a server answers if prompted for the root page. As you can see we grab also the
certificate so we don't need to bother the target with another get just to take
it.

``` ruby lib/ciphersurfer/scanner.rb
def self.alive?(host, port)
  client=HTTPClient.new
  begin
    @alive=true
    response=client.get("https://#{host}:#{port}")
    @peer_cert = response.peer_cert
    return true
  rescue => e
    puts "alive?(): #{e.message}".color(:red)
    return false
  end
  
end
```

The core scanning method hasn't changed a lot. Just a minor difference in how
results are stored.

``` ruby lib/ciphersurfer/scanner.rb
def go
  context=OpenSSL::SSL::SSLContext.new(@proto)
  cipher_set = context.ciphers
  cipher_set.each do |cipher_name, cipher_version, bits, algorithm_bits|

    request = Net::HTTP.new(@host, @port)
    request.use_ssl = true
    request.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request.ciphers= cipher_name
    begin
      response = request.get("/")
      @ok_bits << bits
      @ok_ciphers << cipher_name
    rescue OpenSSL::SSL::SSLError => e
      # Quietly discard SSLErrors, really I don't care if the cipher has
      # not been accepted
    rescue 
      # Quietly discard all other errors... you must perform all error
      # chekcs in the calling program
    end
  end
end
```

Here we don't use httpclient helpers since I want to play with different
ciphers at time.

That's it. All the magic happens there. Now, let's look like at the bin script to see how the scoring system has been used.

First of all, we must scan the target for all the protocols we support.

``` ruby bin/ciphersurfer
protocol_version.each do |version|
  s = Ciphersurfer::Scanner.new({:host=>host, :port=>port, :proto=>version})

  s.go
  if (s.ok_ciphers.size != 0)
    supported_protocols << version
    cipher_bits = cipher_bits | s.ok_bits
    ciphers = ciphers | s.ok_ciphers
  end

end
```

Now we've got supported_protocols that stores all the protocols the server
supports, and cipher_bits that stores all the ciphers length in bits. We want
the certificate now.

``` ruby bin/ciphersurfer
cert= Ciphersurfer::Scanner.cert(host, port)
if ! cert.nil?
  a=cert.public_key.to_text
  key_size=/Modulus \((\d+)/i.match(a)[1]
else
  puts "warning: the server didn't give us the certificate".color(:yellow)
  key_size=0
end
```

Note that we don't make another GET here since we did it at the beginning of
the engagement when we checked if the target was alive or not.

Now, let's calculate the scores, all of them in a 0..100 range.

``` ruby bin/ciphersurfer
proto_score=  Ciphersurfer::Score.evaluate_protocols(supported_protocols)
cipher_score= Ciphersurfer::Score.evaluate_ciphers(cipher_bits)
key_score=    Ciphersurfer::Score.evaluate_key(key_size.to_i)
score=        Ciphersurfer::Score.score(proto_score, key_score, cipher_score)
```

And then, some graphics to make the experience more appealing.

``` ruby bin/ciphersurfer
printf "%20s : %s (%s)\n", "Overall evaluation", Ciphersurfer::Score.evaluate(score), score.to_s
printf "%20s : ", "Protocol support" 
proto_score.to_i.times{print 'o'.color(score_to_color(proto_score))}
puts ' ('+proto_score.to_s+')'
printf "%20s : ",  "Key exchange" 
key_score.to_i.times{print 'o'.color(score_to_color(key_score))}
puts ' ('+key_score.to_s+')'
printf "%20s : ", "Cipher strength" 
cipher_score.to_i.times{print 'o'.color(score_to_color(cipher_score))}
puts ' ('+cipher_score.to_s+')'
```

Results can be optained also in a JSON format, so ciphersurfer can be embedded
in other tools or even in a web app.

## Further improvements

Well, the major improvement I'm going to introduce later on is a scan on some
certificate parameter to check if the certficate is still valid or if it's self
signed or if it matches the FQDN the tester asked.

Later some sort of persistence in a SQL database will be introduced to save the
scan history for a given target, in order to make evaluation over time if
actions were taken to improve HTTPS configuration or not.
