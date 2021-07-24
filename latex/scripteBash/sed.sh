#!/bin/bash -e
# ju 10-Aug-20

# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
# loeschen:            sed -i -e '/suchen/d' "$i"
	# Ersetze "foo" mit "bar" NUR in Zeilen die "baz" enthalten
 	#sed '/baz/s/foo/bar/g'
 	# Ersetze "foo" mit "bar" AUSSER in Zeilen die "baz" enthalten
 	#sed '/baz/!s/foo/bar/g'


# ANPASSEN
codelanguage="Python"      # HTML5, Python, Bash, C, C++, TeX

# CMS
# Server Pfad anpassen Zeile 80
# https://bw-ju.de/wp-content/uploads/2020/11
timestamp_2=$(date +"%Y\/%m") # 2020\/11
PFAD_SERVER="https:\/\/bw-ju.de\/wp-content\/uploads\/$timestamp_2"
#..\/images

# Bildformat:  pdf, svg, png, jpg, webp
bildformat="svg"     # eps -> svg
bildformat_2="webp"  # pdf -> webp
bildformat_3="jpg"   # wenn kein svg oder webp
bildformat_4="png"   # 

# Variablen
texPandoc="texPandoc"
cms_lokal="cms-lokal"
cms_server="cms-server"
html="html"
timestamp=$(date +"%d-%h-%y") # 11-Aug-20


echo "+ sed - Wordpress"

cd $cms_lokal
for i in *.html; do
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	#sed -i -e '/---/ s//-/g' "$i"
	#sed -i -e 's/<embed/<img/g' "$i"
	#sed -i -e '/"images/ s//"..\/images/g' "$i"
	sed -i -e '/.eps/ s//.'$bildformat'/g' "$i"
	sed -i -e '/.pdf/ s//.'$bildformat_3'/g' "$i"
	sed -i -e '/\/><figcaption>/ s//alt="Bildname"> \n	<figcaption>Abb. : /g' "$i"
	sed -i -e 's/<embed/	<!--Link auf Bild anpassen-->/g' "$i"
	sed -i -e 's/src="images/\n	<img class=scaled src="..\/images/g' "$i"
	#sed -i -e '/ / s// /g' "$i"
	sed -i -e '/”/ s//\&laquo;/g' "$i"
	sed -i -e '/“/ s//\&raquo;/g' "$i"
done

cd ../$cms_server
for i in *.html; do
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	#sed -i -e '/---/ s//-/g' "$i"
	#sed -i -e 's/<embed/<img/g' "$i"
	#sed -i -e '/"images/ s//"..\/images/g' "$i"
	sed -i -e '/.eps/ s//.'$bildformat'/g' "$i"
	sed -i -e '/.pdf/ s//.'$bildformat_3'/g' "$i"
	sed -i -e '/\/><figcaption>/ s//alt="Bildname"> \n	<figcaption>Abb. : /g' "$i"
	sed -i -e 's/<embed/	<!--Link auf Bild anpassen-->/g' "$i"
	sed -i -e 's/src="images/\n	<img class=scaled src="'$PFAD_SERVER'/g' "$i"
	#sed -i -e '/ / s// /g' "$i"
	sed -i -e '/”/ s//\&laquo;/g' "$i"
	sed -i -e '/“/ s//\&raquo;/g' "$i"
done

cd ../$html
for i in *.html; do
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	#sed -i -e '/ / s// /g' "$i"
	sed -i -e '/"images/ s//"..\/images/g' "$i"
	sed -i -e 's/<embed/<img/g' "$i"
	sed -i -e '/.eps/ s//.'$bildformat'/g' "$i"
	sed -i -e '/.pdf/ s//.'$bildformat_4'/g' "$i"
	sed -i -e '/”/ s//\&laquo;/g' "$i"
	sed -i -e '/“/ s//\&raquo;/g' "$i"
done

echo "+ sed - Latex"

cd ../$texPandoc
for i in *.tex; do
    # section
	# Ersetze "foo" mit "bar" NUR in Zeilen die "baz" enthalten
 	#sed '/baz/s/foo/bar/g'
 	# Ersetze "foo" mit "bar" AUSSER in Zeilen die "baz" enthalten
 	#sed '/baz/!s/foo/bar/g'
	sed -i -e '/hypertarget/d' "$i"
	sed -i -e '/\\label/ s/}}/}/g' "$i"
	#sed -i -e '/url/ !s/}}/}/g' "$i"
	#sed -i -e '/\section{*}}/ s//}/g' "$i"
    sed -i -e '/vgl. kap./ s//%vgl.~(\\autoref{})./g' "$i"

	# Abbildung
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
    sed -i -e '/vgl. abb./ s//%vgl.~(\\autoref{fig:})./g' "$i"
	sed -i -e '/\\begin{figure}/ s//\\begin{figure}[!ht]% hier: !ht/g' "$i"
	sed -i -e '/\\end{figure}/ s//%\\label{fig:}%% anpassen\n\\end{figure}/g' "$i"
	sed -i -e '/,height=\\textheight/ s///g' "$i"

    # ~ geschütztes Leerzeichen (engl. no-break space)
    sed -i -e '/\\textasciitilde / s//~/g' "$i"
    sed -i -e '/\\textasciitilde{}/ s//~/g' "$i"
    sed -i -e '/\\textasciitilde/ s//~/g' "$i"

    # \%
    sed -i -e '/\\textbackslash/ s//\\/g' "$i"

 
	# Tabellen
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '/vgl. tab./ s//%vgl.~(\\autoref{tab:})./g' "$i"
	sed -i -e '/\\begin{longtable}[[]]/ s//\\begin{table}[!ht]% hier: !ht \n\\centering \n	\\caption{}% \\label{tab:}%% anpassen \n\\begin{tabular}/g' "$i"
	sed -i -e '/tabularnewline/ s//\\/g' "$i"
	sed -i -e '/\\end{longtable}/ s//\\end{tabular} \n\\end{table}/g' "$i"
    sed -i -e '/@{}/ s//@{}}/g' "$i"
    sed -i -e '/\\begin{tabular}{@{}}/ s//\\begin{tabular}{@{}/g' "$i"
    sed -i -e '/\\%/ s//%/g' "$i"
    sed -i -e '/\\endhead/d' "$i"
	sed -i -e '/\\begin{tabular/ s/}}/}/g' "$i"
	sed -i -e 's/toprule/hline/g' "$i"
	sed -i -e 's/midrule/hline/g' "$i"
	sed -i -e 's/bottomrule/hline/g' "$i"





	# Quellcode
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '/vgl. code./ s//%vgl.~(\\autoref{code:})./g' "$i"
	sed -i -e '/\\begin{lstlisting}/ s//\\lstset{language='$codelanguage'}% C, TeX, Bash, Python \n\\begin{lstlisting}[\n	%caption={}, label={code:}%% anpassen\n]/g' "$i"

	#\passthrough{\lstinline!code!}
	sed -i -e '/\\passthrough{\\lstinline!/ s//\\verb|/g' "$i"
	sed -i -e '/!}/ s//|/g' "$i"

	# Literaturangaben
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	#sed -i -e '/vgl. lit./ s//%Quelle:~\\textcite{}/g' "$i"
	sed -i -e '/{\[}@/ s//\\textcite{/g' "$i"
	sed -i -e '/{\]}/ s//}/g' "$i"	

	# listen
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '/\\tightlist/d' "$i"
	sed -i -e '/\\def\\labelenumi{\\arabic{enumi}.}/d' "$i"


	# Fileanfang
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '1s/^/%ju '$timestamp' '$i'\n/g' "$i"
	sed -i -e '2s/section/chapter/g' "$i"

	# Umlaute im Label
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '/uxfc/ s//ue/g' "$i"
	sed -i -e '/uxf6/ s//oe/g' "$i"
	sed -i -e '/uxe4/ s//ae/g' "$i"
	sed -i -e '/uxdf/ s//ss/g' "$i"
	sed -i -e '/---/ s//-/g'   "$i"

	# Mathe
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '/\\(/ s//$/g' "$i"
	sed -i -e '/\\)/ s//$/g' "$i"
	# \textbackslash{} - \
	sed -i -e '/\\textbackslash{}/ s//\\/g' "$i"
	# \textgreater{} - >
	sed -i -e '/\\textgreater{}/ s//>/g' "$i"
	sed -i -e 's/~%/~\\%/g' "$i"
	

	# Anführungszeichen
	# suchen und ersetzen: sed -i -e '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i -e '/suchen/d' "$i"
	sed -i -e '/``/ s//>>/g' "$i"
	sed -i -e "/''/ s//<</g" "$i"
    #\flqq Text\frqq
    #\textgreater\textgreater Vorratsdrücke\textless\textless{}
    sed -i -e '/\\textgreater\\textgreater/ s//\\flqq/g' "$i"
	sed -i -e '/\\textless\\textless{}/ s//\\frqq/g' "$i"

done

cd ..

echo "...fertig"
