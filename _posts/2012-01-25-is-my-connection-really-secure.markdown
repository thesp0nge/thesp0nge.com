---
layout: post
title: "Is my connection really secure?"
date: 2012-01-25 07:52
comments: true
categories: appsec ssl webapp pentest owasp
---

When you connect to a HTTPS server you must ensure the certificate is correct
before submitting sentitive data.
Modern browser do a lot of work for unexperienced users and if you see a green
lock, hopefully you can consider your communication to be secured.

But what about the penetration tester perspective?

## Some step before

Days ago, I was attending a workshop showing how to break web applications and
the first step explained was fingerprint and information gathering.
SSLDigger, formerly by Foundstone, now a McAffee tool, was taken as example to
list all available ciphers in a HTTPS connection.

The tool is no longer maintained and it requires and old .NET libraries version
and, most important, it doesn't run in a unix based environment.

<!-- more -->

## The Google and the Net

In a second I found some great bash script for enumerating available scripts. 
Algorithm is quite basic:

``` 
  given a protocol do
    for all ciphers openssl knows for that protocol do
      try open a connection and writing "GET / HTTP/1.0"
      if the server complains
        cipher is not supported
      else
        cipher is supported
      end
    end
  end 
```

That's it, in a minute I can use a script and venerable openssl tool to make
the same things SSLDigger ask me to download Megs of .NET 1.x libraries data.

## Wait, I'm a ruby fan boy

Ok, the script works fine but I want something more hackish I can tweak and I
can integrate in scripts or more complex software.

More of this I want more then enumerating ciphers, I want something tell me the
HTTPS connection can be hardened more or the supported protocol vs ciphers
combination is good enough,

Looking at the Net for ispiration I found a this ruby script in a blog (sorry,
I can't retrieve it so if you're reading and you're the ssl_picker.rv daddy,
yes... write me down your blog url in the comments and I'll check back this
post).

``` ruby ssl_picker.rb 
require 'socket'
require 'openssl'
require 'net/https'

module Net
  class HTTP
    def set_context=(value)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      @ssl_context &&= OpenSSL::SSL::SSLContext.new(value)
    end
    ssl_context_accessor :ciphers
  end
end

protocol_version = [:SSLv2, :SSLv3, :TLSv1]
protocol_version.each do |version|
  puts version
  cipher_set = OpenSSL::SSL::SSLContext.new(version).ciphers
  cipher_set.each do |cipher_name, cipher_version, bits, algorithm_bits|
    request = Net::HTTP.new('extranet.sky.it', 443)
    request.use_ssl = true
    request.set_context = version
    request.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request.ciphers = cipher_name
    begin
      response = request.get("/")
      puts "[+] Accepted\t #{bits} bits\t#{cipher_name}"
    rescue OpenSSL::SSL::SSLError => e
      puts "[-] Rejected\t #{bits} bits\t#{cipher_name}"
    rescue #Ignore all other Exceptions
    end
  end
end
```

Ok, this looks interesting but it doesn't work with ruby 1.9.x anymore since
ssl_context_accessor was first deprecated and now removed from Net::HTTP.

So I taken the ssl_picker.rb script and I moved it further in a more complex
ruby gem [ciphersurfer](https://github.com/thesp0nge/ciphersurfer)

Of course, due to ssl_context_accessor thing, you can't run the gem using 1.8.
Well true to be told I don't test executing it with older rubies, I use the
_this ruby version is not supported_ statement.

``` ruby lib/ciphersurfer/net_http.rb
require 'socket'
require 'net/https'
require 'openssl'

module Net
  class HTTP
    def set_context=(value)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      @ssl_context &&= OpenSSL::SSL::SSLContext.new(value)
    end
    
    def ciphers
      return nil unless @ssl_context
      @ssl_context.ciphers
    end

    def ciphers=(val)
      @ssl_context ||= OpenSSL::SSL::SSLContext.new
      @ssl_context.ciphers = val
    end
  end
end
```

ssl_context_accessor in previous Net::HTTP API creates an accessor to a given
ssl_context attributes. I rather guess that API designers removed it since it's
just an hack and it's not a clear way to add pieces to the net framework.

I choose to be more polite, and added a getter/setter methods to ping newly
created ssl_context class variable.

The Ciphersurfer.Scanner class has two methods inside. A class method alive?
telling me if there is a server listening to a specific host:port.

``` ruby lib/ciphersurfer/scanner.rb
def self.alive?(host, port)
  request = Net::HTTP.new(host, port)
  request.use_ssl = true
  request.verify_mode = OpenSSL::SSL::VERIFY_NONE 
  begin
    response = request.get("/")
    return true
  rescue Errno::ECONNREFUSED => e
    return false
  rescue OpenSSL::SSL::SSLError => e
    return false
  end
end
``` 

The other method is the scanner routine that is very close to the original one.
It just returns ciphers ordered in arrays.

``` ruby lib/ciphersurfer/scanner.rb
def go
  cipher_set = OpenSSL::SSL::SSLContext.new(@proto).ciphers
  cipher_set.each do |cipher_name, cipher_version, bits, algorithm_bits|
    request = Net::HTTP.new(@host, @port)
    request.use_ssl = true
    request.set_context = @proto
    request.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request.ciphers = cipher_name
    begin
      response = request.get("/")
      @ok_ciphers << {:bits=>bits, :name=>cipher_name}
    rescue OpenSSL::SSL::SSLError => e
      @ko_ciphers << {:bits=>bits, :name=>cipher_name}
    rescue 
      # Quietly discard all other errors... you must perform all error chekcs in the calling program
    end
  end
end
``` 

Gem binary is very simple as well. Just ask to scan for all known ciphers given a protocol.

``` ruby bin/ciphersurfer
protocol_version = [:SSLv2, :SSLv3, :TLSv1]
protocol_version.each do |version|
  puts version
  s = Ciphersurfer::Scanner.new({:host=>ARGV[0], :port=>ARGV[1], :proto=>version})

  s.go
  ok = s.ok_ciphers
  ko = s.ko_ciphers

  ok.each do |o|
    puts "[+] Accepted\t #{o[:bits]} bits\t#{o[:name]}"
  end
end
``` 

That's all folks. So if you want to use the gem you must before install it the common way.

``` 
gem install ciphersurfer
```

Then you have a ciphersurfer script you can use it this way:

``` 
ciphersurfer gmail.com 443
```

Since it's a 2 hour long hack it lacks a lot of thing:

* pretty printing
* parameter checking
* help
* database support
* a little datamining

As I said before I don't want just to enumerate the ciphers, but I want to give
the user a feedback from the security point of view about the status of the
HTTPS server configuration.

The idea is to implement checks described into [Owasp Testing
guide](https://www.owasp.org/index.php/Testing_for_SSL-TLS_(OWASP-CM-001\)),
giving the user (hopefully a security analist) a brief evaluation in terms of
_ok, communication is secured here_ or _no, ssl configuration must be locked
down further_.

Something even more I want to ad is a basic ORM support to save data in a SQL
form, [datamapper](http://datamapper.org) I guess.
