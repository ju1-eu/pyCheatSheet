#!/bin/bash -e
# ju 22-Jul-21

# Websiten erstellen

# Variable anpassen
THEMA="Notizen-Python"
css="md/github.css" # oder design.css
html="html"
file="index.html"
img="images"
PDF="Tabellen/PDF"

info="Websiten erstellen."
timestamp=$(date +"%d-%h-%y") # 11-Aug-20
copyright="ju $timestamp"

echo "+ $info"

T1="<!DOCTYPE html>
<html><head>
	<meta charset=\"utf-8\"/>
	<title>$THEMA</title><!--anpassen-->
	<meta name=\"description\" content=\"Beschreibung\" />
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=yes\" />
	<style type=\"text/css\">
		code{white-space: pre-wrap;}
		span.smallcaps{font-variant: small-caps;}
		span.underline{text-decoration: underline;}
		div.column{display: inline-block; vertical-align: top; width: 50%;}
	</style>"

# index.html
T2="	<link rel=\"stylesheet\" href=\"./$css\" />"
# html/website.html
T3="	<link rel=\"stylesheet\" href=\"../$css\" />"
T4="</head><body><!-- Inhalt -->"
T5="</body></html>"

# File neu anlegen
# index.html
echo "<!--$copyright-->"  > $file
echo "$T1"               >> $file
echo "$T2"               >> $file
echo "$T4"               >> $file
echo "	<h1>$THEMA</h1>
	<!-- Navi -->
	<ul class=\"nav\">"  >> $file

#----------------------
# alle pics
pics="alle-pics.html"
echo "<!--$copyright-->"  > ./$html/$pics
echo "$T1"               >> ./$html/$pics
echo "$T3"               >> ./$html/$pics
echo "$T4"               >> ./$html/$pics
echo "	<p><a href=\"../$file\">Start</a></p>
	<h1>$THEMA</h1>
	<h2>alle Pics</h2>"  >> ./$html/$pics

cd $img
EXT="webp"
exist=$(find . -type f -iname "*.$EXT" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.$EXT; do
		# Dateiname ohne Endung
		filename=`basename "$i" .$EXT` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1)) # Pic Zaehler
	done
fi

EXT="jpg" 
exist=$(find . -type f -iname "*.$EXT" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.$EXT; do
		# Dateiname ohne Endung
		filename=`basename "$i" .$EXT` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi

EXT="svg" 
exist=$(find . -type f -iname "*.$EXT" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.$EXT; do
		# Dateiname ohne Endung
		filename=`basename "$i" .$EXT` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi

EXT="png" 
exist=$(find . -type f -iname "*.$EXT" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.$EXT; do
		# Dateiname ohne Endung
		filename=`basename "$i" .$EXT` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi
cd ..

echo "+ $html/alle-pics.html wurde erstellt"
echo "$T5"     >> ./$html/$pics


#----------------------
# File neu anlegen
# alle x-PDFs
X_PDFs="alle-PDFs.html"
echo "<!--$copyright-->"  >  ./$html/$X_PDFs
echo "$T1"                >> ./$html/$X_PDFs
echo "$T3"                >> ./$html/$X_PDFs
echo "$T4"                >> ./$html/$X_PDFs
echo "	<p><a href=\"../$file\">Start</a></p>
	<h1>$THEMA</h1>
	<h2>$X_PDFs</h2>"    >> ./$html/$X_PDFs

cd $PDF

EXT="pdf"
exist=$(find . -type f -iname "*.$EXT" | wc -l)
if [ $exist -ge 1 ]; then
	for i in *.$EXT; do
		echo "		<li><a href=\"../$PDF/$i\">$i</a></li>"  >> ../../$html/$X_PDFs
	done
fi

cd ../..

echo "	</ul>" >> ./$html/$X_PDFs
echo "$T5"     >> ./$html/$X_PDFs
echo "+ $html/alle-PDFs.html wurde erstellt"



# -------------------------
# index.html
cd $html
for i in *.html; do
	# navi - index.html
	echo "		<li><a href=\"./$html/$i\">$i</a></li>"  >> ../$file
done
cd ..

echo "	</ul>" >> $file
echo "$T5"     >> $file
echo "+ index.html wurde erstellt"
echo "...fertig."