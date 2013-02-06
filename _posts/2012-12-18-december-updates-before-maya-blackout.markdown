---
layout: post
published: true
title: 'December updates: before maya blackout'
---

It was two months ago since my [latest post](http://blog.codesake.com/the-pitfall-of-automatic-code-review-what-codesake-won-t-become.html)
and some important updates are on their way.

## The engine

The first and most important update is that a real world security code review I
performed some week ago, boosted my work on the codesake engine.

You noticed that a version _0.0.something_ was running on the [main site](http://codesake.com) without interesting features.
Before December I had no idea about the best strategy in building codesake
engine and the license to use. True to be told, the class namespace was Sake,
before I realized that a _sake_ gem was already on
[rubygems.org](http://rubygems.org) archive.

### Opensource (portion of it)

[codesake](https://github.com/codesake/codesake) is the fresh engine I'm
working on and it's a MIT licensed opensource piece of code.
codesake will be the basic, core engine, applying the first regular expression
scan over source files.

It will support a lot of different languages (see the spec/kernel\_spec.rb file
for details) and it will use regular expressions to find unsafe programming
patterns.

This will be the basic engine and I wanted to opensource it for two reason:
* give the community something back since they give me everyday a lot of:
  snippets, examples, ideas, feedback, ...
* give future codesake.com customers a quick feedback on how we will handle
  their code.

The closed part will be composed by several engines built ontop of codesake
that they will handle complex web applications. They will be also **specific**
to the framework the application will be write into.

So before going public the following engines will be on stage:

* codesake-sinatra
* codesake-padrino
* codesake-rails

## The website

The website is finally connected to [github.com](https://github.com) using
their OAuth implementation and the join link will be updated to redirect you to
github for single sign on.

That's all... before the Maya's clash.
