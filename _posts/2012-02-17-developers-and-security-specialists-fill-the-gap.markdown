---
layout: post
title: "Developers and security specialists: fill the gap"
date: 2012-02-17 08:10
comments: true
categories: ruby developers talk appsec owasp community rubyday
---

## Welcome to the real world

It's a common problem, there is a gap between developers and security
specialists. The formers only think about security in terms of firewalls and
anti-virus, the latters think about development in terms of _why your code
doesn't work as expected?_ 

The gap must be filled some way. A reason is... survival. We are all pushed to
the limits in our daytime jobs and we **strongly** need to address security
issues in terms of features to implement or we will face something unexpected
at the online moment.

In an ideal world, as a security specialist I have to know each software
development pattern and technical detail about application server
configuration, optimization and setup. And some flavour of jquery too...
_obviously_
At the other side, as developers I must care about XSS, CSRF, session fixation
and how to deal with cryptography and rainbow tables not to expose my customers
data to a confidentially mess.

But the truth is that this is the _real_ world.

<!-- more -->

## assert\_equal "in the middle"

Common winsdom says that the truth is in the middle between two counterparts
opinion. Of course developers have a roadmap and appsec specialists some
internal assets to protect, but we must find a common ground to talk.

_Which kind of testing frameworks do you use?_ 
Most of times there is no answer to this question, someone nervously smiled,
someother offers you a coffee or even more they start talking about that they
sometimes make a manual navigation on the website to ensure that no 404 pages
are reached.

## We've found the problem

Testing must be integrated with security tests in the development stages and
testing **must** be automated.

Rspec, minitest, junit, capybara, there are a lot of testing frameworks out
there. It's not important the programming language do you use, but it's
**crucial** to do test and see all green lights before going further in the
development.
It's a strong statement but it must be done and checks must be provided by
security specialists and they must be used by developers.

## self.evangelize

Use testing as common ground to talk to your developers is definitely a great
solution.

Next June in Milan there will be the second edition of 
[Ruby Day](http://rubyday.it). I submitted a talk proposal focused on this
topic. How to test for Owasp Top 10 issues using _TDD_ in a ruby project. 
