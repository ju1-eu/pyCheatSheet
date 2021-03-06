---------------------------------------------------------------------------
Nützliche, einzeilige Scripts für SED (Unix Stream Editor)    29. Dez. 2005
Zusammengstellt von Eric Pement - pemente[at]northpark[dot]edu  version 5.5
Übersetzt von Stefan Waidele jun. - Stefan[at]Waidele[dot]info   5.5-de-0.9

Original:
USEFUL ONE-LINE SCRIPTS FOR SED (Unix stream editor)        Dec. 29, 2005
Compiled by Eric Pement - pemente[at]northpark[dot]edu        version 5.5

http://sed.sourceforge.net/sed1line_de.html

Die aktuelle Version dieser Datei ist im englischen Original 
unter folgender Adresse zu finden:
   http://sed.sourceforge.net/sed1line.txt
   http://www.pement.org/sed/sed1line.txt

Diese Datei ist auch in anderen Sprachen erhältlich:
   Chinesische - http://sed.sourceforge.net/sed1line_zh-CN.html
   Czech       - http://sed.sourceforge.net/sed1line_cz.html
   Holländer   - http://sed.sourceforge.net/sed1line_nl.html
   Franzosen   - http://sed.sourceforge.net/sed1line_fr.html
   Deutscher   - http://sed.sourceforge.net/sed1line_de.html

   Portugiese  - http://sed.sourceforge.net/sed1line_pt-BR.html


ZEILEN-ABSTÄNDE:

 # Doppelter Zeilenvorschub
 sed G

 # Doppelter Zeilenabstand für Dateien, die Leerzeilen enthalten.
 # Die Ausgabe sollte keine zwei aufeinander folgenden Leerzeilen enthalten.
 sed '/^$/d;G'

 # Dreifacher Zeilenvorschub
 sed 'G;G'

 # Doppelter Zeilenvorschub rückgängig machen
 # (Annahme: jede zweite Zeile ist leer)
 sed 'n;d'

 # Füge eine Leerzeile über jeder Zeile ein, die "regex" enthält
 sed '/regex/{x;p;x;}'

 # Füge eine Leerzeile unter jeder Zeile ein, die "regex" enthält
 sed '/regex/G'

 # Füge eine Leerzeile über und unter jeder Zeile ein, die "regex" enthält
 sed '/regex/{x;p;x;G;}'

Nummerierung

 # Nummeriere alle Zeilen (linksbündig). Der Tabulator anstelle von Leerzeichen
 # erhält den Rand. (siehe auch die Bemerkung zu '\t' am Ende dieser Datei)
 sed = filename | sed 'N;s/\n/\t/'

 # Nummeriere alle Zeilen (Zahl rechtsbündig in linker Spalte)
 sed = filename | sed 'N; s/^/     /; s/ *\(.\{6,\}\)\n/\1  /'

 # Nummeriere alle Zeilen, aber die Nummern von Leerzeilen werden nicht ausgegeben.
 sed '/./=' filename | sed '/./N; s/\n/ /'

 # Zeilen zählen (Nachahmung von "wc -l")
 sed -n '$='

TEXT UMWANDLUNG UND ERSETZUNG:

 # IN EINER UNIX UMGEBUNG: Wandle DOS Zeilenvorschübe (CR/LF) in das Unix-Format.
 sed 's/.$//'               # Annahme: Alle Zeilen enden mit CR/LF
 sed 's/^M$//'              # Bei bash/tcsh: Ctrl-V dann Ctrl-M
 sed 's/\x0D$//'            # für ssed, gsed 3.02.80 oder neuere Versionen

 # IN EINER UNIX UMGEBUNG: Wandle Unix Zeilenvorschübe (LF) in das DOS-Format.
 sed "s/$/`echo -e \\\r`/"            # ksh
 sed 's/$'"/`echo \\\r`/"             # bash
 sed "s/$/`echo \\\r`/"               # zsh
 sed 's/$/\r/'                        # gsed 3.02.80 oder neuere Versionen

 # IN EINER DOS UMGEBUNG: Wandle Unix Zeilenvorschübe (LF) in das DOS-Format.
 sed "s/$//"                          # Möglichkeit 1
 sed -n p                             # Möglichkeit 2

 # IN EINER DOS UMGEBUNG: Wandle DOS Zeilenvorschübe (CR/LF) in das Unix-Format.
 # Die kann mit mit der UnxUtils Version von sed, Version 4.0.7 oder neuer
 # gemacht werden. Die UnxUtils Version von sed kann durch die zusätzliche
 # "--text" Option bestimmt werden, die beim Aufruf mit "--help" angezeigt wird.
 # Ansonsten kann die Umwandlung von DOS-Zeilenvorschüben in UNIX-Zeilenvorschübe
 # nicht mit sed unter DOS vorgenommen werden. Benutzen Sie stattdessen "tr".
 sed "s/\r//" infile >outfile         # UnxUtils sed v4.0.7 oder neuer
 tr -d \r <infile >outfile            # GNU tr Version 1.22 oder neuer

 # Lösche alle Einrückungen (Leerzeichen, Tabulatoren) vom Anfang jeder Zeile
 # Richtet alle Zeilen linksbündig aus.
 sed 's/^[ \t]*//'                    # (siehe auch die Bemerkung zu '\t' am Ende dieser Datei)

 # Lösche unsichtbare Zeichen (Leerzeichen, Tabulatoren) vom Ende aller Zeilen
 sed 's/[ \t]*$//'                    # (siehe auch die Bemerkung zu '\t' am Ende dieser Datei)

 # Lösche unsichtbare Zeichen sowohl am Anfang als auch am Ende jeder Zeile
 sed 's/^[ \t]*//;s/[ \t]*$//'

 # Füge 5 Leerzeichen am Anfang jeder Zeile ein. (Einrückung)
 sed 's/^/     /'

 # Alle Zeilen rechtsbündig ausrichten (Spaltenbreite: 79 Zeichen)
 sed -e :a -e 's/^.\{1,78\}$/ &/;ta'  # set at 78 plus 1 space

 # Zentriere alle Zeilen in einer 79-Zeichen breiten Spalte.
 # Bei Methode 1 bleiben Leerzeichen am Zeilenanfang und -ende erhalten.
 # Bei Methode 2 werden Leerzeichen am Zeilenanfang gelöscht und es
 # folgen keine Leerzeichen am Zeilenende.
 sed  -e :a -e 's/^.\{1,77\}$/ & /;ta'                     # Möglichkeit 1
 sed  -e :a -e 's/^.\{1,77\}$/ &/;ta' -e 's/\( *\)\1/\1/'  # Möglichkeit 2

 # Ersetze (Suchen und Ersetzen) "foo" mit "bar" in jeder Zeile
 sed 's/foo/bar/'                    # Ersetzt nur das 1. Vorkommen pro Zeile
 sed 's/foo/bar/4'                   # Ersetzt nur das 4. Vorkommen pro Zeile
 sed 's/foo/bar/g'                   # Ersetzt ALLE Vorkommen von "foo" mit "bar"
 sed 's/\(.*\)foo\(.*foo\)/\1bar\2/' # Ersetzt nur das vorletzte Vorkommen pro Zeile
 sed 's/\(.*\)foo/\1bar/'            # Ersetzt nur das letzte Vorkommen pro Zeile


 # Ersetze "foo" mit "bar" NUR in Zeilen die "baz" enthalten
 sed '/baz/s/foo/bar/g'

 # Ersetze "foo" mit "bar" AUSSER in Zeilen die "baz" enthalten
 sed '/baz/!s/foo/bar/g'

 # Ersetze "scarlet", "ruby" oder "puce" mit "red"
 sed 's/scarlet/red/g;s/ruby/red/g;s/puce/red/g'   # Die meisten seds
 gsed 's/scarlet\|ruby\|puce/red/g'                # Nur GNU sed 

 # Kehre die Reihenfolge der Zeilen um (entspricht "tac")
 # Bug/Feature in HHsed v1.5 löscht hierbei Leerzeilen
 sed '1!G;h;$!d'               # Möglichkeit 1
 sed -n '1!G;h;$p'             # Möglichkeit 2

 # Kehre die Reihenfolge der Buchstaben innerhalb jeder Zeile um (entspricht "rev")
 sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//'

 # Füge Zeilenpaare nebeneinander zusammen (entspricht "paste")
 sed '$!N;s/\n/ /'

 # Falls eine Zeile mit einem Rückwärtsstrich "\" endet, füge die nächste hinzu.
 sed -e :a -e '/\\$/N; s/\\\n//; ta'

 # Falls eine Zeile mit einem Gleichheitszeichen "=" beginnt, 
 # füge die vorhergehende hinzu und ersetzt das "=" mit einem Leerzeichen.
 sed -e :a -e '$!N;s/\n=/ /;ta' -e 'P;D'

 # Füge Kommas in Zahlenfolgen ein. Aus "1234567" wird "1,234,567"
 gsed ':a;s/\B[0-9]\{3\}\>/,&/;ta'                     # GNU sed
 sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'  # Andere seds

 # Füge Kommas in Zahlenfolgen mit Dezimalpunkt und Vorzeichen ein.  (GNU sed)
 gsed -r ':a;s/(^|[^0-9.])([0-9]+)([0-9]{3})/\1\2,\3/g;ta'

 # Füge alle 5 Zeilen eine Leerzeile ein. (Nach 5, 10, 15, 20,... Zeilen)
 gsed '0~5G'                  # GNU sed
 sed 'n;n;n;n;G;'             # andere seds

DRUCKEN AUSGEWÄHLTER ZEILEN:

 # Ausgabe der ersten 10 Zeilen einer Datei (wie "head")
 sed 10q

 # Ausgabe der ersten Zeilen einer Datei (wie "head -1")
 sed q

 # Ausgabe der letzten 10 Zeilen einer Datei (wie "tail")
 sed -e :a -e '$q;N;11,$D;ba'

 # Ausgabe der letzten beiden Zeilen einer Datei (wie "tail -2")
 sed '$!N;$!D'

 # Ausgabe der letzten Zeilen einer Datei (wie "tail -1")
 sed '$!d'                    # Möglichkeit 1
 sed -n '$p'                  # Möglichkeit 2

 # Ausgabe der vorletzten Zeile einer Datei
 sed -e '$!{h;d;}' -e x              # Bei einzeiligen Dateien wird eine Leerzeile ausgegeben
 sed -e '1{$q;}' -e '$!{h;d;}' -e x  # Bei einzeiligen Dateien wird die Zeile ausgegeben
 sed -e '1{$d;}' -e '$!{h;d;}' -e x  # Bei einzeiligen Dateien wird nichts ausgegeben

 # Ausgabe der Zeilen, die durch den Regulären Ausdruck (Regex) definiert sind (wie "grep")
 sed -n '/regexp/p'           # Möglichkeit 1
 sed '/regexp/!d'             # Möglichkeit 2

 # Ausgabe der Zeilen, die den Reguläre Ausdruck NICHT erfüllen (wie "grep -v")
 sed -n '/regexp/!p'          # Möglichkeit 1, entspricht obiger Lösung
 sed '/regexp/d'              # Möglichkeit 2, Einfacher Syntax

 # Ausgabe der Zeile direkt oberhalb des Regex, jedoch nicht die Zeile 
 # die den Regex erfüllt.
 sed -n '/regexp/{g;1!p;};h'

 # Ausgabe der Zeile direkt unterhalb des Regex, jedoch nicht die Zeile 
 # die den Regex erfüllt.
 sed -n '/regexp/{n;p;}'

 # Ausgabe eine umgebende Zeile vor und nach der Regex, mit Angabe
 # der Zeilennummer der Zeile, die den Regex erfüllt. (ähnlich "grep -A1 -B1")
 sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h

 # Suche nach AAA und BBB und CCC (in beliebiger Reihenfolge)
 sed '/AAA/!d; /BBB/!d; /CCC/!d'

 # Suche nach AAA und BBB und CCC (in vorgegebener Reihenfolge)
 sed '/AAA.*BBB.*CCC/!d'

 # Suche nach AAA oder BBB oder CCC (wie "egrep")
 sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d    # die meisten seds
 gsed '/AAA\|BBB\|CCC/!d'                        # GNU sed

 # Ausgabe des Absatzes falls dieser AAA enthält (Leerzeilen trennen Absätze)
 # Für HHsed v1.5 muss 'G;' nach 'x;' eingefügt werden.
 sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;'

 # Ausgabe des Absatzes falls dieser AAA, BBB und CCC enthält. (Reihenfolge egal)
 # Für HHsed v1.5 muss 'G;' nach 'x;' eingefügt werden.
 sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;/BBB/!d;/CCC/!d'

 # Ausgabe des Absatzes falls dieser AAA, BBB oder CCC enthält.
 # Für HHsed v1.5 muss 'G;' nach 'x;' eingefügt werden.
 sed -e '/./{H;$!d;}' -e 'x;/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
 gsed '/./{H;$!d;};x;/AAA\|BBB\|CCC/b;d'         # nur GNU sed 

 # Ausgabe der Zeilen die 65 Zeichen lang oder länger sind
 sed -n '/^.\{65\}/p'

 # Ausgabe der Zeilen die kürzer als 65 Zeichen sind
 sed -n '/^.\{65\}/!p'        # Möglichkeit 1, entspricht obiger Lösung
 sed '/^.\{65\}/d'            # Möglichkeit 2, eifacherer Syntax

 # Ausgabe der Datei ab dem regulären Ausdruck bis zum Ende
 sed -n '/regexp/,$p'

 # Ausgabe eines Abschnittes der Datei, der durch Zeilennummern definiert ist
 # (hier: 8-12, inklusive)
 sed -n '8,12p'               # Möglichkeit 1
 sed '8,12!d'                 # Möglichkeit 2

 # Ausgabe von Zeile 52
 sed -n '52p'                 # Möglichkeit 1
 sed '52!d'                   # Möglichkeit 2
 sed '52q;d'                  # Möglichkeit 3, effizient für große Dateien

 # Ausgabe jeder 7. Zeile - beginnend bei Zeile 3
 gsed -n '3~7p'               # nur GNU sed
 sed -n '3,${p;n;n;n;n;n;n;}' # andere seds

 # Ausgabe des Teils der Datei, der zwischen den regulären Ausdrücken ist (inklusive der Regexs)
 sed -n '/Iowa/,/Montana/p'             # berücksichtigt die Groß/Kleinschreibung

LÖSCHUNG BESTIMMTER ZEILEN:

 # Ausgabe der Datei, AUSSER dem Teil, der zwischen den regulären Ausdrücken ist
 sed '/Iowa/,/Montana/d'

 # Löschung von aufeinander folgenden, identischen Zeilen (wie "uniq").
 # Die erste Zeile in einer Folge von Duplikaten wird ausgegeben, der Rest gelöscht.
 sed '$!N; /^\(.*\)\n\1$/!P; D'

 # Lösche identische, nicht aufeinander folgende Zeilen einer Datei.
 # Achten Sie darauf nicht die Buffer-größe des "Hold-spaces" zu überschreiten oder benutzen Sie GNU sed.
 sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'

 # Löscht alle Zeilen außer Duplikate (wie "uniq -d").
 sed '$!N; s/^\(.*\)\n\1$/\1/; t; D'

 # Löscht die ersten 10 Zeilen einer Datei
 sed '1,10d'

 # Löscht die letzte Zeile einer Datei
 sed '$d'

 # Löscht die zwei letzten Zeilen einer Datei
 sed 'N;$!P;$!D;$d'

 # Löscht die 10 letzten Zeilen einer Datei
 sed -e :a -e '$d;N;2,10ba' -e 'P;D'   # Möglichkeit 1
 sed -n -e :a -e '1,10!{P;N;D;};N;ba'  # Möglichkeit 2

 # Lösche jede 8. Zeile
 gsed '0~8d'                           # nur GNU sed
 sed 'n;n;n;n;n;n;n;d;'                # andere seds

 # Lösche Zeilen die die Regex erfüllen
 sed '/pattern/d'

 # Lösche ALLE Leerzeilen aus einer Datei (wie "grep '.' ")
 sed '/^$/d'                           # Möglichkeit 1
 sed '/./!d'                           # Möglichkeit 2

 # Lösche alle AUFEINANDER FOLGENDEN Leerzeilen außer der ersten;
 # außerdem, lösche alle Leerzeilen am Anfang und am Ende der Datei 
 # (Wie "cat -s")
 sed '/./,/^$/!d'          # Möglichkeit 1, lässt 0 Leerzeilen am Anfang, 1 am Ende der Datei
 sed '/^$/N;/\n$/D'        # Möglichkeit 2, lässt 1 Leerzeilen am Anfang, 0 am Ende der Datei

 # Lösche alle AUFEINANDER FOLGENDEN Leerzeilen, außer die ersten 2:
 sed '/^$/N;/\n$/N;//D'

 # Lösche alle Leerzeilen am Anfang einer Datei
 sed '/./,$!d'

 # Lösche alle Leerzeilen am Ende einer Datei
 sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'  # funktioniert bei allen seds
 sed -e :a -e '/^\n*$/N;/\n$/ba'        # ditto, außer bei gsed 3.02.*

 # Lösche die letzte Zeile jedes Absatzes
 sed -n '/^$/{p;h;};/./{x;/./p;}'

SPEZIELLE EINSATZGEBIETE:

 # Entferne nroff "overstrikes" (char, Rückschritt) aus Man-Seiten.
 # Die 'echo' Anweisung braucht eventuell die Option -e für die Unix System V shell oder bash.
 sed "s/.`echo \\\b`//g"    # Doppelte Anfürungszeichen werden in Unix-Umgebungen benötigt.
 sed 's/.^H//g'             # In bash/tcsh, Ctrl-V und dann Ctrl-H drücken
 sed 's/.\x08//g'           # Hex-Angabe für sed 1.5, GNU sed, ssed

 # nur die Usenet/E-Mail Kopfzeilen
 sed '/^$/q'                # Löscht alles nach der ersten Leerzeile

 # nur die Usenet/E-Mail Nachrichtentext
 sed '1,/^$/d'              # Löscht alles bis zur ersten Leerzeile

 # Die Betreffzeile einer E-Mail, aber ohne das "Subject: " am Zeilenanfang
 sed '/^Subject: */!d; s///;q'

 # Die Antwortadresse einer E-Mail
 sed '/^Reply-To:/q; /^From:/h; /./d;g;q'

 # Extrahiert die E-Mail-Adresse aus der Antwortadresse des vorherigen Scripts
 sed 's/ *(.*)//; s/>.*//; s/.*[:<] *//'

 # Ein Größer-Zeichen an jedem Zeilenanfang einfügen (Nachricht zitieren)
 sed 's/^/> /'

 # Größerzeichen am Zeilananfang löschen (Macht vorheriges script rückgängig)
 sed 's/^> //'

 # Entferne die meisten HTML-Auszeichnungen (inklusive die über mehrere Zeilen)
 sed -e :a -e 's/<[^>]*>//g;/</N;//ba'

 # Multi-part uuencodierte Binärdateien auspacken
 # und fehlerhafte Kopfzeilen entfernen, so dass nur die uuencodierten Daten 
 # übrig bleiben.
 # Die übergebenen Dateien müssen in der richtigen Reihenfolge sein.
 # Möglichkeit 1 kann auf der Kommandozeile ausgeführt werden,
 # Möglichkeit 2 kann als Unix-Shell-Script ausgeführt werden. (Basierend auf einem Script von Rahul Dhesi)
 sed '/^end/,/^begin/d' file1 file2 ... fileX | uudecode   # Möglichkeit 1
 sed '/^end/,/^begin/d' "$@" | uudecode                    # Möglichkeit 2

 # Sortiere die Absätze der Datei alphabetisch. Absätze werden durch Leerzeilen getrennt.
 # GNU sed benutzt \v als vertikale Tabulatoren (Alternativ kann auch jedes andere, 
 # eindeutige Zeichen verwendet werden)
 sed '/./{H;d;};x;s/\n/={NL}=/g' file | sort | sed '1s/={NL}=//;s/={NL}=/\n/g'
 gsed '/./{H;d};x;y/\n/\v/' file | sort | sed '1s/\v//;y/\v/\n/'

 # Komprimiere jede .TXT-Datei einzeln mit zip, lösche die Quelldatei
 # und benenne jede ZIP-Datei mit dem Namen der TXT-Datei ohne .TXT
 # (unter DOS: Der Befehl "dir /b" gibt die reinen Dateinamen in Großbuchstaben zurück)
 echo @echo off >zipup.bat
 dir /b *.txt | sed "s/^\(.*\)\.TXT/pkzip -mo \1 \1.TXT/" >>zipup.bat

TYPISCHE BEFEHLSZEILEN: Sed nimmt eine oder mehrere Bearbeitungsbefehle
entgegen und wendet diese, in der entsprechenden Reihenfolge auf jede
Zeile der Eingahe an. Nachdem alle Befehle auf die erste Zeile angewendet
wurden, wird diese ausgegeben, und die zweite Zeile wird zur Bearbeitung
entgegengenommen. Der Kreislauf wiederholt sich. Die vorhergehenden Beispiele
gehen davon aus, dass die Eingaben von der Standarteingabe (STDIN) kommen (d.h. z.B.
die Tastatur, bzw. i.d.R. wird die Eingabe von einer Pipe kommen).
Ein oderer mehrere Dateinamen können an die Befehlszeile angehängt werden,
fallt die Eingabe nicht von STDIN kommt. Die Ausgaben werden an die 
Standarteingabe geschickt, d.h. i.d.R. auf dem Bildschirm ausgegeben.
Daher gilt:

 cat filename | sed '10q'        # Benutzt die "Pipe" zur Eingabe
 sed '10q' filename              # gleicher Effekt, spart das unnötige "cat"
 sed '10q' filename > newfile    # Leitet die Ausgabe um ins Dateisystem

Weitere Erklärungen des Sysntax, inklusive der Möglichkeit Befehle
von einer Datei statt von der Befehlszeile zu benutzen sind in "sed &
awk, 2nd Edition," von Dale Dougherty und Arnold Robbins (O'Reilly,
1997; http://www.ora.com), "UNIX Text Processing," von Dale Dougherty
und Tim O'Reilly (Hayden Books, 1987) oder in den Anleitungen von Mike Arst
die als U-SEDIT2.ZIP au vielen Seiten zum Download bereit stehen zu finden.

Um alle Möglichkeiten von sed zu nutzen, muss man Reguläre Ausdrücke
verstehen. Hierfür können folgende Bücher herangezogen werden:
"Mastering Regular Expressions" von Jeffrey Friedl (O'Reilly, 1997).
Die Manual-Seiten ("man") auf Unix-Systemen können auch hilfreich sein.
("man sed", "man regexp", oder der Abschnitt über Reguläre Ausdrücke in
"man ed"), aber einige dieser Seiten sind für ihren Schwierigkeitsgrad
bekannt. Sie sind nicht als Einführung für neue Sed- oder Regex-Benutzer
geschrieben, sondern als Referenz für diejenigen, die diese Werkzeuge 
bereits beherrschen.

BENUTZUNG VON HOCHKOMMAS:
Die angeführten Beispiele schließen die Anweisungen in einfache 
Anführungszeichen ('...') anstatt der doppelten ("...") ein, da
sed typischerweise in einer Unix-Umgebung zur Anwendung kommt.
Einfache Anführungszeichen hindern die Unix-Shell (Kommandozeile)
daran, das Dollarzeichen ($) und die umgekehrten Hochkommas (`...`)
auszuwerten, wie dies bei der verwendung von doppelten Anführungszeichen 
("...") der Fall wäre.
Benutzer der "csh" Shell und deren Weiterentwicklungen müssen ausserdem
trotz verwendung von einfachen Anführungszeichen alle Ausrufezeichen (!) 
mit einem Rückwärtsstrich schützen (z.B. "\!") um die Beispiele korrekt 
ausführen zu können.
DOS-Versionen von sed benötigen allesamt doppelte Anführungszeichen ("...")
um die Befehle herum.

DIE BENUTZUNG VON '\t' IN SED-SCRIPTEN:
Der Deutlichkeit halber haben wir in diesem Dokument die Zeichenfolge '\t'
benutzt, um das Tabulatorzeichen (0x09) darzustellen. Die meisen Versionen
von sed kennen jedoch diese Darstellung nicht.
Bei der Eingabe der Befehle muss '\t' durch drücken der Tabulatortaste 
eingegeben werden. '\t' wird von awk, perl, HHsed, sedmod, und GNU sed
v3.02.80 in regulären Ausdrücken als Tabulator anerkannt.

VERSIONEN VON SED:
Die unterschiedlichen sed-versionen haben unterschied und man muss auch
mit leichten Unterschieden im Syntax rechnen. Besonders die Benutzung von
Marken (:name) oder Verzweigungen (b,t) innerhalb von Kommandos (nicht an
deren Ende) werden von vielen Versionen nicht unterstützt.
Wir haben eine Schreibweise gewählt, die sich mit den meisten Versionen
von sed benutzen lässt, auch wenn die beliebten GNU-Versionen von sed eine
elegantere Schreibweise erlauben würden.
Wem man einen ziemlich langen Befehl wie den folgenden sieht:

   sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d

ist es gut zu wissen, dass man diesen mit GNU-sed zu folgendem kürzen kann:

   sed '/AAA/b;/BBB/b;/CCC/b;d'      # oder sogar
   sed '/AAA\|BBB\|CCC/b;d'

Ausserdem ist zu beachten, dass obwohl viele Versionen von sed einen Befehl 
wie "/one/ s/RE1/RE2/" erlauben, einige "/one/! s/RE1/RE2/" NICHT erlauben,
was ein Leerzeichen vor dem 's' enthält. Bei der Eingabe der Befehle muss hier
das Leerzeichen weggelassen werden.

GESCHWINDIGKEITSOPTIMIERUNG:
Falls die ausfürungsgeschwindigkeit wegen großen Dateien oder langsamen CPUs
bzw. Festplatten erhöht werden muss, können Ersetzungen beschleunigt werden,
indem der gesuchte Ausdruck vor dem "s/.../.../" genannt wird. Es gilt:

   sed 's/foo/bar/g' filename         # Normales Suchen & Ersetzen
   sed '/foo/ s/foo/bar/g' filename   # Schnellere Version
   sed '/foo/ s//bar/g' filename      # sed Kurzschreibweise

Wenn bei der Auswahl oder Löschung von Zeilen nur Zeilen aus dem Dateianfang
ausgegeben werden sollen, verkürzt bei großen Dateien ein "quit" Befehl (q)
die Bearbeitungszeit erheblich. Daher:

   sed -n '45,50p' filename           # Ausgabe der Zeilen 45-50 einer Datei
   sed -n '51q;45,50p' filename       # dito, aber biel schneller.

Falls Sie weitere Scripte haben, und diese für dieses Dokument zur Verfügung
stellen möchten, oder falls Sie Fehler in diesem Dokument gefunden haben,
senden Sie bitte eine E-Mail an den Verwalter dieser Sammlung. (Fehler in der
Übersetzung melden Sie bitte dem Übersetzer.) Bitte geben Sie die
Problemstellung, die benutzte sed-Version und das benutze Betriebssystem an.
Um als "Einzeiler" zu gelten, darf die Befehlszeile höchstens 65 Zeichen
lang sein. Verschiedene Befehle in diesem Dokument wurden von den folgenden
Personen beigesteuert:

 Al Aab                   # Initiator der "seders" Mailing-Liste
 Edgar Allen              # Diverses
 Yiorgos Adamopoulos      # Diverses
 Dale Dougherty           # Author von "sed & awk"
 Carlos Duarte            # Author von "do it with sed"
 Eric Pement              # Author dieses Dokuments
 Ken Pizzini              # Author von GNU sed v3.02
 S.G. Ravenhall           # Das großartige De-HTML-Script
 Greg Ubben               # Viele Beitrage und Hilfe
-------------------------------------------------------------------------
Valid XHTML 1.0 Strict