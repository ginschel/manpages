.ds RH Kurzanleitung zu Linux
.TL
Kurzanleitung zu Linux
.NH
.XN Nutzer- und Gruppenmanagement
.NH 2
Nutzermanagement
.LP
.B1
sudo adduser nutzername
.br
sudo userdel nutzername
.br
sudo passwd nutzername
.B2
.sp
sudo vim /etc/passwd -> gibt alle Nutzerkonten aus bzw lässt alle Konten konfigurieren
.NH 2
Gruppenmanagement
.LP
.B1
sudo groupadd gruppenname
.br
sudo groupdel gruppenname
.br
sudo adduser nutzername gruppenname -> fügt Nutzer zur Gruppe hinzu
.br
sudo deluser nutzername gruppenname -> löscht Nutzer aus Gruppe
.br
pkill -kill -u nutzername -> loggt nutzer aus dem System aus
.B2
.sp
sudo vim /etc/group -> Konfigurationsdatei aller Gruppen
.NH
.XN Systemessentials
.LP
echo "text" -> gibt text in der Terminalausgabe aus
.br
Inhalt zur Datei anfügen
.br
echo "hi" << hi //fügt hi der datei an
.br
cat file //gibt file ins Terminal aus
.br
cat file file2 //(con)CATenates Files!
.br
< file //gibts auf die POSIX-Art aus!
.br
> file //scheiße, meine Datei ist leer!!!
.br
clear -> löscht Terminalausgabenverlauf
.br
mkdir Ordner -> erstellt Ordner
.br
cd Ordner -> geht in Ordner
.br
 . -> dieser Ordner
.br
~ -> Heimverzeichnis
.br
cd .. -> geht einen Ordner im Pfad hoch
.br
cd -> cd ~
.br
rm -rf Ordner -> löscht Ordner rekursiv (also mit Dateien drin)
.br
ls -a -> gibt alle versteckten Dateien aus
.br
ls -al -> gibt alle versteckten Dateien aus mit allen Dateieinformationen aus
.br
time cat file -> gibt Zeit für Ausgabe von file aus
.br
touch datei -> erstellt Datei
.br
mv dateiname dateiname2 -> benennt Datei um
.br
mv dateiname Verzeichnis/ -> verschiebt Datei ins Verzeichnis
.br
cp datei Verzeichnis/ -> kopiert Datei ins Verzeichnis
.br
less datei -> man kann bequem die Datei lesen
.br
file Datei -> gibt Dateiart aus
.br
ip addr -> gibt ip-adresse aus
.br
pidof prozess -> gibt prozessnummer an
.br
ps -e | grep -> listet alle Prozesse aus und pipet in grep, um zu filtern
.br
kill prozessnummer -> tötet Prozess
.br
pkill prozessname -> tötet Prozess, aber diesmal durch Patternmatching
.br
date -> gibt Datum aus
.br
cal -> gibt Kalender aus
.br
ping seite.de -> pingt eine Seite an
.br
df -h -> gibt Laufwerkinformationen aus
.br
du -h -> gibt Größe von Dateien aus
.br
sleep 5 -> wartet fünf Sekunden
.br
alias rm=rm -rf -> setzt alias für rm -rf
.br
setxkbmap -option caps:escape -> macht capslock zu einem weiteren Escape
.br
pacman -Suy programmname //-u=Update, S=install, y=packageupdate; installiert packages
.br
seq 5 oder seq 200 //zählt bis 5 bzw 200
.br
initx bzw startx -> start xorg
.NH 2
USBs:
.LP
mkfs.vfat /dev/sdb bzw Name des USBs aus lsblk -> formatiert USB zu fat
.br
Mounten:
.br
1) lsblk -> zeigt Laufwerke an
.br
2) mount /dev/{USB-Name bei lsblk} {den Ordner im eigenen System, mit dem man mounten will}
.br
#ja, hier sieht man richtig. Zum Mounten braucht man einen eigenen Ordner. Wissen die wenigsten
.br
3) umount /dev/{USB-Name bei lsblk} -> gibt Laufwerk wieder frei
.NH
.XN Shellscripting
.NH 2
chmod
.LP
chmod +x script  //macht das script ausführbar
.br
r (read) =4
.br
w (write) = 2
.br
x (execute)=1
.br
0 -> kein Zugriff
.br
7->rwx; 5->rx; 6->rw
.br
chmod 555 script //Lesen und Ausführen für Nutzer, Gruppe und Andere
.br
ls -la -> gibt Befugnisse der Dateien im Verzeichnis aus
.br
chmod -R 777 ordner //ändert Befugnisse im ganzen Ordner
.br
chown
.br
sudo chown nutzer:gruppe text.txt  //text.txt gehört Nutzer/gruppe
.br
chown -R nutzer:gruppe ordner // im ganzen Ordner gehört alles nutzer/gruppe
.NH 2
Shellscripts
.LP
$SHELL -> Shell, die grad läuft
.br
$PATH -> Eine Liste von Verzeichnissen, in die man scripts einfügen kann, um sie von allen Verzeichnissen zugänglich zu machen
.br
export PATH=$PATH:/kompletter/Verzeichnis/Pfad/vom/gewünschten/Ornder //kann man in .profile einfügen, um einen neues Verzeichnis zu der Liste hinzuzufügen
.sp
Zu Skripten:
.br
Scripts muss man mit chmod ersteinmal ausführbar machen. Des Weiteren gehört in die erste Zeile, welche Shell verwendet wird. -> #!/bin/sh oder statt sh bash oder zsh oder dash,etc...
.br
Das script lässt sich dann mit ./scriptname oder sh scriptname ausführen
.NH 2
Variablen:
.LP
irgendein_string = "wow"
.br
echo $irgendein_string //gibt Variable aus
.br
read hi
.br
echo $hi //eingelesene Variable wird ausgegeben
.br
< $hi //überschreibt hi
.br
$1 -> erstes Argument, welches Befehl bzw script übergeben wurde
.NH 3
Variablen addieren
.LP
z = $(($x + $y))
.br
falls man Bock hat Kommazahlen zu addieren:
.br
z = $(python -c "print($x + $y)")
.NH 2
Arrays
.LP
ein_array=(eins zwei drei)
.br
echo ${ein_array[@]} //gibt ganzen array aus
.br
echo ${ein_array[2]} //gibt zweites Element aus
.NH 2
if
.LP
if [ $name = "lol" ]; then
.br
	echo "hi, lol"
.br
elif [ $name = "nope" ]; then
.br
	echo "nope"
.br
else
.br
	echo "something else"
.br
fi
.sp
bzw bei Variablen statt Strings:
.br
[ $x -eq 5 ]; then  #-eq = equals; -lt = <; -gt = >; -z = 0 bzw leerer String; -ne = not equals
.NH 2
for-Schleife
.LP
for i in ${ein_array[@]}; do
.br
echo $i;
.br
done
.br
//um statt eines Arrays den Befehlsoutput zu iterieren
.br
for i in $( ls ); do
.br
echo $i;
.br
done
.NH 2
while-Schleife
.LP
i = 0
.br
while [ $i -lt 10 ]; do
.br
echo $i; let i = i + 1   #anders kann man nicht iterieren
.br
done
.NH 2
Funktionen
.LP
function hifunktion { echo hi } bzw hifunktion() { echo hi } #Deklaration und Definition
.br
hifunktion #Funktionsaufruf
.NH 2
Zusätzliche Shellsyntax:
.LP
Befehl; Befehl2 -> zweiter Befehl wird ausgeführt, als sei er in der nächsten Zeile
.br
Befehl || Befefehl2 -> wenn Befehl nicht richtig ausgeführt wird, wird Befehl2 ausgeführt
.br
Befehl & Befehl2 -> beide Befehle werden gleichzeitig ausgeführt
.br
Befehl && Befehl2 -> Befehl2 wird nur ausgeführt, wenn Befehl korrekt ausgeführt wird
.sp

Achtung scripte werden immer in einer seperaten subshell ausgeführt, weswegen man bei einem cd in einem script nicht in dem Ordner bleiben wird, sondern "zurücktransportiert" wird!
.br
Deswegen muss man zum Beispiel so auf sein eigenes script zugreifen, damit man im gewollten Ordner bleibt:
.br
alias cs="source ~/.local/bin/cs"; cs
.NH 2
bashisms (nicht POSIX-Syntax)
.LP
less <(cat file)  //output vom Command wird direkt als Argument eingegben
.br
[[ "$BROWSER" == "lynx" ]] && echo "sehr minimalistisch..." //glob-Matching-Bashism
.br
[ "$BROWSER" = "lynx" ] && echo "sehr minimalistisch..."  //auf die POXIX-Art
.NH 2
rc file (läuft in jedem nicht loginshell)
.LP
~.bashrc bzw .zshrc
.NH 2
profile file (profile läuft nach dem Nutzerlogin)
.LP
~.bash_profile bzw .zprofile bzw .profile für POSIX shell
.NH
.XN vim
.LP
Navigation bei vim:
.br
        k
.br
        /\\
.br
  h <-|-> l
.br
        \\/
.br
         j
.br
Befehle funktionieren nur im Normalmode bzw Visual Mode
.br
i -> insertmode
.br
esc -> normalmode
.br
ZZ -> speichern und schließen
.br
:wq -> speichern und schließen
.br
:q! -> abrupt schließen
.br
:!shellbefehl -> führt shellbefehl in vim aus
.br
a -> append/insertmode
.br
e und a -> gute Kombi
.br
A -> appended am Zeilenende
.br
o -> neue Zeile unten/insertmode
.br
O -> neue Zeile oben/insertmode
.br
d -> löschen bzw schon eher ausschneiden, da d das gelöschte yankt
.br
dw -> löscht wort ab dem gerade ausgewählten Zeichen
.br
de -> dw, aber lässt Leerzeichen dastehen
.br
d2e -> d2e nur zweimal
.br
dd -> löscht ganze Zeile
.br
2dd -> löscht zwei ganze Zeilen
.br
d0 -> löscht bis Zeilenanfang
.br
d$ -> löscht bis Zeilenende
.br
x -> löscht Zeichen
.br
r -> ersetzt ein Zeichen
.br
R -> ersetzt mehrere Zeichen
.br
c -> change/wechseln
.br
ce -> löscht das Wort, um es zu editieren
.br
cw -> das selbe wie ce
.br
cc -> wechselt ganze Zeile
.br
gg -> geht zum Dateianfang
.br
G -> geht zum Dateiende
.br
34G -> geht in Zeile 34
.br
0 -> geht zum Zeilenanfang
.br
$ -> geht zum Zeilende
.br
b -> geht zum Wortangang des letzten Wortes
.br
w -> geht zum Wortanfang des nächsten Wortes
.br
ge -> geht zum letzten Wortende zurück
.br
e -> geht zum Wortende
.br
6w -> geht sechs Wortanfänge weiter
.br
6e -> geht sechs Wortenden weiter
.br
gU -> macht Buchstaben groß
.br
gu -> macht Buchstaben klein
.br
gqq -> macht aus einer langen Zeilen mehrere kürzere Zeilen
.br
gk -> geht eine visuelle Zeile nach oben
.br
gj -> geht eine visuelle Zeile runter
.br
{ -> geht Absatz hoch
.br
} -> geht Absatz runter
.br
J -> joint/verbindet obere Zeile mit unterer
.br
% -> von einer Klammer zu ihrer korespondierenden Klammer
.br
s/thee/the/g -> substitutes thee with the, g heißt, dass das nicht nur beim ersten Ergebnis substituiert wird
.br
u -> undo
.br
strg + r -> redo
.br
v -> visual mode
.br
V -> ganze Zeile wird ausgewählt
.br
4V -> vier ganze Zeilen werden ausgewählt
.br
y -> das ausgewählte wird kopiert
.br
yw -> Wort wird geyankt/kopiert
.br
yy -> ganze Zeile wird geyankt/kopiert
.br
p -> das kopierte wird eingefügt
.br
:r dateiname -> fügt Inhalt von dateiname in den jetzigen Text ein
.br
/suchbegriff -> öffnet Suche und sucht nach Suchbegriff nach Enter (casesensitive)
.br
/\csuchbegriff -> Suche aber keine Beachtung von Groß- oder Kleinschreibung
.br
n -> geht in der Suche zum nächsten Patternmatch
.br
N -> geht bei der Suche zurück
.br
?suchbegriff -> Suche nur rückwärts
.br
paar Sucheinstellungen:
.br
:set hlsearch -> Highlightsearch wird gesetzt
.br
:nohlsearch -> no Highlightsearch einstellen
.br
:set noic -> casesensitive einstellen
.br
:set ic -> ignore case bzw ignoriert Groß- und Kleinschreibung
.NH
.XN Vim mapping
.LP
Nur zur info: Kommentare bei vim werden mit " gemacht
.sp
Die mappings kommen bei vim in -> ~.vimrc
.br
und bei neovim/nvim in -> nvim/init.vim
.sp
imap kürzel ausgabe  //im Insertmode wird kürzel durch die ausgabe ersetzt
.br
bsp: imap ;h <html> //ersetzt ;h immerzu durch <html>
.br
noch ein bsp: imap ;l .LP<Enter> //für groff-dokumente ganz nett, es gibt noch <Esc> und <Space>
.br
nmap mk :w<Enter>:!make %:r<Enter>:q<Enter> //macht make und compiliert Datei; %:r steht für Dateiname ohne Dateiendung
.br
nmap kürzel ausgabe //im Normalmode werden bei kürzel die Ausgabebefehle ausgeführt
.NH
.XN ssh (secure shell)
.NH 2
ssh-Server starten (openrc)
.LP
sudo rc-service sshd start
.br
rc-service sshd stop
.br
rc-update show //zeigt start scripts
.br
rc-update add sshd
.br
rc-update del sshd
.NH 2
auf ssh-server vom Client aus zugreifen
.LP
ip route get 1.2.3.4 | awk '{print $7}'  bzw ip a //gibt ip-adresse (macht man aufm Server)
.br
ssh username@192.168.0.1   //remote zugriff auf Server (username und ip vom Server)
.br
ssh-keygen -t ed25519             //generiert key zur Authentifikation
.br
ssh-copy-d username@192.168.0.1   //, der erlaubt ssh ohne login zu benutzen
.br
exit      //im ssh prompt, logt aus der remote maschine
.NH
rsync (Dateitransfer über ssh)
.LP
rsync file newfile --progress //cp syntax
.br
rsync file [username]@192.168.0.1:/ordner_wo_datei rein soll  //kopiert mit ssh
.br
rsync -urvP [username]@192.168.0.1:/ordner_wo_datei rein soll  //kopiert mit ssh
.br
//u -> aktualisiert nur Dateien, die schon da sind, kopiert nichts neues rein
.br
//r -> Ordner können mit ihrem Inhalt rekursiv kopiert werden
.br
//v -> Die Ausgabe wird verbaler bzw man kriegt eine Ausgabe
.br
//P -> progess
.NH
.XN wc (word count)
.LP
wc -l -> gibt Zeilenanzahl in der Eingabedatei aus
.br
wd -w -> gibt Wörteranzahl in der Eingabedatei aus
.br
wc -b -> gibt Bytesanzahl in der Eingabedatei aus
.br
wc -> gibt Zeilenanzahl,Wörteranzahl, Bytesanzahl aus
.NH
.XN diff, patch und git
.NH 2
diff  (stellt Unterschiede fest)
.LP
diff datei aktualisiertedatei -> gibt die Unterschiede zwischen beiden Dateien aus;
.br
diff -u datei aktualisiertedatei > diffdatei.diff -> gibt die Unterschiede zwischen beiden Dateien aus, formatiert als eigene Diff-Datei
.NH 2
patch (patcht die Unterschiede)
.LP
patch < diffdatei.diff -> patch die alte Datei mit den neuen Sachen
.br
patch -R < diffdatei.diff -> macht patch rückgängig
.NH 2
git  (modernere Versionskontrolle)
.LP
git init -> erstellt repository
.br
git add .  -> alles im Ordner kommt ins Repository
.br
git commit -m "ein commit"
.br
git log -> gibt log der commits aus
.br
git checkout commitnummer -> geht zu diesem commit zurück
.NH
.XN grep (filtert Eingabe nach regulären Ausdrücken)
.LP
grep ".*rc" textdatei  //markiert jede Zeile, die mit rc endet und eine beliebige Anzahl an vorherigen Chars hat, wobei egal ist, was für chars dies sind
.br
find . | grep ".*\.c" //suche in diesem Verzeichnis und gebe alles aus, was mit .c aufhört
.br
grep "k\+\.c" txt  //mindestens ein Zeichen muss zwischen k und .c sein
.br
grep "c$" txt //sucht nach c am Zeilenende
.br
grep "^b" txt //sucht nach b am Zeilenanfang
.br
grep "\\S*boot" txt //sucht nach allen nicht Leerzeichen vor boot
.br
grep "https\\?" txt //sucht nach einem Wort, welches mit http oder https anfängt
.br
grep -i it txt  //egal ob it klein oder großgeschrieben wurde, standardmäßig ist das aus
.br
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

.NH
.XN find (sucht Dateien in Verzeichnissen)
.LP
find ~ -name  threads.c | grep c++   //sucht Nutzerverzeichnis nach Datei "threads.c" ab
.br
find / -name  ".*rc" //sucht ganzes System nach einer Datei ab, die mit rc endet
.br
find ~ -type d -name c++   //sucht nur nach Ordnern, wohingegen jeder find befehl ohne -type d als type -f ausgeführt wird und nur nach Dateien such
.br
find ~ -size +120k -size -1G  //sucht nach Dateien im Größenbereich 120kb und 1Gb
.NH
.XN cut (schneidet Text reihenbasiert aus)
.LP
cut -c1-5,8 text //gibt ersten bis fünften und achten Buchstaben in jeder Reihe von text aus
.br
cut -b1,3-4 text //nur erster und dritter bis vierter Byte in jeder Zeile von text wird ausgegeben
.br
cut -d "," -f1 text //alles links vom Komma in jeder Zeile wird ausgegeben
.br
cut -d "," -f2 text //alles rechts vom Komma in jeder Zeile wird ausgegeben
.NH
.XN awk (Text processing (teilweise reihenbasiert))
.LP
ps | awk '{print $1}' //gibt erste spalte von ps aus ($0 ist jede Spalte)
.br
awk -F ":" '{print $1,$4}' /etc/passwd  //macht den Seperator von awk einen Doppelpunkt statt einer Leertaste, somit gibt awk die Spalte vorm ersten Komma und die Spalte vom vierten Komma aus
.br
awk -F ":" '{print $1 " " $3 "\\\\" $5}' /etc/passwd //gibt aus ->erste_Spalte dritte_Spalte\\fünfte_Spalte
.br
awk 'BEGIN{FS=":"; OFS="-"} {print $1,$6,$7}' /etc/passwd   //FS=Field Seperator  OFS=Output-FS der Befehl gibt die Zeilen nur ander seperiert aus
.br
awk -F "/" '/^\\//  {print $NF}' /etc/shells  //-F bestimmt Fieldseperator; '/ ... /' ist die Reguläreausdrucksuchsyntax; ^\\/ -> sucht jede Zeile mit / als Zeilenanfang; $NF = Endspalte
.br
awk -F "/" '/^\\//  {print $NF}' /etc/shells | sort | uniq //sortiert die Shellausgabe und liefert nur Unikate (uniq braucht vorsortierte Zeilen)
.br
df | awk '/\\/dev\\/nvme/ {print $1"\\t"$2"\\t"$3}'  //wie man hier gut sehen kann braucht jedes / als Erkennungszeichen vorher ein \\, damit awk weiß, dass die Suche noch spezifiziert wird; \t seperiert die Spalten mit tabs
.br
df | awk '/\\/dev\\/nvme/ {print $1"\\t"$2+$3}' //addiert die zweite und dritte Spalte zu einer
.br
awk 'length($0) > 7' /etc/shells  //filtert die Zeilen danach, ob sie länger als sieben Zeichen sind
.br
ps -ef | awk '{ if($NF == "/bin/zsh") print $0}' //gibt nur Prozesse aus, deren letzte Spalte in der Zeile /bin/zsh sind
.br
awk 'BEGIN { for(i=1; i<=10; i++) print "Das Quadrat von",i, "ist", i*i;}' //BEGIN -> wird nur einmal ausgeführt und am Anfang; ist eine for-
.br
Schleife
.br
awk 'NR==2, NR==5 {print NR, $0}' /etc/shells //gibt alle Zeilen von 2 bis 5 aus; NR = Zeilennummer; ohne NR bei print hat man keine Zeilennummer
.br
awk 'END {print NR}' /etc/shells /etc/passwd //gibt Summe der Zeilen aus shells und passwd aus; END -> print Befehl wird am Ende ausgeführt; nur eine Eingabedatei sorgt natürlich dafür, dass nur ihre Zeilenanzahl ausgegeben wird
.br
awk '{print substr($0, 6)}' /etc/shells  //gibt nur den Zeilenrest ab dem sechsten Zeichen
.NH
.XN sed (Textprocessing, aber diesmal nur mit regulären Ausdrücken und einfacher als awk)
.LP
sed -i -> jetzt wird Datei nicht nur gefiltert ausgegeben, sondern auch direkt geändert
.br
sed "s/c/C/g" datei //s=substitute; jedes kleine c wird mit dem großen C ersetzt; g=ersetzt jedes c in einer Zeile; ohne g -> ersetzt nur einmal in jeder Zeile
.br
sed "s/#.*//g" datei // alles nach # wird ersetzt durch nichts, da / alleine steht
.br
sed 11q datei -> bescheuerte Art nur die ersten elf Zeilen einer Datei auszugeben, wenn mans wie head benutzt
.br
sed "s/#.*//g; /cf/ d" datei -> wie das davor, nur löschts alle cf Zeilen (p statt d wäre print und q statt d wäre quit)
.br
sed "s/#.*//g; /^$/ d" datei -> wenn der Anfang gleich dem Ende ist (also eine Leerzeile vorliegt), lösche die Zeile
.TC
