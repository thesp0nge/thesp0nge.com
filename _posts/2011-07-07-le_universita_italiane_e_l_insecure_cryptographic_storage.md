---
date: 2011-07-07 09:16:25 +0200
layout: post
publish: true
lang: [it]
categories: owasp password database italia banfa università webapp appsec pentest code-review attacco-informatico
title: "Le università italiane e l'insecure cryptographic storage"
place: Gessate
---

Ne parla [Il Messaggero](http://www.ilmessaggero.it/articolo.php?id=155224&sez=HOME_SCIENZA)
, ne parla [La Repubblica](http://www.repubblica.it/tecnologia/2011/07/06/news/hacker_di_nuovo_all_attaco_stavolta_delle_univesit_italiane-18761507/)
, ne parla [Il Corriere della Sera](http://www.corriere.it/cronache/11_luglio_06/hacker-universita_a1303f04-a7f2-11e0-80dd-8681c9f51334.shtml)
, ne parlano quindi i principali organi di stampa italiani. Di cosa? Di [questo](http://twitter.com/#!/LulzStorm/status/88377625680158720)
  questo.

Ieri un sedicente gruppo che si fa chiamare LulzStorm, ha annunciato di aver
bucato alcune web app di Università Italiane e di aver messo online il dump
di alcuni dati contenenti informazioni sensibili come credenziali di accesso
e numeri di telefono.

Gli organi di stampa, ovviamente per vendere copie, si soffermano
sull'aspetto dell'attacco... di quanto cattivi siano gli hacker che si
intrufolano di notte nelle banche dati altrui e che sottraggano dati preziosi
ad ignari contribuenti che dormono tranquilli nelle loro case insieme alla
moglie e a due (rigorosamente due) figli, uno maschio e uno femmina con i
capelli a caschetto ed un cane bianco in una casa immacolata e piena di luce.
Tutti perfettamente pettinati e felici alle 7 della mattina raccolti attorno
al tavolo per mangiare i biscottini.

<iframe width="425px" height="349px" src="http://www.youtube.com/embed/6bjQOwXMoPk" frameborder="0" allowfullscreen="true">
</iframe>

Gli articoli riportano le dichiarazioni dei rettori. Io le riporto virgolettando. Poi dico la mia

* Dalla Bicocca fanno sapere che «il sistema di autenticazione non è stato violato»,  CorSera
* L'attacco riguarderebbe «il sito della facoltà di Psicologia che è gestito in outsourcing, hanno preso indirizzi email e nominativi», CorSera
* Anche qui l'ateneo spiega che «sono informazioni molto generiche sulla
  didattica e sono state prese dal sito di un dipartimento ormai poco
  utilizzato». E non solo: «Le password che appaiono nel file degli
  hacker, che in qualche caso sono state decodificate, non sono quelle
  istituzionali», CorSera
* Anche il rettore della Sapienza di Roma sminuisce l'entità dell'attacco:
  "E' stato respinto". "Non sono stati rubati dati rilevanti - conferma il
  rettore - Abbiamo una Facoltà di Ingegneria informatica e statistica che
  non ha eguali, e di questo vado molto fiero. Era accaduto anche qualche
  tempo fa che provassero ad entrare nei nostri database",  Repubblica

L'ultimo, il commento del rettore della Sapienza è il più esilarante.
L'atteggiamento che permea è il classico atteggiamento di chi subisce
un'intrusione:

* negare l'evidenza - mi hanno bucato
* minimizzare l'accaduto - i dati non sono rilevanti / il sistema è poco usato
* cambiare discorso - abbiamo una facoltà che non ha eguali...

Purtroppo nessuna delle massime testate del nostro Paese fa delle domande che
appaiono lecite e che vengono subito in mente ad una persona che fa
application security di professione:

{% blockquote %}
  Ma come è possibile che nel 2011 delle istituzioni memorizzino le password
  e altri dati sensibili in chiaro sul database o utilizzando metodi di
  cifratura deboli che ne consentono la semplice decodifica?
{% endblockquote %}

O ancora

{% blockquote %}
  Ma come è possibile che nel 2011 mettiamo online applicazioni che trattano
  dati personali senza il minimo test?
{% endblockquote %}

Purtroppo nessuna delle massime testate del nostro Paese si sofferma sul
fatto che la legge sulla Privacy chiede che i dati sensibili degli utenti
siano memorizzati in forma offuscata su supporti magnetici.

L'Italia ha una legislazione molto forte a tutela del dato... mi chiedo come
mai le massime istituzioni della scienza del nostro paese permettano a
cioccolattai di mettere in piedi un'applicazione web e un database non
curandosi i minimi principi di sicurezza.

Le Università sono fucine di cervelli... li studiano gli IT di domani... in
ogni Ateneo c'è almeno un corso o un docente che si occupa di sicurezza
informatica, ma perché, dico io, nel 2011 non si riesce ad organizzare
internamente corsi di sviluppo sicuro, code review e penetration test sui
propri siti istituzionali?

Non parlatemi di costi. Avete gli studenti. Che sia il loro progetto pratico
d'esame, presentare un pentest e una code review del codice del sito
istituzionale dell'Ateneo.

Volete mettere l'impegno che profonderebbero per avere un 30?

Volete mettere il beneficio di immagine che ne avrebbe l'Università poi? A
non farsi bucare dal primo che passa? A non doversi inventare proclami
assurdi come quelli del rettore romano?

Andiamo un po' alla teoria. Owasp raggruppa il rischio di memorizzare dati
sensibili in forma non cifrata nella settima voce della sua [Top 10.](https://www.owasp.org/index.php/Top_10_2010-A7)

Spiega il rischio e spiega come proteggersi.
Bastava solo leggerla, ma il cioccolattaio di turno forse aveva aperta la
pagina della gazzetta mentre stava mettendo online quel codice.

Quello che emerge è questo:

* in alcuni atenei non si fa safe coding
* in alcuni atenei non si fanno pentest e/o code review
* in alcuni atenei si ignorano le leggi italiane in materia di protezione dei dati sensibili
* i rettori di alcuni atenei invece di affrontare il problema, minimizzano l'accaduto 
* la stampa del nostro paese invece di evidenziare la palese lacuna di chi mette online del codice scadente, punta il dito contro l'hacker cattivo

<iframe width="425px" height="349px" src="http://www.youtube.com/embed/3Z56nLo5sD0" frameborder="0" allowfullscreen="true">
</iframe>
