.ds RH Kurzanleitung zu Assembler x86
.TL
Kurzanleitung zu Assembler x86
.AU
Alexander Ginschel
.NH
Grundlegendes
.NH 2
Größen
.LP
8 bits sind ein Byte. Zwei Bytes sind ein Word (16bit). Zwei Words/Wörter sind ein dword(Doubleword/32bit) und zwei dwords sind ein qword (Quadroword/64bit).
.br
0x80 bzw 80H -> Hexadezimal für 128
.NH
C-Programme in Assembler konvertieren
.LP
gcc -S -masm=intel cprogramm.c -o konvertiert.s
.br
Kleine Randnotiz! Der Compiler benutzt nach der Compilierung die Variablennamen nicht mehr. Nur ihre Werte und Funktionennamen bleiben im Assemblercode erhalten!
.NH 2
Speicher
.LP
Der Arbeitsspeicher wächst in zwei Richtungen. Der Heap, der Speicherplatz zur Zeit der Laufzeit zuweist, wächst nach unten (also bis zum letzten physischen Arbeitsspeicher).
.br
Der Stack, der die statisch zugewiesenen Daten speichert, wächst nach oben (in Nullrichtung). Dessen Daten genutzter Speicherplatz kann nicht erweitert werden, wie beim viel größeren Heap.
.NH
Maschinencode bzw ausführbare Dateien in Assembler konvertieren
.LP
objdump -M intel -S ausführbaredatei > dumpdatei
.NH
Assemblersektionenarchitektur
.LP
section .text -> dort sind die ganzen Befehle
.br
section .data -> initialiserte,statische Variablen, die auf den Stack kommen
.br
section .rdata -> wie .data nur schreibgeschützt
.br
section .bss (block starting symbol) -> für unitialisierte Variablen, die noch 0 sind
.NH
Register
.LP
RAX/EAX/AX/AH(High-Byte von AX)/AL(Low Byte von AX) -> Akkumulatorregister, was oft für arithmetische Operationen und Returns/Rückgabewerten von Funktionen genutzt wird und Input/Output bei Syscalls
.sp
RBX/EBX/BX/BH/BL -> Baseregister
.sp
RCX/ECX/CX/CH/CL -> Countregister, Schleifenzähler
.sp
RDX/EDX/DX/DH/DL -> Datenregister
.sp
RSP/ESP/SP/SPL -> Stackpointer; speichert momentane Position im Stack, hat bei jedem Programmstart einen anderen Startwert
.sp
RBP/EBP/BP/BPL -> wird dazu benutzt bei Funktionsaufrufen den Stackpointer dort zu speichern
.sp
RSI/ESI/SI/SIL -> Quell-/Sourceindex von Stringoperationen
.sp
RDI/EDI/DI/DIL -> Ziel-/Destinationindex für Stringoperationen
.sp
RIP/EIP/IP -> enthält Adresse des Befehls, der als nächstes ausgeführt werden sollte
.sp
R8-R15 -> 64bit Register für alles
.sp
CS/DS/SS/ES/FS/GS -> 16bit Segmentregister von den Segmenten Code (.text)/Data (.data)/Stack/Extra/General/General [DS:ip wäre übrigens zb Datasegment:Offset und würde somit eine physikalische Adresse ergeben]
.sp
RFLAGS/EFLAGS -> Statusflaggen, die jeweils ein Bit enthalten, beispielsweise ZF (zero-flag), CF (carry-flag), SF (sign-flag), TF (trap-flag)
.NH
x86 Grundbefehle
.LP
mov eax, ebx; mov eax, 0x13, mov eax, [0x4000000] -> Kopiert Wert eines Registers oder wo es hinzeigt in ein anderes Register
.sp
lea eax, [ebx+esi*4] -> (load effective address) Kopiert die berechnete Adresse in eax
.sp
add eax, 0x2; sub eax, 0x1; inc eax; dec eax -> Addieren, Subtrahieren, um Eins erhöhen oder erniedrigen (dec)
.sp
mul eax, 0x5; div eax, 0x5; imul eax, 0x5; cdq; idiv eax,0x5; -> mul multipliziert den operanden mit eax und speichert in eax. div dividiert operanden durch eax, speichert das Ergebnis in eax und den Rest in edx (imul und idiv sind die gleichen Befehle nur für vorzeichenlose Zahlen und cdq kommt immer vor idiv)
.sp
xor eax, eax; or eax, ebx; and eax, ebx; not eax -> vergleicht Werte in Binär und speichert im ersten Operanden
.sp
shl bl, 0x4; shr bl, 0x4; rol bl, 0x4; ror bl, 0x4; -> shl bl, 0x4 heißt: verschiebe bl vier Mal nach links und füge hinten vier Nullen an; shr -> shift right; und rol ist rotiere nach links, ergo platziere das erste Bit ans Ende des Bytes beispielsweie; ror-> das selbe nur umgekehrt
.sp
nop -> tue nichts (no operation)
.sp
jz 0x4000000; jnz ...; je ...; jne ..; jg ...; jge ...; jl ...; jle ...; ja ...; jb ...; jae ...; jbe ...; jo ...; js ...; jmp -> Alle machen Sprünge, die davon abhängen, ob Flaggen gesetzt sind, die diese Befehle erfordern. jz->wenn Ergebnis 0 ist; jnz -> not zero; jg -> größer als; jge -> größer als oder gleich; jl -> kleiner als; jle...; ja ->größer als 0; jae -> großer bzw gleich 0; jb -> unter Null also signed; jbe...; jo -> Overflow -> Ergebnis passt nicht ins Register; js -> prüft, ob der Wert signiert ist; jmp -> konditionslos
.sp
test eax, eax; cmp eax, 0x4 -> test ist ein logisches und und prüft, ob eax gleich 0 ist, wohingegen cmp 4 von eax subtrahiert und prüft, ob dies Null ergibt
.sp
rep; repe; repz; repne; repnz -> Stringbefehlprefixe, die ecx dekrementieren und esi und edi inkrementieren; rep -> repeat; repe -> repeat while equal; repz -> repeat while zero; repne -> repeat while not equal; repnz -> repeat while not zero
.sp
repe cmpsb ->(compare string byte, gibt auch cmpsw) vergleicht die zwei Buffer/Strings solange ecx nicht 0 ist, da ecx die Bufferlänge in diesem Fall darstellt
.sp
rep stosb -> (store string byte) überschreibt edi mit dem Wert von AL
.sp
rep movsb -Y (move string byte) kopiert esi in edi solange ecx, die Bufferlänge, nicht 0 ist
.sp
repne scasb (scan string byte) durchsucht den von edi referenzierten Buffer und subrahiert Al solange von dem referenzierten Wert, wie das Ergebnis nicht 0 ist oder ecx, die Bufferlänge, nicht 0 ist
.sp
push eax; pop ebx; pusha; pushad; popa; popad -> push und pop sind die normalen Stackbefehle. push, popa machen diese Operationen für 16bit-Werte, wohingegen pushad, popad dies nur für 32bit Werte machen
.sp
call 0x41001000 -> Funktionsaufruf, EIP kriegt als Wert den Befehl nach dem Call und wird auf den Stack gepusht
.sp
ret -> poppt Stack und springt zur Adresse, wohin der neue Wert zeigtNH
Kompilation (32bit x86-Architektur)
.LP
nasm -f elf32 assembler.s -o kompilat.o && ld -m elf_i386 kompilat.o -o programm
.br
\./programm -> startet das Programm
.br
elf32 -> executable linking format 32; ld -> linker
.NH
Assembler x86 Programmierung
.NH 2
Einfacher Output
.LP
.B1
global _start ; Hauptfunktion wird für den Linker benannt
.br
_start:
.br
	mov ecx, 4
.br
	mov eax, 1 ; Betriebssystem weiß, dass nach syscall das Programm beendet wird
.br
	add ebx, ecx ; ebx wird 4, also wird der Fehlercode 4 ausgegeben
.br
	int 0x80 ; int heißt interrupt und int 0x80 ruft den 32bit syscall auf
.B2
Mit echo $? bekommt man den Fehlercode bzw das Ergebnis von ebx ausgegeben.
.NH 2
String/Variablenoutput
.LP
.B1
global _start ; Hauptfunktion wird für den Linker benannt
.br
section .data
.br
var db "Var:  " ; db = define byte
.br
len equ $- var ; bestimmt Länge von var
.br
section .text
.br
_start:
.br
	mov byte [var+6], 0x0a ; fügt Zeilenumbruch am Ende des String ein (byte ptr wäre zb masm syntax statt der jetzigen von Netwideassembler)
.br
; mov byte sagt dem Prozessor, was genau kopiert wird
.br
	mov eax, 4 ; bestimmt fürs Betriebssystem bzw Linux, dass ausgegeben wird
.br
	mov ebx, 1 ; bestimmt stdoutput
.br
	mov ecx, var ; String zum Ausgeben
.br
	mov edx, len ; Stringlänge zur Ausgabe
.br
	add edx, 48 ; 6 nimmt Dezimalwert des Chars 6 an, und kann so ausgegeben werden
.br
	mov dword [var+5],edx ; An die fünften Stelle von var wird der Wert aus dex reinkopiert
.br
	sub edx, 3 ; edx ist wieder 5
.br
	int 80H ; Abschicken der Registerwerte ans Betriebssystem
.B2
.NH 2
Schleifen
.LP
.B1
global _start
.br

_start:
.br
	mov edx, 5 ; Startwert
.br
	mov ecx, 3 ; Schleifenstartwert
.br
schleife:
.br
	dec ecx ; decrease ecx
.br
	add edx, edx
.br
	cmp ecx, 0 ; Flagge im Register wird gesetzt, auf welche jg reagiert
.br
	jg schleife ; Schleife geht solange bis ecx nicht 0 ist
.br
	mov eax, 1
.br
	mov ebx, edx ; Der Wert von edx wird als Fehlercode ausgegeben
.br
	int 0x80 ; syscall
.B2
.NH 2
Stack
.LP
Die Stackwerte werden standardmäßig durch den Stackpointer adressiert, da die push und pop Befehle nur Einfluss auf den Stackpointer esp(32bit) bzw sp(16bit) haben.
.br
Bei jedem Push wird der Prozessorarchitektur entsprechend die Adresse in esp mit 4 subtrahiert, da es auf ein 32bit Register zeigt und somit um vier ganze Bytes verschoben werden muss, um auf einen neuen Eintrag im Stack zu zeigen. Es wird übrigens subtrahiert, da der Stack in Nullrichtung wächst!
.br
push 1337 -> ist das selbe wie: sub esp, 4 | mov [esp], dword 1337
.sp
Beim Pop wird hingegen der momentane Stackwert einem im Operanden festgelegten Wert zugewiesen und der Stackpointer wieder auf die vorherige Adresse gesetzt. Er wird nicht gelöscht, sondern beim nächsten Push überschrieben.
.br
pop ebx -> entspricht: mov ebx, dword [esp] | add esp, 4
.sp
Genz nebenbei: Var im letzten Stringbeispiel ist nichts anderes als ein Pointer, der auf einen Array (einen Chararray um genau zu sein) zeigt, weswgegen man genauso gut auch in dem Beispiel den esp hätte nehmen können, der ecx übergeben wird, wobei edx die Stringlänge bestimmt. Man müsste jedoch dann mühsam die einzelnen Bytes den Adressen nach [esp] zuweisen.
.NH 2
Funktionen
.LP
Funktionen realisiert man in Assembler mit einem call Befehl. Dieser puht die Adresse vom direkt nächsten Befehl nach call auf den Stack und sprint zum Label bzw der Instructionpointeradresse, die im gegeben wurde. Zurück springt man mit einem pop eax | jmp eax, insofern der momentane Stackwert noch der Befehlsadresse unter dem call entspricht.
.br
pop eax | jmp eax kann man übrigens mit ret abkürzen.
.NH 3
Prolog und Epilog
.LP
Mithilfe von Basepointern kann man recht einfach den Stackwert mit der Adresse direkt nach dem call Befehl sichern und so dafür sorgen, dass der ret Befehl auch richtig funktioniert.
.br
Dafür verwendet man den Prolog und den Epilog.
.B1
---Prolog---
.br
push ebp ; sorgt dafür, dass man falls man in einer Funktion eine andere Funktion aufruft, nicht den ursprünglichen Basepointerwert verliert
.br
mov ebp, esp ; speichert Stackpointer
.br
 ... ; irgendeine Befehlsabfolge
.br
---Epilog---
.br
mov esp, ebp ; gibt Stackpointer den alten Wert
.br
pop ebp ; gibt Basepointer den alten Wert zurück
.br
ret ; pop eax | jmp eax
.B2
.NH
Nutzungen von C-Funktionen
.LP
Man kann C-Funktionen in Assembler verwende, nur sollte man darauf achten, dass man das Assemblerkompilat am Ende mit gcc zu einem Programm zusammenfasst, damit zu den C-Headern gelinkt wird. -> gcc -m32 kompilat.o -o programm
.B1
global main ; c braucht main Funktion
.br
extern printf
.br
section .data
.br
msg db "Eine Zahl %i", 0x0a,0x00 ; C-konformer String für printf mit Zeilenumbruch und Nullbyte
.sp
section .text
.br
main:
.br
push ebp
.br
mov ebp, esp ; bis jetzt nur Prolog
.br
push 17 ; jetzt fängt die umgekehrte Parameterangabe für printf
.br
push msg ; die Parameter werden nacheinander in printf vom Stack genommen, jedoch nicht gepoppt, was der Programmierer machen soll
.br
call printf
.br
mov eax, 0 ; Main muss immer 0 ausgeben
.br
mov esp, ebp ; jetzt fängt der Epilog an
.br
pop ebp
.br
ret
.B2
.NH
Assemblerfunktionen in C nutzen
.NH 2
Assemblerdatei erstellen
.LP
mal3.s (wird mit nasm -f el32 mal2.s -o mal.o kompiliert)
.B1
global mal3 ; Funktionsname
.br
mal2:
.br
push ebp
.br
mov ebp, esp ; Prolog
.br
mov eax, [ebp+8] ; der von C übegebene Parameter ist zwei Adressen entfernt, wegen push ebp und dem Funktioncall
.br
add eax, eax
.br
mov esp, ebp : Epilog
.br
pop ebp
.br
ret
.B2
.NH 2
Headerdatei für C erstellen
.LP
mal2.h
.B1
int mal2(int c); //bloße Deklairerung der Funktion
.B2
.NH 2
Auf Assemblerfunktion in C zugreifen
.LP
main.c (am Ende wird mit gcc -m32 mal2.o main.c -o mal3 kompiliert und verlinkt)
.B1
#include "mal2.h" //mal.o findet der Header schon selbst, wenn er von gcc verlinkt wird
.br
#include <stdio.h>
.br
int main() {
.br
printf("Zahl: %i\\n", mal2(3); //gibt 10 aus
.br
}
.B2
.NH
Reverseengineeringnotizen
.LP
X DW ? -> unititialisierte Variable X
.br
mov byte ptr [var], 5 -> kopiere 5 in das Byte der Adresse, worauf var zeigt (in nasm ohne ptr, denn masm hat es in der Syntax)
.br
mov eax, byte ptr 5 -> kopiere das byte 5 in das 32bit Register eax (als Lowbyte, da eax viermal größer als ein Byte ist)
.br
mov eax,0 ist das selbe wie xor eax, eax nur schneller in der Laufzeit
.br
Calling conventions
.br
cdecl -> Stack für den Functioncall/Funktionsaufruf wird nicht von der Funktion gesäubert, sondern von der aufrufenden Funktion durch beispielsweise ein [esp+18]. Des Weiteren wird der Rückgabewert in eax gespeichert
.br
stdcall -> wie cdecl nur, dass die aufgerufene Funktion den Stack mit einem leave (was dem Epilog entspricht, den gcc mit leave einfach abkürzt [der Prolog wäre übrigens enter) säubert
.br
fastcall -> Windows tendiert dazu, dass Funktionsparameter in ECX, RDX und in R8 gespeichert werden
