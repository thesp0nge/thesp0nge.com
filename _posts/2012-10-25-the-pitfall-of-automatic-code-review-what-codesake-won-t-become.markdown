--- 
published: true
layout: post
title: "The pitfall of automatic code review: what codesake won't become"
---

I write this post as a internal meme to draw the first roadmap for
codesake.com. After a couple of weeks that I was in [my appsec blog](http://armoredcode.com) 
redesign, now I'm back to codesake.com development.

I really hope an MVP will be ready for later winter or at least no longer than February 2013.

Now let's see which are, basing on my experience, the pitfalls codesake has to
avoid.

## Pitfall 0x01: your tool is enough

There are a lot of widespread misconceptions about source code static analysis,
but the first and the scariest one is that having a SAST tool, no matter how
good it can be, is the goal you have to reach.

Application security is a process that engages your developers, project managers,
software architect and even marketing people for 
[the code they outsource to web agencies](http://armoredcode.com/blog/are-web-agencies-the-new-security-threats-in-2013/)
since the very beginning of an web project.

Let both non technical people and non security people aware about your risk is the master key to the success.

### How codesake will avoid this one?

It's weird for an automatic static analysis platform trying to escape the fact
that a tool can't be enough. The idea is that a section for security awareness
must be present in the platform trying to help people in understand which is
the codesake output, the remediation tasks they must implement and how to
discriminate good findings from false positives.

A sort of coding dojo for developers to quick mockup the code they need and a
sort of high level dashboard for project managers. This implies that at least
for enterprises, users must have different roles.

## Pitfall 0x02: early stages aren't important enough

I was engaged in a number of late running code reviews. The code was already in
production and no one had clues about application security and the correct
perimeter of the application.

_How can I access this page? Which protocols do you support? Is there any API?
Is your database well protected?_

For development team that doesn't think application security as a key component
of their workflow, those questions are either not important at all. 

But a quick and dirty threat model can address mitigations task you can suggest
when you find something. You must give developers some added value.

### How codesake will avoid this one?

A preliminary architectural standard questionnaire that it will give codesake
some information to guess about web application exposure.
Of course this will be something general that it could be used as startup for a
real human driven threat modeling session.

## Pitfall 0x03: a tool's output is something I need

Yesterday I launched a commercial static analysis tool over 
[latest wordpress version](http://www.wordpress.org), 3.4.2 at the time I'm
writing this.

I expected to find no more than a couple of thing, since wordpress is a mature
software product and this is the latest version addressing a lot of security
problems.

More than 150 high level vulnerabilities were there over my dashboard, all
about injections and potential cross site scripting.

That's insane. Manaul reviewing all the high level findings will take me days.
It would be a better choice having done a manual code review over manually
selected portions of source code.

The second thing that drove me crazy was that since the source code was fresh
and it was a patch wrote eventually to close insecurities, I had found more
than 100 possible 0-days attack? Or more obviously I had found tons of false
positives.

### How codesake will avoid this one?

This will be tough. I have no magic wands in my hand to promize a pure free
false positives tool. A lot of vendors they do and, as a security specialist I
think they have a great marketing team instead of a powerful knowledge base.

As described on this post [alter ego over armoredcode.com](http://armoredcode.com/blog/the-hidden-pitfalls-in-automatic-source-code-review/), 
running a mix of hybrid analysis and fuzzing over suspected sanitizing routine
will lead me to provide better results.

I mean: if a tool detects that a tampered variable can be used in the
presentation layer after a routine called _make-your-string-safe_ it can't say
for sure anything about this attack path. It must make some fuzzy attack over
_make-your-string-safe_ in order to understand if it's a validation routine and
if it's performing well.

## Pitfall 0x04: a tool's output is something THEY need

Even source code static analysis tool output is not made for developers.
Application security specialists write security tool and they think all people
in the IT world can understand that fixing a XSS is just a matter of _escaping your input_.

Well, I can understand what escape means in this context but what about a web developer? 
He's thinking about SEO optimization, about layout, about business logic, about
bugs. He doesn't know anything about what do you really want him to escape? He
wasn't aware about all the possible manner you can write a XSS attack vector. 

And even if the report is written by an application security specialist,
readers are developers so code snippet and programming design patterns have to
be used instead of theorical security considerations (they still great for
remediation introduction however, so a developer can learn).

### How codesake will avoid this one?

Output for security tests won't be in term of _fix your code for injection_ or
_if you're a java application then use this ESAPI class_ (if testing a .NET or
Ruby project).

Fixes has to be as specific as possible. They must be in the same programming
language the application is wrote into.
Of course, suggesting third parties great libraries like 
[OWASP ESAPI](https://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API)
is correct but suggestion must be tuned and contextualized. 

As example, for a ruby project something like the following can be a feasible
recommendation:

* put owasp-esapi-ruby gem into your Gemfile 

```
...
gem "owasp-esapi-ruby"
...
```

* make a bundle install

```
$ bundle install
```

* include Esapi::Sanitize module in your class

```
...
include Esapi::Sanitize
...
```

## Outro

Very compelling goals. Can I make this things to be real?
