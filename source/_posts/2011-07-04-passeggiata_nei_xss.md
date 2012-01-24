---
date: 2011-07-04 08:10:09 +0200
layout: post
publish: true
categories: appsec xss owasp cross hacking ruby rails sinatra hf4
title: "Passeggiata nei xss"
place: Gessate
---

Una doverosa premessa, questo post è scritto con un tono ironico per
alleggerire l'argomento di oggi: i Cross site scripting appunto. La
vulnerabilità tuttavia è abbastanza fastidiosa e diffusa al punto tale da
essere una delle issue più serie quando si parla di sicurezza del codice web.

Chiariamo subito una cosa: i [Cross site scripting](https://www.owasp.org/index.php/Cross-site_Scripting_\(XSS\))
sono una vulnerabilità _lato client._

E' assolutamente vero che può essere sfruttata per la mancata adozione di
tecniche di programmazione difensiva lato server, tuttavia il codice
iniettato dall'attaccante viene sempre eseguito dal browser del nostro
utente. 

Si noti altresì come non basta che l'attaccante riesca ad iniettare (con una
form, con parametri della request HTTP o con parametri nell'URL) il pattern
d'attacco per poter sfruttare il XSS. Il browser dell'utente deve navigare
sulla pagina dove il valore prelevato dall'attaccante viene utilizzato nella
costruzione della pagina html, in questo caso il codice dell'attaccante verrà
eseguito. 

Per assurdo, se la variabile incriminata non venisse mai usata nell'html in
uscita, supponiamo ad esempio che venga scritta su un file e mai più
utilizzata, la vulnerabilità sarebbe impossibile da sfruttare. Per i
birichini all'ascolto, si in caso di code review ve la segno lo stesso come
vulnerabilità, di sicuro però il livello di pericolosità della stessa sarebbe _low._

L'equivalente della minaccia fantasma dei XSS è la cateogoria degli _stored xss._

Ve la racconto con un esempio pratico, trovato durante un'attività qualche
tempo fa (tra l'altro quest'esempio dimostra che non tutto può essere trovato
con un penetration test, ma la code review serve proprio... mettetela a
budget la prossima volta).

Il mio cliente aveva una form di inserimento dati per permettere alle persone
che frequentavano i corsi di aggiornamento da lui organizzati di lasciare un
feedback. Questo feedback veniva poi utilizzato in un'applicazione intranet
di HR per fare del data mining.

Il penetration test non aveva evidenziato alcuna vulnerabilità. Tuttavia
andando ad analizzare il codice, mi accorsi che il dato inserito nella form
veniva salvato senza validazione in questo database condiviso tra le
applicazioni interne del cliente.

Una POST al volo sulla form ed avevo confermato lo stored XSS, che permetteva
all'attaccante di inserire dall'esterno del codice javascript che veniva
eseguito dall'utente delle risorse umane nell'intranet aziendale. 

Anche in questo caso, spero di avervi convinto... la vulnerabilità è lato
client.

Ok, perfetto... ora vi mostro un po' di codice ruby vulnerabile al XSS. Ho
faticato per scriverlo, ho dovuto usare Sinatra in maniera ignorantissima per
scrivere una form vulnerabile, però come esempio può andare bene.

Questo è il codice che risponde ad una POST sulla homepage dell'applicazione
vulnerabile.

``` ruby Questo codice è vulnerabile a Cross Site Scripting, non usatelo.
post '/' do
  @you = (params[:subscriber][:email])
  haml :index, :layout =>:'layouts/default'
end
```

Nella view, rendiamo sfruttabile la vulnerabilità e scriviamo la form in
maniera assolutamente illogica.

Ho usato HAML come linguaggio per le view.


``` ruby Questo codice è vulnerabile a Cross Site Scripting, non usatelo.
-if !@you.nil?
  Hello 
  =@you

%form{:action=>'/', :method=>'post', :id=>'subscriber'}
  %p
    %label{:for=>'email'}Subscribe to codesake.com updates (we wont spam... we promise!)
    %br
    %input{:type=>'text', :name=>'subscriber[email]', :placeholder=>'Enter your email address', :id=>'email', :size=>'50'}
    %br
    %input{:type=>'submit', :value=>'Subscribe &rarr;'}
```

Dov'è la vulnerabilità? All'inizio quando saluto l'utente usando una
variabile inizializzata nel mio controller con il valore preso dalla form.

Con questo esempio voglio dire che:

* prendere valori che arrivano dall'esterno nei nostri controller è
pericoloso. Seguendo la programmazione difensiva tutto quello che viene
dall'esterno va messo in quarantena, sanitizziato e poi salvato su db,
usato nell'html... insomma una volta che l'avete reso innocuo potete
farci quello che volete.

* quando un attaccante vede una form o un parametro della request, proverà
a metterci un pattern d'attacco per XSS. Partite da questi ed usate le
[ESAPI](https://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API)
per fare sanitize.

* i parametri della richiesta HTTP non sono al sicuro. Sanitizzate anche quelli.

Nonostante la soluzione al problema sia conosciuta e di semplice attuazione,
i XSS sono la vulnerabilità web più diffusa sintomo forse che le tecniche di
programmazione sicura non sono ancora ampiamente diffuse nelle grandi
enterprise.

Per saperne di più su programmazione sicura ed altro state sintonizzati qui.
