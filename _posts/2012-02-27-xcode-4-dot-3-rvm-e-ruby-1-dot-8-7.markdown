---
layout: post
title: "Xcode 4.3, RVM e Ruby 1.8.7"
date: 2012-02-27 12:30
comments: true
categories: rvm gcc ruby stranezze apple macosx lion opensource
---

Ci siamo... aggiornato XCode tornano i problemi con RVM e le versioni di ruby
precedenti alla 1.9.3 che non amano essere compilate con compilatori
[LLVM](http://llvm.org/).

<!-- more -->

Faccio un recap di una decina di minuti di ricerche di Google, linkando le
azioni che servono per avere RVM funzionante con Lion:

* disinstallare i tool da linea di comando di XCode 4.3 che da questa versione
  sono in un altro [folder](https://discussions.apple.com/thread/3741223?start=0&tstart=0):

``` 
sudo /Library/Developer/Shared/uninstall-devtools --mode=all
```

* installare l'[osx-gcc-installer](https://github.com/kennethreitz/osx-gcc-installer/)

A questo punto, rvm vi permetterà ancora di installare versioni di ruby antecedenti alla versione 1.9.3

