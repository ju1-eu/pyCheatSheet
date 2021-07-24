#!/bin/bash -e
# ju 10-Aug-20

# Artikel aus den Ordnern erstellen
#   tex/
#  	archiv/
#	Tabellen/
#	content/beispiele/tex/
#   wird gespeichert in artikel/


# Variable anpassen
tex="tex"
archiv="archiv"
tabellen="Tabellen"
beispiele="content/beispiele/tex"
artikel="Artikel"
bsp="Bsp"
info="Artikel aus den Ordnern erstellen
	* '$tex/'
	* '$archiv/'
	* '$tabellen/'
	* '$beispiele/'
	*  wird gespeichert in 'artikel/'"
timestamp=$(date +"%d-%h-%y")
copyright="ju $timestamp"

echo "+ $info"

T1="\documentclass[a4paper,12pt]{scrartcl}
\input{content/metadata}%% anpassen
\usepackage{praeambel-artikel}% Pakete
% Literatur laden
\bibliography{content/literatur}      %% anpassen
\bibliography{content/literatur-kfz}  %% anpassen
\bibliography{content/literatur-sport}%% anpassen"
T2="\author{\autor}
\date{\today}
%\date{2020/08/01}%% anpassen
%\date{1-Aug-20}
%
\begin{document}
	%% anpassen
	%\maketitle
	%\tableofcontents  
	%\listoffigures 
	%\listoftables 
	%\lstlistoflistings

	%% anpassen	
	%\begin{abstract}
	%	Zusammenfassung
	%\end{abstract}"
T3="
	%\printindex% Index (Register)
	% Bibliographie
	%\phantomsection\addcontentsline{toc}{section}{Literatur}
	\printbibliography% Literaturverzeichnis
\end{document}"

# tex/
cd $tex
EXTENSION="tex" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
if [ $exist -ge 1 ]; then
	for i in *.tex; do
		if [ ! "Neu.tex" = "$i" ]; then
			# dateiname ohne Endung
			texname=`basename "$i" .tex`
			echo "% $copyright"       > ../$artikel/$texname-artikel.tex # file neu anlegen
			echo "$T1"               >> ../$artikel/$texname-artikel.tex
			echo "%% anpassen
\title{$texname}"                    >> ../$artikel/$texname-artikel.tex
			echo "$T2"               >> ../$artikel/$texname-artikel.tex
			echo "
		%% anpassen
		%-------------------------------------------------
		%
			\input{$tex/$i}
		%
		%-------------------------------------------------" >> ../$artikel/$texname-artikel.tex
			echo "$T3"                                      >> ../$artikel/$texname-artikel.tex
		fi
	done
fi
cd ..

# archiv/
cd $archiv
EXTENSION="tex" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
if [ $exist -ge 1 ]; then
	for i in *.tex; do
		if [ ! "inhalt.tex" = "$i" ]; then
			# dateiname ohne Endung
			texname=`basename "$i" .tex`
			echo "% $copyright"       > ../$artikel/$bsp/$texname-artikel.tex # file neu anlegen
			echo "$T1"               >> ../$artikel/$bsp/$texname-artikel.tex
			echo "%% anpassen
\title{$texname}"                    >> ../$artikel/$bsp/$texname-artikel.tex
			echo "$T2"               >> ../$artikel/$bsp/$texname-artikel.tex
			echo "
		%% anpassen
		%-------------------------------------------------
		%
			\input{$archiv/$i}
		%
		%-------------------------------------------------" >> ../$artikel/$bsp/$texname-artikel.tex
			echo "$T3"                                      >> ../$artikel/$bsp/$texname-artikel.tex
		fi
	done
fi
cd ..

# tabellen/
cd $tabellen
EXTENSION="tex" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
if [ $exist -ge 1 ]; then
	for i in *.tex; do
		# dateiname ohne Endung
		texname=`basename "$i" .tex`
		echo "% $copyright"       > ../$artikel/$bsp/$texname-artikel.tex # file neu anlegen
		echo "$T1"               >> ../$artikel/$bsp/$texname-artikel.tex
		echo "%% anpassen
\title{$texname}"                >> ../$artikel/$bsp/$texname-artikel.tex
		echo "$T2"               >> ../$artikel/$bsp/$texname-artikel.tex
		echo "
	%% anpassen
	%-------------------------------------------------
	%
		\input{$tabellen/$i}
	%
	%-------------------------------------------------" >> ../$artikel/$bsp/$texname-artikel.tex
		echo "$T3"                                      >> ../$artikel/$bsp/$texname-artikel.tex
	done
fi
cd ..

# beispiele/
cd $beispiele
EXTENSION="tex" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
if [ $exist -ge 1 ]; then
	for i in *.tex; do
		# dateiname ohne Endung
		texname=`basename "$i" .tex`
		echo "% $copyright"       > ../../../$artikel/$bsp/$texname-artikel.tex # file neu anlegen
		echo "$T1"               >> ../../../$artikel/$bsp/$texname-artikel.tex
		echo "%% anpassen
\title{$texname}"                >> ../../../$artikel/$bsp/$texname-artikel.tex
		echo "$T2"               >> ../../../$artikel/$bsp/$texname-artikel.tex
		echo "
	%% anpassen
	%-------------------------------------------------
	%
		\input{$beispiele/$i}
	%
	%-------------------------------------------------" >> ../../../$artikel/$bsp/$texname-artikel.tex
		echo "$T3"                                      >> ../../../$artikel/$bsp/$texname-artikel.tex
	done
fi
cd ../../..

#echo "...fertig."
