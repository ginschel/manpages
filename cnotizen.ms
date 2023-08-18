.ds RH Kurzanleitung zu C/C++
.de cs
.LP
.B1
.
..
.de ce
.B2
..
.TL
Kurzanleitung zu C/C++
.NH
Datentypen
.LP
int, float, bool, char, size_t, double, long double. Diese können signed, unsigned und const sein. unsigned int ist das selbe wie size_t. (size_t muss jedoch mit stddef.h oder cstddef inkludiert werden. Bei letzterem ist std::size_t von Nöten.)
.NH
Präprozessor
.LP
Der C/C++ Compiler inkludiert erst die deklarierten Header Files und compiliert danach die einzelnen cpp Programme und übersetzt die als Objektdateien .o, um sie im Linker mit den benötigten Bibliotheken zu verbinden und aus ihnen das ausführbare Programm zu erstellen.
.sp
header.h -> #include/Praprozessor-Anweisung -> main.c/cpp -> Compiler -> main.o -> Linker (verknüpft mit Bibliothek) -> main.exe (oder main auf Linux)
.NH
Präprozessor-Anweisungen
.cs
#ifndef HEADER_H
.br
#define HEADER_H
.br
void foo(int c);
.br
#endif
.ce
Diese im Header deklarierte Funktion kann später in mehreren Quelldateien mit #include "header.h" inkludiert werden (C's bzw C++'s eigene Header werden mit < > eingerahmt statt mit zwei Anführungszeichen). Die Funktion muss nur in einer Quelldatei definiert werden, da der Linker am Ende eh den Code in einer Datei zusammenfasst.
.NH 2
Globale Konstanten und Variablen
.LP
In Header Dateien werden Variablen ganz normal definiert, in der Quelldatei muss die Variable aber mit extern [datentyp] [variablenname]; deklariert werden.
.LP
Konstanten werden mit constexpr const [datentyp] [Konstantenname] = [Wert]; in der Header Datei definiert und mit extern const [datentyp] [Konstantenname]; in der Quelldatei deklariert und importiert. constexpr gibt es aber nur in C++, extern funktioniert aber in C wie auch C++.
Der Sinn von constexpr ist eine Konstante zu haben, die wirklich nicht geändert werden kann, im Gegensatz zu einer const. Dies sorgt dafür, dass der Compiler schon beim Compilieren weiß, dass sich diese Konstante auch nicht ändern wird. Es funktioniert auch als Sicherung.
.NH 2
Lokale Variablen und Funktionen
.cs
static int x = 2; //die Variable ist lokal und kann nur in ihrer Funktion bzw Quelldatei verwendet werden
.br
static int foo(); //die Funktion kann nicht von anderen Quelldateien außer der eigenen verwendet werden
.ce
.NH 2
Makro Definition
.LP
Makros sind die wahren Konstanten, die nicht geändert werden können, denn const Variablen sind nur begrenzt schreibgeschützt und können je nach Compiler mit Pointern geändert werden.
.cs
#define pi 3.14
.br
float x = pi;
.ce
.NH
Namespaces
.LP
Man kann verschiedene Funktionen in C++ mit dem selben Namen haben, mann sollte diese aber dann in einen Namespace eintragen, um Konflikte mit anderen Funktionen zu vermeiden. Man deklariert einfach die Funktion innerhalb eines Namespaces und greift auf sie später mit dem selbst gewählten Namespace zu.
.cs
namespace foo {
.br
void foof();
.br
}
.br
foo::foof(); //Zugrif auf foof aus foo namespace
.br
using namespace std; //importiert std
.ce
.NH
Kommentare
.LP
//   -> kommentiert den Rest einer Zeile
.br
/*      */  -> alles, was zwischen /* und */ steht, wird herauskommentiert.
.NH
Casting
.LP
.TS
allbox;
c s s
c c c
c c c.
Casting
Erklärung	C	C++
Konvertierung zu int	(int) preis;	static_cast<int>(preis);
.TE
.NH
Binäroperationen
.LP
AND: 4 & 2 -> 0100 & 0010 -> 0000 -> 0
.br
OR: 4 | 2 -> 0100 | 0010 -> 0110 -> 6
.br
XOR: 6 ^ 2 -> 0110 ^ 0010 -> 0100 -> 4
.br
NOT: ~6 -> ~0110 -> 1001 -> 9
.br
Linksverschiebung(Verdopplung): << 2  -> <<0010  -> 0100 -> 4
.br
Rechtsverschiebung(Halbierung): >> 2  -> >>0010  -> 0001 -> 1
.NH
Modulo
.LP
4 % 2 = 0 -> die Zahl ist rund
.br
3 % 2 = 1 -> die Zahl ist ungerade
.NH
Pointer
.LP
.cs
int *p = &a; //Pointer p zur Adresse von int a
.br
*p; //gibt den Wert aus, auf den p hinzeigt
.br
const char* string = "ein string"; //ein Char-Zeiger, der auf einen konstanten C-String zeigt
.br
Dieser string Pointer ist ein Char-Pointer, der auf einen Char-array deutet.
.br
int * const pointer; //Dies wäre ein konstanter Pointer auf einen Integer. Ergo der Pointer ist unveränderbar und nicht sein Wert wie beim string oben (man liest die Deklarierung von rechts nach links)
.ce
In C++ gibt es des Weiteren noch den nullptr, was man Pointer zuweisen kann, die auf nichts zeigen sollen. (In C würde man NULL oder 0 verwenden)
.NH
Kommandozeilargumente
.cs
#include <stdio.h>
.br
int main(int argc, char* argv[]) { //argc=Argumentezähler, argv=Array mit Argumenten
.br
printf("Die Eingabe war: %s\\n",argv[0]);
.br
return 0;
.br
}
.ce
Mit "./[programmname] hi" lässt sich das dann aufrufen.
.NH
Typedef
.cs
typedef [datentyp] [neuerdatentypsname];
.br
[datentyp] foo = 3;
.br
typedef [datentyp] [name][4]; //geht auch für arrays (oder auch pointer)
.br
[name] arr = {1,2,3,4}; //Initialisierung
.br
typedef struct [datentyp] {} [alias]; //und structs
.ce
.NH 2
Alias mit using
.LP
In C++ gibt es die Möglichkeit nicht nur mit typedef einen Alias für einen Datentyp zu definieren, sondern auch mit using.
.cs
using [alias] = [datentyp];
.br
[alias] foo = 2;
.ce
.NH
Enums/Aufzählungen
.LP
Enummerations/Aufzählungen bzw enums sind selbst geschriebene Datentypen, dessen Werte programmintern nur eine Aufzählung der Werte in ihrer Reihenfolge darstellt.
.cs
//in C (einfache Version)
.br
typedef enum { sternjaeger, transportschiff } Raumschiff; //komfortable Deklarierung
.br
Raumschiff raumschifftyp = transportschiff; //transportschiff gibt 2 aus
.br
//in C (ohne typedef)
.br
enum Raumschiff { sternjaeger, transportschiff };
.br
enum Raumschiff raumschifftyp = transportschiff; //hier wird enum bei der Deklaration gebraucht
.br
//in C++
.br
enum class Raumschiff { sternjaeger, transportschiff };
.br
Raumschiff raumschifftyp = Raumschiff::transportschiff;
.ce
.NH
Random
.cs
#in C
.br
#include <time.h>
.br
#include <stdlib.h>
.br
srand(time(NULL)); //generiert einen "zufälligen" Seed für rand
.br
int r = rand % 30 +1; //generiert Zahl zwischen 0+1 und 29+1
.br
#in C++
.br
#include <random>
.br
std::random_device rd; //generiert eine zufällige Zahl zwischen rd.min() und rd.max()
.br
std::uniform_int_distribution<int> verteilung(0,1000); //erzwingt die Verteilung auf Werte zwischen 0 und 1000
.br
int zufallszahl = verteilung(rd); //generiert Zahl von 0 bis 1000
.ce
.NH
Goto
.cs
for(int i = 0; i < 20; i++) {
.br
for(int s = 0; s < 50; s++) {
.br
if(i == 4 && s == 48) goto Labelname; //ist sehr praktisch, um schnell und einfach doppelte Schleifen zu beenden
.br
}
.br
}
.br
Labelname:                                                                           //springt direkt in diese Zeile und beendet die Schleifen
.ce
.NH
Input und Output
.cs
#in C
.br
#include <stdio.h>
.br
int main() {
.br
int a; scanf(%d,&a); //Wert der Eingabe wird an die Adresse von a geschickt
.br
printf("%d\n",a); //a wird in der Konsole ausgegeben
.br
return 0;
.br
}
.br
#in C++
.br
#include <iostream>
.br
#include <string>
.br
int main() {
.br
int a; std::cin >> a; //a wird dem Wert der Eingabe zugewiesen
.br
std::string c,s; std::getline(std::cin,c); std::cin.get(s); //speichert ganze Eingabezeile ab statt Leerzeichen zu überspringen
.br
std::cout << std::to_string(a) <<" " << c << " " << s << std::endl; //gibt alles wieder in einer Zeile aus. Integer müssen zu strings konvertiert werden
std::cerr << "Fehlermeldung" << std::endl; //Fehlermeldung im Fehlerkanal und nicht im normalen Ausgabekanal!
.br
return 0;
.br
}
.ce
.NH 2
Bemerkungen
.LP
Bei printf bedeutet %s->string, %d -> Variable, %p -> Pointer, %c -> Character.
.NH
Compilation
.LP
Für C:
.cs
gcc [C-Datei].c -o [programmname] && ./[programmname]
Arraygröße	sizeof(feld)/sizeof(*feld)	feld.size()
.ce
.LP
Für C++:
.cs
g++ [C-Datei].c -o [programmname] && ./[programmname]
.ce
.NH
Chrono
.LP
Dies gilt nur für C++. In C gibt es keine C eigene Methode Zeitintervalle zu messen.
.cs
#include <chrono>
.br
std::chrono::time_point<std::chrono::steady_clock> start,ende;
.br
start = std::chrono::steady_clock::now(); //Starter vom Timer
.br
std::cout << "foo\n"; //ein beliebiger Befehl
.br
ende = std::chrono::steady_clock::now(); //Ende vom Timer/der Stoppuhr
.br
std::chrono::duration<double> vergangen = end - start;
.br
std::cout << vergangen.count() << std::endl; //gibt vergangene Sekunden aus
.br
auto millis = std::chrono::duration:cast<std::chrono::milliseconds>(vergangen); //konvertiert in Millisekunden
.br
std::cout << millis.count() << std::endl; //gibt in Millisekunden aus
.ce
.NH
Malloc
.LP
.TS
allbox;
c s s
c c c
c c c.
Dynamische Speicheränderung
Erklärung	C	C++
#include	<stdlib.h>	N/A
Erzeugen	char* s= (char*) malloc(sizeof(char)*4);	[datentyp]*p; p=new [datentyp];
sicheres Erzeugen	(char*) calloc(4,sizeof(char));	ist schon sicher
Speicherkopie	memcpy(sneu, s, sizeof(sneu));	[datentyp] neu_p = p;
Speicherkapazitätsänderung	(char*) realloc(s,2*sizeof(char));	arrayzeiger = new {datentyp}[anzahl];
Speicher löschen	free(s);	delete p;
.TE
.NH
Systembefehle
.LP
Dies geht in C wie auch C++. In C++ kann man jedoch auch std::system benutzen.
.cs
system("htop"); //ruft über die Kommandozeile des Betriebssystems htop auf
.ce
.NH 2
Bemerkungen
.LP
new -> ist eher für Objekte gedacht. Der pointer funktioniert nach der Datentypszuweisung wie der neue Datentyp und nicht wie ein Pointer. (Es ist auch möglich Arrays damit zu erzeugen)
.br
calloc -> erzeugt im Gegensatz zu malloc einen Speicherpointer, der nur Nuller enthalten darf
.br
memcpy -> fügt direkt in den neuen Speicherpointer ein, keine Zuweisung ist erforderlich (in C++ gibts auch std::memcpy)
.br
realloc -> vereint in sich malloc, memcpy und free in einem
.NH
Grundlegende Programmstrukturen
.NH 2
if
.cs
if (!Bedingung && Bedingung || Bedingung) {
.br
 ...
.br
}
.ce
.NH 3
Auswahloperator
.cs
int a = 5 > 1 ? 23 : 1; //das selbe wie int a; if(5 >1) a= 23; else a = 1;
.ce
.NH 2
switch
.cs
switch(a) {
.br
case 1:
.br
 ...
.br
break;
.br
case 2:
.br
 ...
.br
break;
.br
default:
.br
 ...
}
.ce
.NH 2
While
.cs
while (Bedingung) {
.br
 ...
.br
}
.ce
.NH 3
do-while
.cs
do {
.br
 ...
.br
} while(Bedingung);
.ce
.NH 2
for-Schleife
.cs
for(int i = 0: i < 20; ++i) {
.br
 ...
.br
}
.ce
.NH 3
Direkter Zugriff auf alle Arrayelemente (geht nur in C++)
.cs
for(auto i : array) {
.br
 ...
}
.ce
.NH 2
Funktionen
.cs
int foo(int a) { // [datentyp] funktionsname([datentyp] a) { (als Datentyp kann man auch eine selbst definierte Klasse oder struct nehmen)
.br
 ...
.br
return [int-Wert]; // [datentyp] wird zurückgegeben (void braucht das nicht)
.br
}
.br
foo(5); // Funktionsaufruf
.ce
.NH 3
Funktionspointer
.cs
int add(int n, int m) { return n+m; } //Funktionsdefinition
.br
int (*pointerzuadd)(int,int); // [Rückgabetyp (void bei void Funktionen)] [*funktionspointer] [funktionsparametertypen]; bzw der Funktionspointer wird erzeugt
.br
pointerzuadd = &add; //Pointer wird Funktion zugeordnet
.br
int sum = (*pointerzuadd)(2,3); //Aufruf
.ce
.NH 3
Übergabe per Referenz in Funktionen (nur in C++)
.cs
int add(int& c) { ... }; //in C++ wird so die Variable komplett übergeben statt wie in C erst einmal die Variablenadresse einem Pointer zu übergeben
.ce
.NH 3
Überladung von Funktionen
.cs
int quadrat(int i) {
.br
return i*i;
.br
}
.br
double quadrat(double i) {
.br
return i*i;
.br
}
.LP
Nun ist quadrat() überladen und je nach dem welchen Datentyp quadrat() übermittelt, wird eine andere Funktion aufgerufen.
.cs
quadrat(2);   //   -> ruft int Funktion auf
.br
quadrat(2.0); //   -> ruft jedoch double Funktion auf
.ce
.ce
.NH 3
Lambdas
.LP
Aufbau einer Lambda Funktion: [Liste aus Variablen, die aus der Quelldatei importiert werden] (Parameter für die Funktion, die beim Aufruf festgelegt werden) -> [datentyp, der ausgeworfen wird] { ... };
.cs
int r = 2; auto wo = [r](int a) -> int {return a*r;}; //wo ist ein Lambda Datentyp
.br
wo(3); // Lambda-Funktionsausruf, gibt 6 aus
.ce
.NH
Zusammengesetzte Datentypen
.NH 2
Arrays
.LP
In C werden Arrays so erzeugt: int feld[{Arraygröße}] = {2,3 }; Oder zweidimensional: int cord[][] = { {2,4}, {5,6}};
.br
Man greift auf ihren Index mit bspw feld[1] oder cord[1][0] zu. *feld zeigt auf den ersten Wert des Arrays, da der Arrayname wie ein Pointer zum ersten Arraywert funktioniert. Der Array ist aber kein Pointer!!!
.br
In C++ benutzt man hingegen array<int,2> feld {{ 2,3 }}; , um das selbe feld wie in C zu erzeugen. Für cord würde man array< array<int, 2>,2> cord {{ {{2,4}}, {{5,6}}  }}; schreiben. Es erzeugt, wie man sehen kann, einen Array im Array.
.br
Den Zugriff macht man mit feld[1] oder feld.at(1). Bei cord: cord[1].at(1) oder klassisch cord[1][0]. Der Vorteil von at() ist, dass man einen Out-of-Bounds Fehler bei einem Zugriff auf nicht vorhandene Arrayelemente bekommt, wobei man beim klassischen Zugriff keinen Fehler sondern irgendeine Zahl an dieser Memoryposition erhält.

.TS
allbox;
c s s
c c c
c c c.
Array
Erklärung	C	C++
Muss importiert werden	N/A	#include <array>
Deklaration und Definition	int feld[{Arraygröße}] = {2,3 };	array<int,2> feld {{ 2,3}};
zweidimensional	int cord[][] = { {2,4}, {5,6}};	array<array<int,2>,2> cord {{ 2,4}}, {{5,6}} }};
gibt 3 aus	feld[1];	feld.at(1);
gibt 5 aus	cord[1][0];	cord[1].at(0);
Arraygröße	sizeof(feld)/sizeof(*feld);	feld.size();
Arrayiteratoren	N/A	feld.begin() oder feld.end()
Array vergleichen	memcmp(feld1,feld2, sizeof(feld1));	std::equal
.TE
.NH 2
Bemerkungen
.LP
std::equal -> std::equal(std::begin(feld1), std::end(feld1), std::begin(feld2)) (benötigt <algorithm> und <iterator>)
memcmp -> (gibt, wenn sie gleich sind, 1 aus)
.NH
Strings
.LP
Achtung: Bei der Definition von Strings sollte man aufpassen: string x = "s" ist ein richtig definierter String. string x = 's' wäre jedoch ein string, dem ein Char zugewiesen wird!
.br
C-Strings werden mit '\\0’ beendet.
.TS
allbox;
c s s
c c c
c c c.
Strings
Erklärung	C	C++
Muss importiert werden	N/A (braucht für String-Funktionen <string.h>)	#include <string>
Deklaration und Definition	char s[] = "hi"; oder char* s = "hi";	std::string s = "hi";
gibt i aus	s[1];	s[1];
Stringlänge	strlen(s);	s.length();
Stringvergleich	strcpmp(s,"hi"); (bei gleichen wird 0 ausgegeben)	if(s == "hi")
String ändern	strcpy(s,"nicht hi");	s = "nicht hi";
Strings konkatenieren	strcat(feld1,feld2);(speichert in feld1)	s+="nichthi"; oder s.append("nicht hi");
Iteratoren	N/A	s.begin; s.end;
String zur Variable	atoi(s);	std::stoi(s); bzw stol,stof, stod und stoul
Substring	N/A	s.substr(3,5);
Substring finden	strstr(w1,w2);	s.find("hi);
.TE
.NH 2
Bemerkungen
.LP
find -> gibt Iterator aus, wo erstmals der regul. Ausruck auftaucht
.br
strstr -> gibt Char pointer zum Anfang vom gefundenen w2 in w1 zurück
.br
substr ->  bei nur einem Argument gehts bis zum Ende durch
