---
layout: post
published: true
title: This ain't an hello world post
tags: startup simple-life
---

<img src="/images/ny.jpg" class="left img-polaroid"/>
This is a 4 years old story, ideally born in a [downtown
manhattan](http://en.wikipedia.org/wiki/Lower\_Manhattan) 
Starbucks the last day of my week in New York city.
I was there for an application security conference where I had a talk about an
opensource source code analysis engine I was working so far.

Italian startup scene was in its very beginning (like nowadays) and I just got
married and unwilling to relocate for a number of personal issues I couldn't
control and so I can't today.

## Something I learnt

During the years I do mostly two kind of jobs:

* web developer (for about 4 years, but [I write](https://github.com/thesp0nge)
  a lot of code just for fun
* application security specialist

My career path summarize my passion for spotting security bugs in software,
write safe code and getting things done.

From the experiences I had in reviewing other people code, making threat
modeling and make penetration tests I found that security specilists write
reports that don't talk the developers common language. For such a reason, a
lot of security reports are either not so useful or either not even read by
developers.

Developers tend to be suspicious about application security guys since it's a
common thought that the latter are not able to code. Security activities are so
viewed as the price to pay to go online.

**Of course in other countries such as conclusions may dramatically differ.**

## The missing part of static analysis

Source code static analysis tools are not the silver bullet for you application
security quest. You must be proficient to appsec in order to understand the
findings they bring and you must undestand the code to cut the massive number
of false positives.

## So it's for the code's sake

[codesake.com](http://codesake.com) is the idea I was incubating to bring
developers somthing valuable for them. Not just a static analysis tool, nor an
eclipse plugin. The basic idea is having the scanning robot to make a clone of
a project github report, making some hybrid analysis over it and creating pull
requests with suggested patches.

Starting from pull requests, developers can collaborate and choose the right
patch to apply.

Hybrid analysis means applying both static than dynamic scanning techniques to
the source code, trying to understand how the code looks like and how the
source code will behave under some crafted input. 

## And the story begins

After years of internal incubation I started last week with a beta
[padrino](http://www.padrinorb.com) powered website. 

People will so be able to [join](http://codesake.com) the beta program and
start submitting source code snippets. 

Engine code will improve in the next months and people can see improvements
without submitting the same source code again, just reload the page and see how
findings will change.

