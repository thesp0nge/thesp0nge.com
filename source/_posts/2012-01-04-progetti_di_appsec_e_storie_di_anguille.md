---
layout: post
publish: true
categories: appsec, opensource, owasp, progetti, sast, code review, penetration test, dast, anonymous
title: "Progetti di appsec e storie di anguille"
url: 
place: Sottomarina di Chioggia
date: 2012-01-04 08:29
---

Apro mille parentesi, procrastino e spesso non ne chiudo manco una. Un mio
difetto, forse il peggiore. Almeno se escludiamo il fatto che sono permaloso.
Lo scriveranno un giorno sul mio epitaffio: 
{% blockquote %}
  "qui giace Paolo Perego, apritore seriale di parentesi"
{% endblockquote %}

La realtà è che ho mille idee e sono incline all'entusiasmarmi. Arrivo quindi
ad avere un casino immane sul mio [github]('https://github.com/thesp0nge') e a
perdere il filo.

Ho iniziato [flender]('https://github.com/thesp0nge/flender') con lo scopo di
creare un bot che andasse a scandagliare i repo su github per fare code review
in autonomia. Questo è poi il cuore di quello che voglio fare con codesake.com.
Di fatto è sempre in background nella mia testa. Di sicuro lo finirò prima o poi.

[discovery](https://github.com/thesp0nge/discovery') è una new entry, un tool
per fare il discovery delle porte strane aperte in sottoreti. La cosa carina è
che per la prima volta ho dato ad un mio bot un'interfaccia web scritta con
sinatra. Praticamente finito.

[aurora]('https://github.com/thesp0nge/aurora'9 nasce come tool opensource per
la code review ma alla fine mi sa che diventerà un collettore di tutti i micro
progetti che sto scrivendo, una specie di framework globale.

[cross]('https://github.com/thesp0nge/cross') era un esempio di come si poteva
usare nokogiri e mechanize per automatizzare il submit di vettori di attacco in
form html e verificare se era possibile un XSS. Praticamente è una POC. Se
curassi di più lo spidering, il censimento delle form e l'output non sarebbe
neanche male come tool.

Ah già... spidering... [enchant]('https://github.com/thesp0nge/enchant') il mio
piccolo spider che usando un dizionario andava a fare brute force per
indovinare il layout dei siti... alla fine un po' di persone hanno scaricato
la gemma anche se nn ho mai avuto feedback.

Alla fine credo che tutti questi saranno pezzetti di aurora e che questo possa diventare il motore alla base di codesake.com.

La mia idea di fondo è:

* API RESTful usando Sinatra
* output su DB usando un ORM come Datamapper

Combinando questi pezzi dovrebbe venirne fuori qualcosa di veramente divertente...
