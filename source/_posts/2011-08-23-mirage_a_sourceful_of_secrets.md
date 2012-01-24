---
date: 2011-08-23 11:36:49 +0200
layout: post
publish: true
categories: mirage appsec owasp, sast, code-review
title: "Mirage: a sourceful of secrets"
---

[Pink Floyd](http://en.wikipedia.org/wiki/A_Saucerful_of_Secrets)
in 1968, drew progressive rock path thanks to [Syd Barret](http://en.wikipedia.org/wiki/Syd_Barrett)
genius.

Myself in Summer 2011 I drow the [Mirage path](https://github.com/thesp0nge/mirage/commit/d6c4b731bb544378273938d9aa706a0794cb734c)
for the next months thanks to... well, thanks to venerable Flex and Bison
tools.

As I said a [month ago](http://thesp0nge.com/2011/07/27/progetti_estivi_e_considerazioni_sparse.html)
(sorry, Italian post only), mirage will be the [Owasp Orizon](https://www.owasp.org/index.php/Category:OWASP_Orizon_Project)
successor.

From latest post, in English this sentence

{% blockquote thesp0nge, my latest post in this blog %}
"L'ultimo punto vuol dire, la progressiva dismissione del progetto Orizon,
che vuol dire che se questo laboratorio avrà successo magari ci sarà un
Owasp Mirage al posto del suo predecessore"
{% endblockquote %}

sounds that if mirage will be a successful laboratory project, than it will
replace Orizon definitely.

Let's talk a bit further about what I've done this Summer.

First of all, **GNU autotools.**
I used autotools from GNU to build a package that everyone can 

{% blockquote %}
  "configure; make; make install"
{% endblockquote %}

I discovered that this approach is hard to follow if the filesystem hierarchy
is complex.

I have to make some dependency check so the make command will know also about
the shared libraries it has to build.

Second point, **shared libraries.**
My idea about mirage architecture is to be plugin based. This approach leads
the core to be decoupled from the more specialized subsystems. I started
implementing this via shared libraries but I didn't find a common data
structure to hold data from main to libraries helper. **YET.**

Now I started hanging around some very basic SAST technique: [code crawling](https://www.owasp.org/index.php/Crawling_Code)

Breaking down the source code in tokens is straightforward easy with flex,
and libcrawler is in place doing this.

The idea is to placing in a database (either sql or nosql) the dangerous
keywords and look the tokens for them. No more, no less.

This one should help me understand how good is the architectural approach I
choose and I easy is mirage to develop this way.

