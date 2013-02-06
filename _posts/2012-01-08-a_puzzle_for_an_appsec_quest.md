---
layout: post
publish: true
categories: ruby appsec tool hacking sast dast webapp aurora
date: 2012-01-08 08:29
title: "A puzzle for an appsec quest"
---

It was 1 AM this morning and I was wondering about two things:

* I'm wrinting a lot of stuff in ruby that can be used to automate my appsec
  day by day work
* I'm really upset about web application penetration test commercial tools.  I
  don't like they don't expose an API, I don't like they are only Windows
  binaries consuming 1Gb of RAM before crashing, I don't like the false positives
  ratio.

Just before going to bed, I tweeted [this]('https://twitter.com/#!/thesp0nge/status/155941349735153664/photo/1')

I drawn a scenario where a full security assessment is performed over an host
by a lot of different small tools targeted to accomplish just a single goal.

It's clear in my mind that I need more then a point and click windows binary
that stores data in a SQL Server database with a non documented schema and
with a lot of blobs that make some post scan intelligence a real 
{% blockquote anonymous, common winsdom %}
Pain in the Ass
{% endblockquote %}

I need also to test web application with a pragmatic approach. The "spider
and then bruteforce" approach most commercial vendors have is not enought for
me. I want to test the app for authentication, authorization, overall design
in term of exception handling and more.

I want to move all my personal research from #sast field to create a full
featured web application security assessment framework, a lot of them are
already production ready in the wild, look in example to [ronin]('http://ronin-ruby.github.com')
framework.

aurora will be a logical project to create a security assessment framework to
assess webapps.

Project goals will be:

* KISS principle must be applied
* tools will be RESTful and their API will be documented
* results will be SQL served with a public accessible schema.

That's it. No fireworks, no big announcement. Just a collection of tool to
make my day by day work easier and that can be useful to other people.

All this work will be the open part of the [codesake project]('http://www.codesake.com')

The closed bit will be part of the knowledge base, I mean the scan library, the
rules, the checks based on my experience... but I'm in the very beginning and
it's a nonsense to bother with such details.

So, in the future, [codesake.com]('http://www.codesake.com') will be the
reference website for the aurora project framework, and this blog it will be as
well a behind the scene of what I'm doing.
