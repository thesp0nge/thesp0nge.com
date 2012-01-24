---
date: 2011-07-06 07:56:06 +0200
layout: post
publish: true
categories: xss owasp appsec cross hacking ruby rails sinatra hf4
title: "Passeggiata nei xss: strategie di difesa"
place: Gessate
---

La [scorsa](/2011/07/04/passeggiata_nei_xss.html)
volta abbiamo parlato un po' di [Cross site scripting](https://www.owasp.org/index.php/Cross-site_Scripting_(XSS) )
e non abbiamo neanche detto tutto. Vi rimando alle risorse di [Owasp](http://www.owasp.org)
per un elenco esaustivo di attacchi e contromisure.

Di cosa parliamo oggi? Oggi chiacchieriamo su quale sia una possibile _strategia_
da attuare all'interno delle nostre applicazioni web.

Come al solito tutto sarà abbastanza _agnostico_ rispetto al linguaggio di programmazione che voi utilizzate. Farò esempi
usando Ruby, voi adattateli alla vostra realtà. Tanto i concetti alla base sono quelli.

Mi rifaccio ad un'architettura _MVC_ e per ora metterò da parte le performance.

Un aspetto molto importante quando parliamo di sicurezza applicativa è il tradeoff
tra il livello di sicurezza che si vuole ottenere e le funzionalità
applicative. Trovare questo punto è il compito di ogni Appsec specialit che
avete nel team.

L'idea è semplice... la sicurezza al 100% non esiste.

Quello che possiamo ottenere invece è un elevato livello di sicurezza
aggiungendo controlli che rallentano di fatto la nostra applicazione. 

Il tradeoff sta nel valutare i punti dove la penalità in performance è giustificata dalla
sensibilità dei dati esposti ad un attaccante.

Gli entry point per un nostro attaccante sono sostanzialmente

* le form
* i parametri dell'url
* la richiesta HTTP

Tutti e 3 i punti di ingresso sono gestiti dal nostro controller. Quindi la
tentazione è di mettere tutti i controlli di sicurezza nel controller che,
dal nome, si presta molto bene.

Beeep.


_Risposta sbagliata._

Best practice che il mondo Rails può prestare anche agli altri è quello di avere [controller snelli](http://blog.devinterface.com/2010/06/rails-best-practices-1-fat-model-skinny-controller/)
e di avere i modelli cicciotti, dove cicciotti è il termine tecnico che indca
che tutta la business logic deve risiedere lì.

Dopotutto gestiscono i dati. Il core. La ciccia di tutto è lì.

Convenuto questo stendiamo la nostra strategia... cosa mettiamo e dove lo
mettiamo? [1](#1)

Allora un primo filtro lo metterei nelle viste. Loro mostrano il dato, quindi
sono il punto giusto dove mettere un metodo _helper_
che mostra una versione del dato che sia _sanitized_

Perché non farlo nel controller? Perché il compito del controller è quello di
recuperare i dati dal modello e presentarli alla vista. Il compito della
vista è quello di presentarli. Se il problema è 'devo presentarli in maniera
safe', allora è compito della vista.

Tutto quello che viene prelevato dal mondo esterno quindi entra nel nostro
controller e quando arriva alle viste viene sanitizzato e mostrato a video.

Perfetto, ora pensiamo al modello. Ve la ricordate la storia dello stored xss
vero?

Io non so se il vostro framework vi mette a disposizione dei callback, [ActiveRecord](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)
lo fa e suggerisco di sfrutta il before_save.
Nel before_save possiamo definire un handler che va a fare sanitize dei campi prima di scriverli sul database.
Se qualcuno sta pensando:

{% blockquote %}
Ma se ho messo i controlli sulla vista che senso ha metterli anche nel
modello? Quando il dato verrà mostrato allora sarà sanitizzato lì,
{% endblockquote %}

allora forse non ho spiegato bene il pericolo legato agli stored xss.

Quel dato potrebbe essere letto anche dal altre applicazioni che non siano la
nostra, risultando quindi in un possibile punto di inject del pattern
d'attacco.

Oppure, poichè nessuno è perfetto, potrebbe succedere la classica svista nei
controlli della view e quindi anche la nostra app risulterebbe vulnerabile.

Se la penalizzazione nell'introdurre questo controllo nel callback è per voi
troppo onerosa, è ok... non mettete nessun controllo ma sappiate che avete
scoperto un possibile punto di iniezione.

Dal punto di vista della security, conoscere il proprio rischio e sapere che
non è possibile mitigarlo è assolutamente ok. Come ho detto prima, la
sicurezza totale non esiste, la consapevolezza del proprio livello di
sicurezza invece è qualcosa di cui ogni PM può trarre beneficio, e che
purtroppo pochi hanno.

Spero che la chiacchierata sulle strategie di difesa vi sia piaciuta. 
%br
Mentre scrivevo questo post sono andato a rivedere il codice di [Esapi Ruby](https://github.com/thesp0nge/owasp-esapi-ruby)
ed ho notato che ha subito una deriva troppo marcata verso il porting puro dalla versione Java.

Il codice è poco _rubesco_
e sinceramente credo introdurrò qualche helper e qualche estensione alle
classi base del linguaggio piuttosto che seguire l'approccio di un javista.

[1](#1): scrivere un'applicazione web vulnerabile a XSS usando rails è un bel
lavoro. Il framework si preoccupa di sanitizzare i dati che arrivano alla
view. Quindi in realtà molte cose che avete letto vi vengono regalate dal
framework. Comunque voi pensate sempre di non avere alle spalle nulla... fa
sempre bene.

[2](#2): tutto quello che avete letto in questo post è ovviamente la mia
opinione, una delle possibili strategie su come piazzare i controlli di
sicurezza.

