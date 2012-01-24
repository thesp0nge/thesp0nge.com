---
date: 2011-09-01 09:23:36 +0200
layout: post
publish: true
categories: appsec mirage codereview sast owasp owasp orizon
title: "Your crawling experience and on about mirage's name"
place: Gessate
---

[Yesterday](https://github.com/thesp0nge/mirage/commit/598d8d6a8c89b8db83d3713a7202dfba9ee9aa18)
was a very productive day for mirage project. In brief I touched the main.c
source file giving a rekon of a real security tool. I added some time
handling routines and I bumped the version number to 0.10.

However the very [previous commit](https://github.com/thesp0nge/mirage/commit/2955fe0e59036811dd19eabd8625d45bf39d6624)
was even more important due to the fix on data copying in [list.c](https://github.com/thesp0nge/mirage/blob/2955fe0e59036811dd19eabd8625d45bf39d6624/src/list.c)
file.

I'm very happy because with this fix, mirage is ready for a real source code
crawling capability, that it's the easiest thing to add to a static analyzer.

I'm not sure I'll add some context aware capability since this change will
add a lot of difficulties in writing libcrawel lex grammar. I don't want to
move there the intelligence to detect comments or programmin language
specific stuff that it will change crawling results.

So, blame at me but source crawling will have a **lot of false positives.**

I know and I really don't care about this since I use crawling just to
address manual review. So please use mirage crawling results just to
spotlight the source code areas where you **might**
find something interesting. But please, check this out manually. 

Don't trust **crawling.**

Always double check.

Owasp has it's own page about [source code crawling](https://www.owasp.org/index.php/Crawling_Code)

Of course, mirage will implement the recommendiations you can find on the
Owasp site.

When I first designed [Owasp Orizon](https://www.owasp.org/index.php/Category:OWASP_Orizon_Project)
I introduced mirage as just a application modeling engine choosing that name
with this meaning: building an error prone source code modeling engine is a **mirage.**

I still think this one even today that mirage is going to be Owasp Orizon
successor.

I don't think mirage will be the final name and I want to use this period of
time that the project is mostly unknown to find a good name with a good logo
to address the Orizon succession.

The only decided issue is that the Owasp Orizon project is **frozen**
and you have to consider no longer mantained.
