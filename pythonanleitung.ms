.ds RH Kurzanleitung zu python
.TL
Kurzanleitung zu Python
.AU
Alexander Ginschel
.NH
.XN Pythoncode starten
.LP
Macht man, indem man python ins Terminal eingibt und mit import das Skript importiert oder mit python skriptname das Skript gleich ausführen lässt.
.NH 2
Pip und Python environments
.LP
Pip ist das Standardinstallierprogramm für python Module. Man installiert jegliches Modul mit pip install modulname.
.sp
Auf Arch Linux kann es da schon mal zu Problemen kommen, dass man nur Module installieren kann, wenn man in einer virtuellen Pythonumgebung ist, die keinen Einfluss auf die Systempythonumgebung hat.
.br
Dazu erstellt man im gewollten Ordner die Umgebung mit python -m venv umgebungsname und aktiviert die Umgebung mit source umgebungsname/bin/activate. Nun sollte man mit pip Module installieren können. Mit exit verlässt man diese Umgebung wieder und muss sie später wieder selbst aktivieren.
.NH
.XN Variablen deklarieren
.LP
.B1
x = 32
.br
s = "das ist ein String"
.br
boo = True #Das ist ein Boolean, der nicht False ist
.br
abs(-34.5) #gibt Betrag, also 34.5 aus
.br
type(x) #gibt Datentyp von x aus
.br
5 // 3 #gibt ganze Zahlen beim Dividieren aus statt floats
.B2
Achtung! Alle Variablen außerhalb von Funktionen sind global!
.NH 2
Variablen konvertieren
.LP
.B1
x = 45
.br
str(x) #konvertiert zu einem String
.br
y = "234"
.br
int(y) #konvertiert zum korespondierenden int-Wert
.B2
.NH
.XN Eingabe und Ausgabe
.LP
.B1
inp = input("Gebe einen Wert ein") #Eingabewert wird in inp gespeichert
.br
print(inp) #gibt die Eingabe ins Terminal wieder aus
.br
print(f'{inp} hast du eingegeben') #mit f-String
.br
x =54
.br
print("x ist ",x) #mit Kommata ist es möglich Variablen auszugeben
.B2
.NH
.XN Strings
.LP
Mit Strings hat man eine Vielzahl an Methoden aus denen man frei wählen kann.
.B1
name = "name"
.br
print(len(name))  #gibt Länge von name aus
.br
print(name.find("o")) #gibt Index vom String aus, bei welchem find zum ersten Mal o findet
.br
#da o nicht in name enthalten ist, wird -1 ausgegeben
.br
print(name.capitalize()) #name mit erstem Buchstaben groß
.br
print(name.upper()) #name großgeschrieben
.br
print(name.lower()) #name klein geschrieben
.br
print(name.isdigit()) #prüft, ob name Zahl oder ein Wort ist
.br
print(name.isalpha()) #prüft, ob name ein Wort ist
.br
print(name.count("o")) #zählt, wie oft o in name vorkommt
.br
print(name.replace("a","o")) #ersetzt a mit o in name
.br
print(name*3) #name wird dreimal ausgegeben
.br
print(name[2:3]) #gibt den Substring "me" aus
.B2
.NH
.XN If, while, for
.NH 2
if
.LP
.B1
x = 32
.br
if x > 10:
.br
	print("hi")
.br
elif x < 10:
.br
	print("hello")
.br
else:
.br
	print("x ist 10")
.B2
.NH 2
while (do-while gibts btw nicht)
.LP
.B1
while x > 10:
.br
	pass #mach irgendwas
.B2
.NH
for-Schleife
.LP
.B1
ls = [0,1,2,3]
.br
for i in range(0,3,1): #i geht von 0 bis 3 im Einerschritt
.br
	print(i)
.br
for item in ls: #foreach loop durch ls
.br
	print(item)
.B2
.NH
.XN Funktionen
.LP
Void-Funktionen erkennt man daran, dass sie am Ende nichts zurückgeben, wohingegen Variablenfunktionen mit return am Ende des Funktionsdurchganges einen Wert zurückgeben.
.B1
def foo(c=4): #wird c im Funktionsaufruf nicht angegeben, ist c gleich 4
.br
	c+=1
.br
	return c
.br
foo(5)
.B2
.NH 2
Bessere Lesbarkeit für Funktionsdeklarationen
.LP
Man darf nicht vergessen, dass dies nur zur besseren Lesbarkeit für den Programmierer da ist und der Pythoninterpreter diese Informationen nicht bei der Programmausführung verwendet.
.B1
def foo(c : float) -> int: # c ist ein Floatdatentyp und die Ausgabe von foo ist ein Integer
.br
	return int(x) # Das einzige, was der Interpreter wirklich bearbeitet (Integer x wird ausgegeben)
.B2
.NH
.XN Ausnahmen
.LP
.B1
try:
.br
	print("Ausgabe")
.br
catch: #wird durchlaufen, wenn try versagt
.br
	print("Ein Fehler ist unterlaufen")
.B2
.NH
.XN Tupel, Set, Dictionary, List
.NH 2
Tupel
.LP
.B1
tupel = ("das","ist","ein","tupel") #ist übrigens schreibgeschützt und unerweiterbar
.br
print(tupel[2]) #gibt "ein" aus
.B2
.NH 2
Set (mathematische Menge)
.LP
.B1
set = {2,5,8} #ist schreibgeschützt, erweiterbar,verkleinerbar und sortiert
.br
set.add(6) #fügt 6 ein
.br
set.remove(2) #entfernt 2
.B2
.NH 2
Dictionary/Hashmap
.LP
.B1
dictio = dict(a = "4", b = "7") #mit Konstruktor
.br
dictio = {"a" : "4", "b" : "7"} #ohne geht auch
.br
for x in dictio: #foreach geht hier auch
.br
dictio["a"] = "72" #ändert Wert von a
.br
x = dictio["a"] #Zugriff auf a
.br
dictio["c"] = "8" #erstellt neuen Index
.br
for key, item in dictio.items(): #gibt Liste mit Tupel für jeden Eintrag aus
.br
	print("Schlüssel:",key,"|Item:",item) #gibt die Schose wieder aus
.br
dictio.pop("c") #löscht c Eintrag
.br
dictio.popitem() # löscht letzten neuen Eintrag
.br
dictio.keys() # gibt alle Schlüssel/Einträge aus
.br
dictio.clear() #löscht alles in dictio
.B2
.NH 2
Liste
.LP
.B1
liste = [1,2,4,5] #erstellt Liste
.br
liste.insert(2, 4) #liste[2] = 4
.br
liste.pop(1) #löscht Liste[1]
.br
liste.pop() #löscht letzten Eintrag der Liste wie liste.pop(-1)
.br
liste.sort() #Liste wird sortiert bzw liste.sort(reverse=True), was rückwärts sortiert
.br
liste[:3] #alle Werte bis zum Index 3
.br
liste[1:] #alle Werte vom Inex 1 (liste[1:3] sind alle Elemente von 1 bis 3)
.br
liste.append(2) #letztes Element ist 2
.br
del liste bzw liste.clear() #löscht die liste
.br
liste[2] # gibt Liste am Index 2 aus
.br
x = list((1,3,5)) #macht aus Tupel eine liste
.B2
.NH 3
List Comprehension
.LP
Syntaktisches Gefüge, das beschreibt, wie vorhandene Lsiten oder andere iterierbare Objekte verarbeitet werden, um so neue Listen zu erstellen.
.B1
students = [100,90,80,70,60,50,40,30,20,15,10]
.br
passed_students = [i for i in students >= 60] #filtert die Studenten danach, ob sie bestanden haben
.B2
.NH 3
Numpy-arrray
.LP
.B1
import numpy as np
.br
arr = np.array([[1,2,3,4,5],[6,7,8,9,10]]) #wenn eindimensional nur ein [ ]
.br
arr[1,-1] #gibt letztes Element vom zweiten Element aus
.B2
.NH
.XN Lambdafunktionen
.LP
x = lambda a : a +10
.br
x(2) #gibt 12 aus
.NH 2
zip
.LP
zips sind eine Zuordnung von zwei oder mehr gleichlangen Containern zueinander.
.B1
liste1= ["eins", "zwei", "drei"]; liste2 = [1,2,3]
.br
tupellliste = list(zip(liste1,liste2)) #erstellt aus beiden Listen eine Tupelliste
.br
dictliste = dict(zip(liste1,liste2)) #diesmal ists eine Hashmap
.B2
.NH
.XN Maps
.LP
map() gib ein map Objekt aus, das das Ergebnis eines Datenobjekts und einer Funktion ist. -> map(funktion, liste)
.B1
liste = list(map(lambda x : x*2, [1,2,3,4])) #erstellt eine verdoppelte Liste
.B2
.NH
.XN Kleinere nette Sachen
.NH 2
rand
.LP
import random; print(random.randint(0, 9)) #gibt Integerwert zwischen 0 und 9 aus
.NH 2
Zeit messen
.LP
.B1
import time
.br
start = time.time() #setzt Timer
.br
end = time.time() #endet timer
.br
intervall = end -start #speichert Zeitintervall
.B2
.NH 2
sleep
.LP
.B1
import time
.br
time.sleep(3) #Thread schläft drei Sekunden lang
.B2
.NH 2
Mainfunktionen
.LP
if __name__ == "__main__":
.br
Alles, was eingerückt in der oben stehenden Mainfunktion steht, wird nur ausgeführt, sofern man dieses Pythonprogramm direkt selbst ausführt und es nicht importiert.
Dies ist sofern nützlich, da bei einem import nämlich alles, was in keiner Funktion steht direkt ausgeführt wird, was bei Softwarebibliotheken ziemlich beschissen ist, sofern man Code außerhalb von Funktionen "ungeschützt" hat.
.NH 2
import
.LP
Man nehme an man hätte im Ordner lib das Pythonskript hallo.py würde man direkt außerhalb dieses Ordner das Skript so referenzieren.
.br
import lib.hallo as hallo
.br
Um auf die Funktion hallo_welt in hallo.py zuzugreifen, braucht man nur das zu schreiben:
.br
hallo.hallo_welt()
.NH 2
Pythonargumente
.LP
Terminalargumente
.B1
import sys
.br
sys.argv[1] #greift auf das erste Argument nach python [skriptname].py zu (sys.argv[0] ist der Skriptname)
.B2
.LP
Schlüsselwortargumente
.B1
def hello(first,last):
.br
	print("Ich grüße Sie, ",first,last,"!")
.br
hello(last="Schulze", first="Hans")
.br
#obwohl die Namen in der falschen Reihenfolge sind, werden sie in richtiger Reihenfolge zugeordnet
.B2
.LP
Funktionsargumente (der Name ist nicht entscheidend, sondern nur die Anzahl an Kleenesternen)
.B1
#args also arguments
.br
def main(*args):
.br
	args[0] #gibt erstes Element aus der Argumentliste aus
.br
main(2,5,6,3,6)
.br
#für kwargs (dictionaryargumente bzw keywordarguments)
.br
def main2(**kwargs):
.br
	kwargs["name"] #gibt Eintrag für name aus
.br
main2(name="hans", ort="Neustadt")
.B2
.NH 2
requests
.LP
.B1
import requests
.br
page = requests.get("example.com")
.br
print(page.text) #gibt Quelltext der Seite aus
.B2
.NH 2
Dekoratoren
.LP
Mit Dekoratoren kann man Funktionen als Parameter anderer Funktionen verwenden bzw diese in die Funktion leicht einfügen.
.B1
def foo(func):
.br
	def hi():
.br
	...
.br
	func() #hier wird die Funktion, die als Parameter genutzt wird ausgeführt
.br
	...
.br
@foo #nächste Funktion wird als Parameter von foo verwendet
def eine_funktion():
.br
	print("lol")
.B2
.NH 2
Systembefehle
.LP
.B1
import os
.br
os.system("ls") #führt Systembefehle aus
.B2
.NH 2
assert
.LP
assert var > 0 #gibt Fehler aus, wenn var kleiner Null ist (so ziemlich wie bei C )
.NH
.XN Dateien
.LP
Dateien schreiben
.B1
with open("text", "w") as f: #w = überschreiben/write, a=anfügen/append
.br
	f.write("ein text \\n")
.br
bzw f = open("text", "a")
.br
f.write("hi"); f.close() #bei with wird das f.close automatisch gemacht
.B2
.LP
Dateien lesen
.B1
with open("text") as f: #"r" wird standardmäßig als Parameter genommen
.br
	f.read() #liest sofort alles aus
.br
	f.readline(2) #liest nur die dritte Zeile aus
.br
	zeilen = f.readlines() #speichert alle Zeilen als Liste in zeilen
.br
	for zeile in f: #alternative Möglichkeit zum Durchiterieren aller Zeilen
.B2
.NH
.XN Dateisystem
.LP
.B1
import os
.br
#herausfinden, ob Pfad existiert
.br
os.path.exists("/home/nutzer/datei_oder_ordner")
.br
os.mkdir("ordner") #erstellt ordner
.br
os.rmdir("ordner") #löscht ordner
.br
os.makedirs("ordner/unterordner") #erstellt Ordner mit Unterordner
.br
os.replace("text", "ordner/unterordner/text") #verschiebt text in den Unterordner
.br
os.remove("text") #löscht text
.br
import shutil #für betriebssystemunabhängiges Kopieren von Dateien
.br
shutil.copyfile("quelldatei", "kopie") #kopiert Datei
.B2
.NH
.XN Verschluesselung
.LP
.B1
import random
.br
import string
.sp
chars = " " + string.punctuation + string.digits + string.ascii_letters #mögliche Zeichen zur Verschlüsselung
.br
chars = list(chars)
.br
key = chars.copy()
.br
random.shuffle(key) #zufällige Reihenfolge
.br
#ENCRYPT/Verschlüsselung
.br
plain_text = input("Enter a message to encrypt: ")
.br
cipher_text = ""
.br
for letter in plain_text:
.br
    index = chars.index(letter)
.br
    cipher_text += key[index]
.br
print(f"original message : {plain_text}")
.br
print(f"encrypted message: {cipher_text}")
.br
#DECRYPT/Entschlüsselung
.br
cipher_text = input("Enter a message to encrypt: ")
.br
plain_text = ""
.br
for letter in cipher_text:
.br
    index = key.index(letter)
.br
    plain_text += chars[index]
.br
print(f"encrypted message: {cipher_text}")
.br
print(f"original message : {plain_text}")
.br
.B2
.NH
.XN Klassen (btw es gibt keine privaten Daten in Python)
.LP
car.py
.B1
class Car(Maschine): #erbt von fiktiver Klasse Maschine, bei keiner Vererbung braucht man kein ()
.br
	beschwerdeliste = [] #die Liste ist global und aufrufbar von jeder Instanz von Car
.br
	def __init__(self,marke="VW", farbe):   #Konstruktor
.br
		Maschine.__init___(self) #bzw super().__init__(self) (Oberklassenkonstruktor)
.br
		self.marke = marke
.br
		self.farbe = farbe
.br
	def __del__(self): #Destruktor
.br
		print("Schrott)
.B2
.LP
irgendeinskript.py
.B1
from car import Car
.br
car1 = car("VW","rot")
.br
car2 = car("BMW", "schwarz")
.br
car1.beschwerdeliste.append("zu langsam")
.B2
.NH 2
enum-Klassen
.LP
.B1
class Gefahr:
.br
	niedrig,mittel,hoch = range(3)
.br
print(Gefahr.hoch) #gibt 2 aus
.B2
.NH
.XN regex (Reguläre Ausdrücke)
.LP
.B1
import re
.br
pattern = re.compile(.*s$') #Pattern, das nach Wörtern sucht mit s am Zeilenende
.br
pattern.search("suchstrings") #findet am Ende einen Patternmatch
.br
liste = pattern.findall("suchstrings") #gibt Liste aller passenden Strings aus
.B2
.LP
reguläre ausdrücke:
.br
 . -> egal, was da steht
.br
 * -> egal, welche Anzahl von dem, was links neben dem Klene Stern ist
.br
\\+ -> mindestens ein Zeichen muss da stehen, von dem was links daneben ist
.br
$ -> markiert Zeilenende
.br
^ -> markiert Zeilenanfang
.br
\\S -> nicht Leerzeichen, kann mit * rechts kombiniert werden
.br
\\s -> Leerzeichen
.br
\\? - Zeichen ist optional
.br
[a-z] -> jeder kleine Buchstabe
.br
[A-Z] -> jeder große Buchstabe
.br
[A-Za-z] -> jeder Buchstabe
.br
[0-9] -> jede Ziffer
.br
\\. -> ein Punkt
.NH
.XN Multithreading und Multiprocessing
.LP
Multithreading läuft in Python nicht wirklich gleichzeitig, sondern die Threads werden immer mal wieder gewechselt, weswegen man Multithreading für gewöhnlich beim Warten auf Eingabe oder Ausgabe verwendet.
.sp
Multiprocessing ist in Python hingegen das Ausnutzen von den mehreren Kernen eines Prozessors, um Rechenoperationen gleichzeitig ausführen zu lassen, was lange Rechenoperationen verschnellern kann, insofern man nicht mehr Prozesse erzeugt, als einem Kerne zur Verfügung stehen.
.NH 2
Multithreading
.LP
Hier wird eine Threadklasse erzeugt, die eine vorher definierte Funktion als Argument annimt. Man kann jedoch auch eine eigene Klasse erstellen, die von threading.Thread erbt, wobei man aber auf den Konstruktor und den Konstruktor der threading.Thread-Klasse nicht versehentlich verzichten sollte! Diese eigene Klasse wird genauso mit start() gestartet und join() mit dem Mainthread vereint wie die normale Thread-Klasse.
.B1
import threading
.br
def eine_funktion():
.br
	print("hi")
.br
t1 = threading.Thread(target=eine_funktion, args=(1,2,3))
.br
t1.start(); t1.join() #damit, der Mainthread nicht weiterarbeitet, solange t1 nicht fertif ist, wird er gejoint
.br
threading.active_count() #gibt Threadanzahl aus
.br
threading.enumerate() #gibt Threadinformationen aus
.B2
.NH 2
Multiprocessing
.LP
.B1
from multiprocessing import Process, cpu_count
.br
import time
.br
def counter(num):
.br
    count = 0
.br
    while count < num:
.br
        count += 1
.br
def main():
.br
    print("cpu count:", cpu_count()) #gibt Anzahl der verfügbaren Kerne aus
.br
    a = Process(target=counter, args=(500000000,))
.br
    b = Process(target=counter, args=(500000000,))
.br
    a.start()
.br
    b.start()
.br
    print("processing...")
.br
    a.join()
.br
    b.join()
.br
    print("Done!")
.br
    print("finished in:", time.perf_counter(), "seconds")
.br
if _name_ == '__main__': #ist wichtig, damit mögliche Kinderprozesse (in diesem Fall nicht) nichts crashen
.br
    main()
.B2
.NH
.XN csv's lesen (Comma seperated values)
.LP
.B1
import csv
.br
with open("text.csv") as f: #CSV's lesen
.br
	for row un reader:
.br
		print(row[1]) #gibt zweiten Eintrag der Reihe aus
.br
with open("text.csv", "w") as f: #CSV's schreiben
.br
	writer = csv.writer(f); writer.writerow(["ID", "name"]) #schreibt Dateiheader
.br
	writer.writerow(["1","Ernst"]) #eigentliche Datenreihe
.B2
.NH
.XN Graphen zeichnen
.LP
.B1
import matplotlib.pyplot as plt, numpy as np
.br
xwerte=np.array([1,3,5,8]) #x-Koordinaten der Punkte
.br
ywerte=np.array([5,8,2,30]) #y-Koordinaten der Punkte
.br
plt.plot(xwerte,ywerte) #erstellt Graphen
.br
plt.show() #zeigt Graphen
.B2
.NH
.XN Web Sockets
.LP
.B1
import socket
.sp
#fürn Server
.br
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #INET für IP und STREAM für TCP
.br
server.bind(('127.0.0.1',80)) # braucht ein Tupel; btw 80 ist der http Port
.br
server.listen(1) #hört nur auf einen Client gleichzeitig
.br
while True: #wenn man öfters Daten vom Selben empfangen will, sollte man die Schleife nach accept() packen
.br
	(client,addr) = server.accept() #ins Tupel kommen die Daten des Client
.br
	msg=client.recv(2048) #Bytenachrichtengröße
.br
	msg = msg.decode() #Bytes in String
.br
	print(str(msg,"utf8")) #gibt msg aus
.sp
#fürn Client
.br
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #INET für IP und STREAM für TCP
.br
client.connect(('127.0.0.1',80)) # braucht ein Tupel; btw 80 ist der http Port
.br
msg = "lol"; msg = msg.encode() #encodiert "lol", damit man es per Socket schicken kann
.br
client.send(msg)
.B2
.TC
