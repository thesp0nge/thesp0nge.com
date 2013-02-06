---
layout: post
publish: true
categories: ruby rvm sinatra errors ux pow lion discovery rack datamapper
comments: true
title: "When a proper error message makes the difference"
date:  2012-01-11 08:29
---

Look at this error: {% img http://thesp0nge.com/images/rack_lint_error.png%}

What would you think about to solve it?

Let's make a step behind. Yesterday I was crazy about solving the mess Xcode 4.2 
caused to my system about a broken C compiler that made me unable to
install properly rvm, ruby and gems. The system didn't work and I solved
installing an Apple provided [gcc package]('https://github.com/kennethreitz/osx-gcc-installer')

When I saw at a Rack::Lint error, I suspected something went wrong about gem
installing or that there was something yet compiled with the broken #gcc. So
I started the uninstall/install quest, trying to recompile all with the new #gcc.

This didn't solve my problems, the exception was still there.

I finally decided to look all the trace and I discovered this [datamapper]('http://datamapper.org')
error.
{% img http://thesp0nge.com/images/sinatra_error.png 800 %}

What the hell... I have an old DB on my repo and I just need to migrate all
the new models in order to create appropriate tables.

Just run
```
bin/discovery --init-db
```
and everything went in place.

I guess that the datamapper error would be propagated at the top of
exceptions, would me make me solve this issue in 5 minutes instead of 1/2
day.
