.de BP
.IP \(bu 2
..
.R1
database biblio
accumulate
.R2
.TL
Groff für Dokumentschreiber mit MS(Manuscript) (.TL)
.AU
Alexander Ginschel (.AU)
.ds RH Groff für Dokumentschreiber
.NH
.XN "Numbered Header -> gezählte Überschrift (.NH)"
.LP
Linker Heading (LH) (es gibt auch (CH und RH) -> geht nur so: .ds LH Das ist eine Überschrift oben links
.LP
Ein neuer Paragraph ohne, dass die erste Zeile eingerückt wird. (.LP)
.PP
Die erste Zeile des Paragraphen wird eingerückt. (.PP)
.SH
Kompiliation des fertigen Dokuments (ist .SH -> unbeziferte Überschrift)
.LP
groff -ms [dokumentname].ms -k -T pdf > [dokumentname].pdf
.LP
.B "Dieser Text ist fett gedruckt (.B '[]')" !
.LP
Das ! steht direkt zwei Zeichen nach ", damit das Ausrufezeichen richtig platziert wird!
.I "und nicht kursiv! (.I '[]')"
.BI "Text ist fett kursiv! Das erste Argument nach den Anführungzeichen steht nach dem Text, das zweite davor." ) (
.RS
.LP
Der Text ist eingerückt (LP wird mit .RS und .RE umzingelt)
.UL "und unterstrichen! (.UL)"
.LP
Übrigens lässt sich eine neue Seite mit .bp erzwingen.
.RE
.sp 2
Mit .sp 2 macht man zwei Zeilenumbrüche
.SH
Macros
.LP
Macros werden mit .de angefangen und enden mit ..
.LP
Hier als Beispiel: .de \ .IP BP \\n  \\(bu 2 \\n ..
.LP
Mit .BP wird das Macro dann aufgerufen. Man sollte Macros am besten in einer "macros" Datei abspeichern, um sie später mit .so macros in der ersten Zeile des Dokuments aufzurufen!
.SH
Listen
.LP
Mit .IP \\(bu 2 kann man Unterpunkte machen.
.LP
Wer abgezählte Listen haben will, muss es etwas komplizierter angehen... -> .nr step 0 1 .nr PI 3n und später -> IP \\n+[step]
.BP
Erster Unterpunkt
.BP
Zweiter Unterpunkt
.SH
Einfache Schreibweise von Code
.LP
.B1
Einfacher Code mit .B1 und .B2 und .br, um Zeilenumbrüche zu machen.
.br
def foo(k):
.br
	k = 72
.br
	return k
.br
print(foo(4))
.B2
.FS
Fußnote fängt mit .FS an und endet mit .FE
.NH 2
Eine Fußnote eine Stufe unter NH (.NH 2)
.NH 2
Eine weitere Fußnote eine Stufe unter NH (.NH 2)
.FE
.NH
.XN "Mathematische Formeln mit eqn"
.NH 2
Kompilation
.LP
groff -e [dateiname].ms -ms -k -T pdf > [dateiname].pdf
.NH 2
Deklarierung der Gleichungen
.EQ
define quad 'x = { -b +- sqrt { b sup 2 - 4ach }} over 2a'
delim $$
.EN
.LP
Man deklariert die eqn-Umgebung mit .EQ und endet sie mit .EN. Eine einfache Gleichung wie $f( x) = x sup 2$ lässt sich so schreiben: f( x ) = x sup 2

.LP
Um mathematische Gleichungen abzukürzen, verwendet man define [Kürzel] = '[Gleichung, die man einfügen will]'. Dann schreibt man das Kürzel in der eqn-Umgebung und erhält die gewollte Gleichung!
.NH 2
Delimiter
.LP
Delimiter benutzt man, um Gleichungen, innerhalb von Zeilen zu benutzen. Man schreibe einfach delim in die eqn-Umgebung und die gewollten Markierer, in welche man im Text seine Gleichungen packen will. bspw: delim ||
Und dann im Text | b = 2 sup {2-4ac}| -> $ b=2 sup { 2-4ac }$
.NH 2
Nützliche mathematischen Zeichen
.NH 3
sup
.LP
Es ist nichts anderes als das schon verwendete "hoch etwas" b = x sup 2 $b=x sup 2$
.NH 3
Mathematische Zeichen
.LP
| x!=3+-4 sub 0 >= r |  ->  $x!=3+-4 sub 0 >= r $
.NH 3
Vektoren (und auch Matrizen)
.LP
Mit vec lassen sich auch Vektoren darstellen: | x vec = sin( alpha ) *~ left [  pile { 4 above 2 } ~~pile { nu sub 1 above nu sub 2 } right ] |  ->  $ x vec = sin( alpha ) *~ left [  pile { 4 above 2 } ~~pile { nu sub 1 above nu sub 2 } right ] $
.NH 3
over
.LP
Es leitet den Bruchstrich ein: | 4 over 2 = 2 |  ->  $ 4 over 2 = 2  $
.NH 3
sqrt
.LP
Die Quadratwurzel illustriert mit der Mitternachtsformel: | x = { -b +- sqrt { b sup 2 - 4ach } over 2a' |  ->  $ quad $
.NH 3
Integral
.LP
Die Berechnung von pi: | pi = int from -1 to 1 dx over sqrt {1-x sup 2} |  -> $pi = int from -1 to 1 dx over sqrt {1-x sup 2}$
.NH 3
Summenformel
.LP
Eine Summenformel lässt sich mit sum schreiben: | s = sqrt { {sum from i=1 to N { x sub i - x bar }
.NH 3
Limes
.LP
Eine Limes lässt sich beispielsweise so schreiben: | lim from {n -> inf } x sub n =0 |  ->  $lim from {n -> inf } x sub n =0 $
.NH
.XN "Tabellen"
.LP
Tabellen sind recht leicht zu machen. Man sollte jedoch groff mit -tb kompilieren lassen! Der Inhalt wird übrigens durch Tab abgegrenzt.
.LP
.B1
 .TS
.br
allbox (man kann auch expand hinzufügen);
.br
c s s s
.br
c s c s
.br
l c c r.
.br
Überschrift
.br
Untersektion 1	Untersektion 2
.br
a 	a	a	a
.br
a	r	r	a
.br
a	a	a	a
.br
 .TE
.B2
.TS
allbox;
c s s s
c s c s
l c c r.
Überschrift
Untersektion 1	Untersektion 2
a 	a	a	a
a	r	r	a
a	a	a	a
.TE
.NH
.XN "Index"
.LP
Wenn man mit dem -mspdf macro statt -ms kompiliert, ist es möglich recht einfach einen Index mit.XN und .TC (wobei letzteres ganz ans Ende kommt) zu machen. Übrigens: sofern man den Index am Anfang statt am Ende des Dokumentes haben will, sollte man mit pdfroff statt groff kompilieren.
.B1
.br
 .NH
.br
 .XN "Titel von der Überschrift"
.br
 .TC (aber ganz am Ende)
.B2
.NH
.XN "Refer"
.LP
Um Bibliographien zu erstellen, erstellt man sich eine Bibliograpie-Datei und fügt sie so ein:
.br
%K -> das Schlüsselwort für die Bibliographie
.br
%A -> Der Autor
.br
%T -> Titel des Artikels/Textes
.br
%B -> Buchtitel
.br
%E -> Der Editor
.br
%I -> Veröffentlicher
.br
%D -> Das Datum
.br
Die einzelnen Referenzen werden mit einer Leerzeile voneinander getrennt.
.br
Im eigentlichen Groff-Dokument zitiert man mit:
.br
.B1
 .[
.br
[das Schlüsselwort]
.br
 .]
.B2
.NH 2
Kompilation
.LP
Die Kompilation funktioniert dadurch, dass man im Groff-Dokument mit
.br
 .R1
.br
database [Bibliotheksdateipfad]
.br
accumulate
.br
 .R2
.br
auf die Referenzen verweist und mit bspw: groff -R -k -tb -e -mspdf -T pdf anleitung.ms > groffanleitung.pdf kompiliert.
.[
einverweis
.]
.TC
