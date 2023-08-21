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
.XN "Datentypen"
.LP
int, float, bool, char, size_t, double. Diese können signed, unsigned, short, long und const sein. unsigned int ist das selbe wie size_t. (size_t muss jedoch mit stddef.h oder cstddef inkludiert werden. Bei letzterem ist std::size_t von Nöten.)
.NH
.XN Präprozessor
.LP
Der C/C++ Compiler inkludiert erst die deklarierten Header Files und compiliert danach die einzelnen cpp Programme und übersetzt die als Objektdateien .o, um sie im Linker mit den benötigten Bibliotheken zu verbinden und aus ihnen das ausführbare Programm zu erstellen.
.sp
header.h -> #include/Praprozessor-Anweisung -> main.c/cpp -> Compiler -> main.o -> Linker (verknüpft mit Bibliothek) -> main.exe (oder main auf Linux)
.NH
.XN Präprozessor-Anweisungen
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
.XN Globale Konstanten und Variablen
.LP
In Header Dateien werden Variablen ganz normal definiert, in der Quelldatei muss die Variable aber mit extern [datentyp] [variablenname]; deklariert werden.
.LP
Konstanten werden mit constexpr const [datentyp] [Konstantenname] = [Wert]; in der Header Datei definiert und mit extern const [datentyp] [Konstantenname]; in der Quelldatei deklariert und importiert. constexpr gibt es aber nur in C++, extern funktioniert aber in C wie auch C++.
Der Sinn von constexpr ist eine Konstante zu haben, die wirklich nicht geändert werden kann, im Gegensatz zu einer const. Dies sorgt dafür, dass der Compiler schon beim Compilieren weiß, dass sich diese Konstante auch nicht ändern wird. Es funktioniert auch als Sicherung.
.NH 2
.XN Lokale Variablen und Funktionen
.cs
static int x = 2; //die Variable ist lokal und kann nur in ihrer Funktion bzw Quelldatei verwendet werden.
.br
static int foo(); //die Funktion kann nicht von anderen Quelldateien außer der eigenen verwendet werden
.ce
.LP
Des Weiteren behält x seinen Wert bei, auch nachdem man ihren Block verlassen hat, weswegen ein ++x; später mehr als 3 sein kann.
.LP
Das Gegenteil von static ist auto, was der Compiler standardmäßig jeder Variable zuordnet. Wenn der Funktionsblock verlassen wird, wird auch der Wert von auto x = 2; gelöscht.
.NH 2
.XN Makro Definition
.LP
Makros sind die wahren Konstanten, die nicht geändert werden können, denn const Variablen sind nur begrenzt schreibgeschützt und können je nach Compiler mit Pointern geändert werden.
.cs
#define pi 3.14
.br
float x = pi;
.ce
.NH
.XN Namespaces
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
.XN Kommentare
.LP
//   -> kommentiert den Rest einer Zeile
.br
/*      */  -> alles, was zwischen /* und */ steht, wird herauskommentiert.
.NH
.XN Casting
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
.XN Binäroperationen
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
.XN Modulo
.LP
4 % 2 = 0 -> die Zahl ist rund
.br
3 % 2 = 1 -> die Zahl ist ungerade
.NH
.XN Pointer
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
.NH 2
Referenzen (nur bei C++)
.cs
int x = 24;
.br
int& ref = x; //eine Referenz agiert wie eine normale Variable, statt einem Pointer gleich, kann aber nie NULL sein
.br
std::cout << ++ref<<"\\n";  //gibt 25 aus
.ce
.NH 2
Smart Pointer (nur bei C++)
.LP
Smart Pointer haben den großen Vorteil zu rohen Pointern, die manuell mit new erzeugt wurden, dass sie automatisch nach ihrer Laufzeit gelöscht werden und es so zu keinen Memoryleaks kommen kann. (normale rohe Pointer werden aber nach ihrer Laufzeit gelöscht, wie alle anderen Variablen auch. new braucht nämlich immer ein delete, sonst gibts einen Memoryleak (bei malloc ist es genauso))
.br
Smart Pointer funktionieren nach dem RAII-Prinzip = "Resource Acquisition Is Initialization". Das heißt, dass der Konstruktor eines Objekts ihm Speicher zuweist und sein Destruktur diesen zugewiesenen Speicher später befreit.
.NH 3
Shared Pointer
.cs
#include <memory>
.br
std::shared_ptr<int> ptr = make_shared<int>(42); //ptr zeigt auf 42
.br
(*ptr)++;  //nun auf 43
.br
auto ptr2 = ptr; //ptr2 zeigt auf den selben Wert wie ptr
.br
ptr.use_count(); //ptr weiß, dass es einen weiteren shared Pointer gibt, der auf 43 zeigt, also gibt er zurück, dass zwei gleiche pointer existieren
.br
auto ptr3 = ptr2; //bei use_count() wird nun 3 ausgegeben, da alle shared Pointer der gleichen Adresse voneinander wissen
.br
ptr2.reset(); //ptr2 wird gelöscht, nun sinds nur noch 2
.br
int* i = ptr.get();  //ein roher Pointer kriegt den Wert von ptr. use_count() ergibt aber trotzdem 2, weil i roh ist
.ce
.NH 3
Unique Pointer
.cs
std::unique_ptr<int> ptr = make_shared<int>(42); //ein Unique Pointer. Er funktioniert fast wie ein shared Pointer
.br
auto ptr2 = ptr; //nur ist der gravierende Unterschied, dass er keine Smartpointer neben sich duldet! Diese Zeile wär ein Fehler
.ce
.NH
.XN Kommandozeilargumente
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
.br
Anmerkung: statt argv[] kann man als Funktionsparameter oben auch char **argv verwenden, da Arrays als Funktionsparameter als Pointer vom Compiler behandelt werden. (genauso wie Funktionen als Parameter)
.NH
.XN Typedef
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
.XN Alias mit using
.LP
In C++ gibt es die Möglichkeit nicht nur mit typedef einen Alias für einen Datentyp zu definieren, sondern auch mit using.
.cs
using [alias] = [datentyp];
.br
[alias] foo = 2;
.ce
.NH
.XN Enums/Aufzählungen
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
.XN Random
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
.XN Goto
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
.XN Input und Output
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
.XN Bemerkungen
.LP
Bei printf bedeutet %s->string, %d -> Variable, %p -> Pointer, %c -> Character.
.NH
.XN Dateien schreiben und lesen
.LP
in C
.cs
#include <stdio.h>
.br
FILE *pF = fopen("lesen.txt","r"); //"r" = read
.br
char linebuffer[255]; //maximaler Linebuffer
.br
//Durchlesen
.br
while(fgets(linebuffer,255,pF)!= NULL) printf("%s",buffer);
.br
//gibt Zeilen aus, solange es Zeilen zu lesen gibt. jedes Mal, wenn fgets aufgerufen wird, wird eine weitere Zeile gelesen
.br
fclose(pf); //Filepointer wird geschlossen
.br
//Ausgabe
.br
FILE *pf = fopen("schreiben.txt","w"); //"w" = (Über)schreiben und "a" = anfügen
.br
char *string = "nur ein c string\\n";
.br
fprintf(pf,string); //bei jedem Aufruf wird eine neue Zeile geschrieben bzw an eine Text angefügt
.br
fclose(pf); //schließt den Filepointer wieder
.ce
.LP
in C++
.cs
#include <fstream>
.br
std::ifstream quelle("speicher.txt");
.br
if (!quelle.good()) {  //überprüft, ob es möglich ist die Datei zu öffnen
.br
cerr << "Datei konnte nicht geöffnet werden\\n"; return 1;
.br
}
.br
//Durchlesen
.br
while(quelle.good()) { std::string s; quelle >> s; std::cout << s << "\\n"; } //jede Abfrage geht eine Zeile weiter
.br
//Ausgabe
.br
std::ofstream aus("aus.txt");
.br
if (!quelle.good()) {
.br
cerr << "Datei konnte nicht geöffnet werden\\n"; return 1;
.br
}
.br
std::array<std::string,3>t {{ "hi","ein string","noch ein String!" }};
.br
while(quelle.good()) { for(auto i : t) aus <<i<<"\\n";} //fügt den Array Zeile für Zeile ein
.ce
.NH 2
.XN Filesystem (nur für C++)
.cs
#include <filesystem>
.br
std::string path = "/home/notebook";
.br
for(const auto& eintrag : std::filesystem::directory_iterator(path)) std::cout << eintrag.path() << std::endl;
.br
//gibt jede Datei bzw jeden Ordner im Ordner dieses Pfades aus
.ce
.NH 3
.XN Ordnererstellung
.cs
#include <filesystem>
.br
std::filesystem::create_directories("neuer_ordner");
.ce
.NH
.XN Compilation
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
.XN Chrono
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
.XN Malloc
.LP
Jede manuelle Speicherzuweisung braucht immer ein free() bzw delete, da es sonst zu Memoryleaks kommt, weil C++ diese Zuweisungen nicht rückgängig macht.
.br
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
.XN Systembefehle
.LP
Dies geht in C wie auch C++. In C++ kann man jedoch auch std::system benutzen.
.cs
system("htop"); //ruft über die Kommandozeile des Betriebssystems htop auf
.ce
.NH 2
.XN Bemerkungen
.LP
int * var = malloc(sizeof(int)*300); bzw int* var = new int[300]; -> der Pointer var ist auf dem Stack, weist aber auf einen zugewiesenen Speicherplatz auf dem Heap, welcher nicht wie der Stack später automatisch freigemacht wird.
.br
new -> ist eher für Objekte gedacht. Der pointer funktioniert nach der Datentypszuweisung wie der neue Datentyp und nicht wie ein Pointer. (Es ist auch möglich Arrays damit zu erzeugen)
.br
calloc -> erzeugt im Gegensatz zu malloc einen Speicherpointer, der nur Nuller enthalten darf
.br
memcpy -> fügt direkt in den neuen Speicherpointer ein, keine Zuweisung ist erforderlich (in C++ gibts auch std::memcpy)
.br
realloc -> vereint in sich malloc, memcpy und free in einem
.NH
.XN Grundlegende Programmstrukturen
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
.XN Funktionspointer
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
.NH 3
Lambdas
.LP
Aufbau einer Lambda Funktion: [Liste aus Variablen, die aus der Quelldatei importiert werden] (Parameter für die Funktion, die beim Aufruf festgelegt werden) -> [datentyp, der ausgeworfen wird] { ... };
.cs
int r = 2; auto wo = [r](int a) -> int {return a*r;}; //wo ist ein Lambda Datentyp
.br
wo(3); // Lambda-Funktionsausruf, gibt 6 aus
.ce
.NH 2
Try und catch (nur C++)
.LP
Einfach gesagt ist throw dazu da einen Fehler zu übergeben und catch im try-catch-Block sorgt dafür, dass das Programm weiterlaufen kann, aber auf den Fehler eingeht.
.cs
float divide(float f1, float f2) {
.br
if f2( == 0) throw "Division durch Null!"; //Dieser String wird von catch später aufgefangen
.br
else return f1/f2;
.br
}
.br
try { divide(2.0/0); }
.br
catch(std::string err) { std::cerr << err << std::endl; } //Fehler wird ausgegeben
.ce
.NH
.XN Templates (nur C++)
.LP
Templates machen es möglich, dass Funktionen mit verschiedenen Datentypen verwendet werden können.
.cs
template<typename T>
.br
bool kleiner(const T& a, const T& b) { //Funktion ist für jede Parameterart gültig
.br
return a < b;
.br
}
.ce
.LP
Wenn man vermeiden will, dass die Funktion für bestimmte Datentypen verfügbar ist, überlädt man die Templatefunktion.
.cs
template<bool>
.br
bool kleiner(bool a, bool b) {
.br
static_assert(false, "sinnloser bool-Vergleich"); //gibt Fehlermeldung
.br
return 0;
.br
}
.ce
.NH
.XN Zusammengesetzte Datentypen
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
.XN Strings
.LP
Achtung: Bei der Definition von Strings sollte man aufpassen: string x = "s" ist ein richtig definierter String. string x = 's' wäre jedoch ein string, dem ein Char zugewiesen wird!
.br
C-Strings werden mit '\\0’ beendet und funktionieren wie C-Arrays, da sie eigentlich Char-Arrays sind.
.br
C++-Strings können mit insert und erase bearbeitet werden. (ähnlich wie ein Vector)
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
.NH
.XN Structs
.LP
Structs sind C's Art Objekte bzw eigene Datentypen zu erzeugen (structs haben jedoch keine Methoden). Der Unterschied zwischen C's Structs und C++'s structs ist, dass die structs von C++ die Möglichkeit haben, mit Konstruktoren ininitialisiert zu werden. Des Weiteren muss man in C++ structs nicht mit struct initialisieren, was in C nur in Kombination mit typedef geht.
.br
In C++ kann man structs übrigens auch einen Destruktor mit ~[Structname]() {} geben.
.cs
struct character {     //für typedef: typedef struct { char* name; }character;
.br
char* name;
.br
character(char* a) : name(a) { [...] }; //Der Konstruktor geht nur in C++, in C ist das ein Fehler
.br
}
.br
struct character roboter;   //in C++ geht auch character roboter;
.br
struct *character rpointer = &roboter;  //in C++ geht auch nur *character rpointer = &roboter;
.br
rpointer->name = "R2-D2";  //das selbe wie (*rpointer).name = "R2-D2";
.br
//in C++ kann man das alles auch mit dem Konstruktor verkürzen
.br
character roboter("R2-D2");
.br
//in C und C++ kann man auch Arrays mit struct erzeugen
.br
struct character roboter[];
.ce
.NH 2
.XN Unions
.LP
Unions sind eigentlich wie Structs, nur können sie lediglich eine einzige Variable gleichzeitig haben.
.cs
union character {     //für typedef: typedef union { char* name; }character;
.br
char* name; int version;
.br
character(char* a) : name(a) { [...] }; //Der Konstruktor geht nur in C++, in C ist das ein Fehler
.br
}
.br
union character roboter;   //in C++ geht auch character roboter;
.br
union *character rpointer = &roboter;  //in C++ geht auch nur *character rpointer = &roboter;
.br
rpointer->name = "R2-D2";  //das selbe wie (*rpointer).name = "R2-D2";
.br
rpointer->version = 4; //nun ist der Name weg
.br
//in C++ kann man das alles auch mit dem Konstruktor verkürzen
.br
character roboter("R2-D2"); //oder character(roboter(4);
.br
//in C und C++ kann man auch Arrays mit unions erzeugen
.br
union character roboter[];
.ce
.NH 3
Structs und unions zusammen verwenden
.LP
Unions kann man dazu verwenden, dass nur bestimmte Variablen besetzt werden und andere nicht, um Platz im Speicher zu sparen.
.cs
struct character {
.br
char *name;
.br
union { char *system; int alter; }
.br
}
struct character han_solo;
.br
han_solo.name = "Han Solo"; han_solo.alter = 28;
.br
struct character r2d2;
.br
r2d2.name = "R2.D2"; r2d2.system = "System 73";
.ce
.NH
.XN Vector (nur C++)
.LP
Ist wie ein Array, nur kann der Vector in seiner Laufzeit auf dem Memorystack vergrößert oder verkleinert werden. Der Zugriff funktioniert beim Vector genauso wie beim Array. liste[3] = 2; oder liste.at(3) = 2;
.cs
#include <vector>
.br
std::vector<int> liste {1,2,3};
.br
liste.push_back(4); // liste = {1,2,3,4}
.br
liste.insert(liste.begin(),0); // liste = {0,1,2,3,4}
.br
liste.erase(liste.begin()+2); //liste = {0,1,3,4}
.br
liste.pop_back(); //liste = {0,1,3}
.ce
.NH
.XN Maps (nur in C++)
.LP
Maps ordnen einem Schlüssel bzw einem Eingabewert einen Ausgabewert zu. Des Weiteren sind sie auch sortiert.
.cs
#include <map>
.br
map<char, int>karte { {'a',2}, {'c', 5} };
.br
karte.insert(make_pair('b',3));
.br
karte['r'] = 6;   //einfacherer Insert, der bei bestehenden Einträgen zum Update führt
.br
std::cout << karte'a'] << std::endl; //Zugriff
.br
karte.erase('r'); //löscht Eintrag für 'r'
.br
karte.clear();  //löscht alles in der Karte
.br
karte.empty()   //gibt true aus, wenn die Karte leer ist
.ce
.NH 2
.XN unsortierte Map
.LP
Die unsortierte Map ist eine Hashmap. Alle ihre Schlüssel werden mit einem Hash berechnet. Außerdem ist sie unsortiert, wie der Name auch schon sagt. Sie kann im Gegensatz zu einer map schneller sein, da ihre Einträge unsortiert sind.
.cs
unordered_map<char, int> hash_map { {'a',2 }, {'c',5} };
.ce
.LP
Ihr Zugriff auf sie funktioniert genauso wie bei einer normalen Map.
.NH
Softwaretests mit assert und static_assert
.LP
Mit assert kann man bei der Laufzeit eines Programmes feststellen, ob eine Bedingung erfüllt ist. Sofern diese nicht erfüllt ist, beendet sich das Programm und es kommt zur Fehlermeldung. static_assert macht so ziemlich das selbe, jedoch nur zur Compilierzeit und verhindert die Compilierung, sofern die Bediningung nicht eintrifft. static_assert ist nur Teil von C++.
.cs
#include <assert.h>
.br
assert(a == b); //ist a nicht gleich b, wird das Programm beendet
.br
std::static_assert(a == b,"A ist ungleich B"); //ist a nicht gleich b, geht die Kompilierung schief
.ce
.NH
.XN Klassen (nur in C++)
.LP
Klassen sind structs ziemlich ähnlich. Der einzige Unterschied ist, dass man mit ihnen Daten kapseln kann und ihnen Methoden geben kann. Wie auch, dass man sie von anderen Klassen erben lassen kann und somit ihnen die Methoden und Variablen anderer Klassen übergibt, die sie jedoch für sich überschreiben können.
.cs
class Mensch{
.br
public:
.br
	void hallo() { std::cout << "Hallo\\n"; }
.br
};
.br
class Hans : public Mensch {   //erbt von der Klasse Mensch
.br
public:
	std::string nachname;
	Hans(std::string n) : nachname(n) { //bzw this->nachname = n;
.br
	}
.br
	std::string getnachname() { return nachname; } //ohne this-> geht auch
.br
	~Hans() { std::cout << "Ade, schöne Welt\\n";  } //Destruktor
.br
private:
.br
	std::string versicherungsnummer; //Privat! Darauf hat man keinen Zugriff
.br
};
.br
Hans derHans("Meier");
.br
derHans.getnachname(); //gibt nachname zurück
.br
derHans.hallo(); //gibt die geerbte Methode von Mensch zurück
.ce
.NH 2
.XN Polymorphie
.LP
Klassen sind polymorph, wenn sie eine Klasse haben, von welcher sie alle erben. Man nehme als Beispiel es gebe die Klassen Hans, Klaus und Erwin. Alle drei erben von der Klasse Mensch, somit kann man einen Array aus ihnen erzeugen, der den Datentyp Mensch hat: Mensch menschen[] = { Hans, Klaus, Erwin };
.NH 2
.XN Operatorenüberladung
.LP
In C++ ist es möglich die Operatoren von Klassen zu überladen, indem man sie als Methoden der Klasse definiert.
.cs
class Hans : public Mensch {   //erbt von der Klasse Mensch
.br
public:
	std::string nachname;
	Hans(std::string n) : nachname(n) { //bzw this->nachname = n;
.br
	}
.br
	Hans operator+(const Hans &andererhans) { std::cout << nachname <<" grüßt den " <<
.br
andererhans.nachname <<std::endl;
.br
Hans unwichtig("hi"); return unwichtig; //Die Operatormethode erfordert einen Rückgabewert
.br
} // + wird überladen
.br
	std::string getnachname() { return nachname; } //ohne this-> geht auch
.br
	~Hans() { std::cout << "Ade, schöne Welt\\n";  } //Destruktor
.br
private:
.br
	std::string versicherungsnummer; //Privat! Darauf hat man keinen Zugriff
.br
};
.br
Hans derHans("Meier");
.br
Hans andererHans("Schröder");
.br
derHans + andererHans; //Meier grüßt den Schröder und unwichtig wird ausgegeben, aber nicht verwendet
.ce
.NH
.XN Multithreading
.NH 2
.XN Threading in C
.cs
(muss mit -pthread kompiliert werden, um auf POSIX zu laufen)
.sp
#include <pthread.h>
.br
#include <stdio.h>
.br
#include <unistd.h> //für sleep()
.br
void *threadarbeit(void *tid) {   //Threadfunktion mit Thread-id
.br
long id = (long)tid;  //cast zurück zum Integer
.br
sleep(1);
.br
printf("Es wird am Thread %ld gearbeitet\\n",id);
.br
pthread_exit(NULL);
.br
}
.sp
int main() {
.br
pthread_t thread[3]; //Threadanzahl
.br
for(long i = 0; i < 3; i++) {
.br
printf("Thread %ld wird gestartet\\n",i);
.br
pthread_create(&thread[i], NULL, threadarbeit, (void *)i);
.br
pthread_join(thread[i],NULL);
.br
}
.br
}
.ce
.NH 2
.XN Threading in C++
.cs
(muss mit -pthread kompiliert werden, um auf POSIX zu laufen)
.sp
#include <iostream>
.br
#include <thread>
.br
#include <mutex>
.br
int var = 1;
.br
void add(int a) {
.br
static std::mutex mtx;  //Threads müssen gelockt sein, damit das Betriebssystem den Thread nicht vorläufig beendet, um den nächsten Thread zu starten
.br
mtx.lock();   //bzw std::lock_guard<std::mutex> lock(mtx);, wenn man kb auf unlock hat
.br
var+=a;
.br
mtx.unlock();  //wichtig
.br
}
.sp
int main() {
.br
std::thread t([]() {
.br
std::cout << "Hi" << std::endl;
.br
});
.br
t.join(); //jeder Thread muss am Ende dem Mainthread gejoint werden, sonst gibts Fehler
.br
std::thread t1(add, 43);
.br
t1.join();
.br
std::thread t2(add, 143);
.br
t2.join();
.br
std::cout << var << std::endl;
.br
return 0;
.br
}
.ce
.NH 2
.XN Async (nur für C++)
.cs
(braucht wieder pthreads... Außerdem funktioniert Async etwas anders als herkömmliche Threads, da sie ihre Ergebnisse auch erst dann fertig berechnet haben müssen, wenn man mit get() nach dem Return fragt. Somit kann man ziemlich leicht Berechnungen semiparallel zum Mainthread ausführen lassen.
.sp
#include <iostream>
.br
#include <future>
.sp
int main() {
.br
std::future futur = std::async([]() { return 4+5;}); //Der Prozess darf auch erst beendet werden
.br
std::cout << futur.get() << std::endl;  //, wenn nach dem Ergebnis gefragt wird
.br
return 0;
.br
}
.ce
.NH
.XN Restliche std library für C++
.NH 2
.XN sort
.cs
#include <algorithm>
.br
#include <vector>
.br
#include <iostream>
.sp
int main() {
.br
std::vector<int> vec {1,4,3,6,8,2,4};
.br
std::sort(vec.begin(),vec.end());  //sort(Objekts-Anfangsiterator,Objekts-Enditerator);
.br
for(int i : vec) std::cout << i << std::endl;
.br
}
.ce
.NH 2
.XN find
.cs
#include <algorithm>
.br
#include <vector>
.br
#include <iostream>
.br
std::vector<int> vec {1,4,3,6,8,2,4};
.br
std::vector<int>::iterator iter = std::find(vec.begin(), vec.end(), 8); //auto iter für die Schreibfaulen
.br
std::cout << *iter << std::endl;  //wird wie ein Pointer ausgegeben; gibt 8 aus, da der Iterator dorthin zeigt
.ce
.NH 3
find_if
.cs
#include <algorithm>
.br
#include <vector>
.br
#include <iostream>
.br
std::vector<int> vec {1,4,3,6,8,2,4};
.br
std::vector<int>::iterator iter = std::find_if(vec.begin(), vec.end(), [](int x){return x% 2 ==0;});
.br
//iter zeigt auf erste gerade Zahl, die gefunden wird
.br
std::cout << *iter << std::endl;  //wird wie ein Pointer ausgegeben; gibt 4 aus, da der Iterator dorthin zeigt
.ce

.NH
.XN Programmierkonzepte
.NH 2
Memory/Speicher
.LP
Der Speicher ist das, was der Computer braucht, um Daten für eine gewisse Zeit im Arbeitsspeicher (RAM = Random Access Memory) zu speichern.
.NH 2
Cache
.LP
Teil des Prozessors oder der static RAM (SRAM), der vom Prozessors verwendet wird, um schnell Instruktionen und Daten zu speichern und wieder auszulesen.
.NH 2
Buffer/bzw zu Deutsch Puffer
.LP
Ein kleiner Speicher, der von als Inputspeicher bei Tastatur und Maus oder als Outputspeicher bei Druckern verwendet wird.
.NH 2
CPU
.LP
CPU (Central Processing Unit) bzw zu Deutsch der Prozessor macht alle Rechenoperationen des Rechners und kommuniziert dabei mit dem Halbleiterspeicher (RAM) über die schenelle Datenleitung BUS.
.NH 2
Stack
.LP
Speicherungskonzept der Informatik, bei dem Daten auf einen Stapel gelegt werden und nach LiFo (Last in First out) abgearbeitet werden.
.br
Bzw Teil des Speichers: Er ist typischerweise ein bis zwei Megabyte groß und enthält die Daten, die das Programm speichert und ausliest. Wird der Stack zu groß, kommt es zum Stackoverflow (bspw wenn eine Liste unendlich lang größer wird/bzw ein Array bzw Liste zu groß ist oder das Programm zu viele Operationen auf den Stack legt)
.br
Jede Variablen bzw Pointerdefinition oder Funktionsaufruf legt eine Operation auf den Stack, der von dem Prozessor abgearbeitet wird. Wenn man mehr Arbeitsspeicher benötigt, lädt man das benötigte Datenobjekt in den Heap mit malloc oder new, muss diesen aber später selber freimachen.
.NH 2
Heap
.LP
Der Heap bzw Haufen kann nach beliebger Reihenfolge erweitert werden und ist der größere Teil des Speichers. LiFo gilt nicht wegen des wahlfreien Zugriffs des Heaps.
.br
Er ist im Gegensatz zum Stack dynamisch mit malloc oder new erweiterbar, wird aber weil er nicht stackgleich abgearbeitet wird, nicht von selber gelöscht und muss manuell freigemacht werden.
.NH 2
Array
.LP
Bzw zu Deutsch Feld, ist eine Datenstruktur, bei der jedes Element nach seiner Speicheradresse benachbart ist und dessen endgültige Größe schon bei der Initialisierung endgültig ist, damit diese Speicheradressen auch schon vorreserviert sein können.
.NH 2
Dynamischer Array
.LP
Es ist ein Array, der wenn er mehr Platz benötigt, sich einen neuen größeren Array erzeugt und seinen Inhalt dort hineinkopiert.
.NH 2
Verkettete Liste
.LP
Eine Datenstruktur, bei der jedes Element einen Zeiger auf das nächste Element enthält. -> dies ist die einseitige Kette bzw Linked list
.br
Die doppelt verkettete Liste funktioniert nach dem Prinzip, dass jedes Element, welches weder das erste noch das letzte Element ist, einen Zeiger zum Vorgänger und Nachfolger enthält.
.NH 2
Binary Search
.LP
Eine Suche in einem sortierten Array, bei der man stets den Array in der Hälfte zerteilt und überprüft, ob der gesuchte Wert links oder Rechts dieser Mitte sein sollte. Daraufhin nimmt man zur Rekursion stets den Teilarray, der in Frage kommt, bis man einen Teilarray von der Größe eins hat.
.TC
