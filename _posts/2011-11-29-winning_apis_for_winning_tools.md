---
date: 2011-11-29 08:00:29 +0100
layout: post
publish: true
categories: appsec security tool sast dast pentest ruby rest API
title: "Winning apis for winning tools"
place: Gessate
---

Yesterday I asked [@netsparker](http://twitter.com/netsparker)
if his tool have a rest API I can used in some ruby script to automate my
work.

He answer was the APIs is in roadmap for late 2012. This is great but in
enterprise environment wouldn't be having a good API a must have for a
winning tool, would it?

Of course, it's not about Netsparker tool which is a great dynamic analysis
tool. This is a general consideration since I just want to automate some
boring daytime job activities and having myself focused on results analysis
and code reviews.

I think that it's crucial for a security tool (obviously this is true also
for any other IT field, but this is a security oriented blog so... ) to have
a rest API to help people interact with it and with data it outputs.

I like [arachni](http://rubygems.org/arachni)
approach that deploys a full XML-RPC server enabling people writing custom
code talking with the tool.

This should occur also in commercial tools, IMHO.
