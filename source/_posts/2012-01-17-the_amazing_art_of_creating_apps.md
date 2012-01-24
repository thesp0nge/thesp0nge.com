---
layout: post
publish: true
categories: ruby developmet bdd tdd web google "sw engineer" hacking discovery
title: "The amazing art of creating apps"
date:  2012-01-17 08:29
---

Fact: hackers have brilliant minds and most of times they prefer writing
their own swiss army knife application to accomplish a task.

Fact: I am a _wannabe_ hacker and also a _wannabe_ soffware developer.

In the last week I focused my attention in writing [discovery]('https://github.com/thesp0nge/discovery')
web application because I have to solve a my own task at work and because I
liked the way the app looks like now.

During the development, I realized that there is a lot of knowledge I don't
have and there are brilliant hackers out there.

Look at
[this]('http://florianhanke.com/blog/2011/02/02/running-sinatra-inside-a-gem.html')
blog post. It's about bundling a [sinatra]('http://www.sinatrarb.org')
application within a ruby gem.

Simply amazing. This post makes me clear I had to deploy discovery as ruby
gem and that I had to drop the CLI/Web interface dichotomy.

Binary tool must be a launcher for web app, no more no less. And a simple
config.ru with a require and a run statement can be enough to deploy
discovery with passenger or any rack based application server.

Let's go ahead. I had to solve how to integrate discovery with at work active
directory repository.

Googling 'sinatra ldap active directory' gives me back a lot of gems and a
lot of resources that it was embarassing choosing the appropriate one.

Actually, I found a three years old [blog post]('http://metautonomo.us/2008/04/04/simplified-active-directory-authentication/')
that shows a very simple model called ActiveDirectoryUser that solved my
problem.

A simple and brilliant solution I integrated in discovery with a slightly
modification. LDAP connection parameters are read from a YAML config file,
but this can become a very simple authentication framework for all web
applications I have to deploy at work without using omniauth or devise or
sinatra-ntlm or rack-or-something and this can be amazing.

It's a very creative period of my life. I don't want to waste this energy I
found looking aside pure static analysis quest I was trying to figure it out
in the last four or five years.

True to be told, I don't think I will ever release an out-of-the-box static
analysis tool. The main reason is that I think nobody can solve the problem
with a single "catch it all" application.

I want to stay focused in writing smallest apps solving small day by day
problem in the appsec world and I'm pretty sure this would lead something
  bigger will happen when all the dots will be connect down the road.
