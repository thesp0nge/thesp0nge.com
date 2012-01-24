---
date: 2011-09-09 09:09:46 +0200
layout: post
publish: true
tags: appsec sast dast hybrid-analysis owasp code-review opensource startup
title: "The aurora project"
place: Gessate
---

Yesterday I officialy started the [aurora project](http://aurora.armoredcode.com)
with a brand new [repository](https://github.com/thesp0nge/aurora)
hosted on github.

{% blockquote %}
  "Yet another security tool?"
{% endblockquote %}

{% blockquote %}
  "Yet another security tool written by you?"
{% endblockquote %}

I know, I know... I changed the perspective I'm seeing the code review
problem a lot of times. I changed technology behind the code used to review
other code.

And I delivered not too much usable stuff. That's why I don't want to release
any roadmap but just start hacking and see what's happening.

##Some words about the code behind the scene

True to be told... one year ago I started writing a library in C with some
code to attack a web page with well known attack patterns. I called the
library 'dusk'. On the other side I started a library to be able to static
analyze a source file and I called 'dawn' this library. I worked first on
'dusk' library and just left the 'dawn' folder empty.

In December I switched to Ruby since most of the code I was writing at work
was in that language.

Writing a pentesting tool in ruby is far easier since to the mechanize
gem... an outstanding way to check patterns in HTML.

I gathered, working this way, a lot of fresh ideas about how to implement
hybrid analysis in aurora.

It won't be easy. I know. There is the danger a year far from today I'll
write on about aurora failure... or maybe aurora will turn 1.0 and it will be
the de facto opensource tool for perfoming hybrid analysis.

I'm pretty excited about this project... it's in pure C and I love writing
code in C. It's a security tool and I love application security. I love
challenges, that's why I'm starting a new one in late September. I love
fighiting, that's why I'm a taekwondo athelete.

So, place a bookmark to the aurora [website](http://aurora.armoredcode.com)
, start follow the source code [repository](http://github.com/thesp0nge/aurora)
, hack the code or help writing attack patterns or just say 'Hold on guys' to
boost our morale.
