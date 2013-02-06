---
date: 2011-07-05 10:20:44 +0200
layout: post
publish: true
categories: ruby rails nuvola armoredcode
title: "La gemma wc: il ritorno delle tag cloud"
place: Gessate
---

L'anno scorso avevo un sogno. Partire con il blog di armoredcode, creare hype
attorno a me, fare startup non avendo ancora bene in mente come, avere più
tempo per la mia famiglia.

Tutto questo partendo da [nuvola](http://nuvola.armoredcode.com)
il mio generatore di tag cloud.

Quanta innocenza nei miei sogni di 34enne vero? :-)

Bene, ora che sono 35enne e sono una persona matura ho capito che nuvola è
solo un gioco, ma per quanto gioco voglio dargli un bell'aspetto. Soprattutto
perché sembra che alcuni dubitino sappia mettere assieme del codice
funzionante.

_Birichini_ vi dimostrerò il contrario. 

L'idea dietro nuvola era, ed è semplice. Partendo da un testo, creare una tag
cloud ma dando all'utente il codice html in modo che possa customizzarla come
più gli aggrada. Niente di ecclatante. Un gioco appunto.

Adesso che dopo un anno ho imparato qualcosa in più di Rails, farò in modo che tramite [devise](https://github.com/plataformatec/devise)
e [omniauth](https://github.com/intridea/omniauth)
gli utenti si autentichino e si colleghino ai propri social network
eventualmente facendo SSO su nuvola.

Sicuramente seguirò la richiesta del mio amico [Stefano](http://www.psd2web.it/)
che mi disse sarebbe stato fico poter far crescere le nuvole aggiungendo testo a runtime.
Sono partito però dalle basi... dalla gemma [wc](https://rubygems.org/gems/wc)
che ho iniziato a scrivere l'anno scorso.

Rivedendo il codice ho avuto un sussulto di terrore. Oltre ad essere brutto
stilisticamente, era orripilante anche come APIs. Di fatto mi costringeva a
salvare in un file temporaneo quanto inserito dall'utente per poi calcolare
le occorrenze delle parole.

Visto che sono in giro coi [mezzi pubblici](http://thesp0nge.com/2011/07/01/vita_senza_freni.html)
ieri durante il tragitto in metropolitana l'ho completamente riscritta. Ora
estende la classe String con un metodo to_tag_cloud che fa il suo porco
lavoro.

Ora l'utilizzo dell'API è veramente molto semplice. Dopo aver installato la [versione 0.99](https://rubygems.org/gems/wc)
o le successive quando ci saranno, potrete creare una tag cloud direttamente
dal vostro oggetto String.:

``` ruby
require 'wc'

puts "This is a very huge string".to_tag_cloud
```

Ok, non ho inventato la cura contro il cancro, però mi sembra un gran passo
in avanti. Soprattutto se devo integrare la mia piccola gemma in nuvola.

Ho deciso di rilaciare open sia nuvola che porkatpark.com quando ci sarà,
mentre pernataleiovorrei.com resterà chiuso assieme a codesake.com

Tante novità si stagliano all'orizzonte, per ora... buon compleanno [nuvola](http://nuvola.armoredcode.com)

