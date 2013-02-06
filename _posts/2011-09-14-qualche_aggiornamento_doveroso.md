---
date: 2011-09-14 12:11:46 +0200
layout: post
publish: true
tags: aurora appsec owasp life taekwondo daniele
title: "Qualche aggiornamento doveroso"
place: Gessate
---

Iniziamo subito col dire che da due giorni vado in giro con un occhio nero.
Merito di un bel calcio in faccia ricevuto in allenamento. Quest'anno abbiamo
cambiato fisicamente la palestra ma ci stiamo allenando veramente alla
grande, sono molto soddisfatto e non vedo l'ora arrivi qualche gara.

Ho apprezzato, nelle ultime due settimane un po' di cose tenerissime che fa
mio figlio. Ormai, quando vuole farmi vedere una cosa arriva, mi prende la
mano dicendo solo 'Mano' e poi dice 'Andiamo'. Se solo hai l'ardire di
domandare 'Dove andiamo?' la laconica ma scontata per un quasi 2enne sarà
'là'.

Un'altra cosa dolcissima è questa. Mio figlio, da buon scorpioncino, non ti
da la soddisfazione di un bacio o di un abbraccio quando richiesto... se lo
deve sentire lui. Ogni tanto capita quindi che sono lì vicino e mi prende
entrambe le orecchie con le sue manottole cicciose e mi stampa un bacione.
Non ho ancora trovato una forma più bella d'affetto.

Venenedo a cose più geek e più legate al mondo dell'application security, in
questi giorni ho buttato un po' di codice nel mio progetto [aurora](http://aurora.armoredcode.com)

Il branch [lab](https://github.com/thesp0nge/aurora/tree/lab)
è sicuramente quello più interessante per chi vuole partecipare al progetto,
ma anche per chi è solo interessato ad usarlo come tool. In fatti nel branch [master](https://github.com/thesp0nge/aurora)
per ora non c'è molto codice stabile che sia anche significativo. Anche se
tra un po' rilasceremo, non appena il crawling sarà decente.

[Questo](https://github.com/thesp0nge/aurora/commit/fe23dc0f8f02f86b124b66206c2dbe3e61e204ba)
commit introduce il supporto per le opzioni da command line e viene preso il
primo parametro che non sia un flag come nome del file o della directory da
utilizzare per l'analisi del codice.

Prossimamente voglio dare la possibilità di fare il crawling dando anche un
database di parole chiave che sia significativo... tuttavia per rilasciare
una versione 0.20 voglio dare una API consistente per questo servizio. Per
fare questo devo sicuramente introdurre una struttura che modelli il file da
revisionare.

Pensavo di utilizzare i puntatori a funzione, prendendo spunto da altri
progetti opensource, per modellare la programmazione OO ed aggangiare lexer e
parser diversi alla stessa struttura dati a seconda del formato del file.

Questo mi consentirebbe di avere un'unica struttura dati per il file e di
poterla riutilizzare nelle routine di scansione in maniera trasparente da
quale coppia di analizzatori è stata utilizzata per quel particolare file.
