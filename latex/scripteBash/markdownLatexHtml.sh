#!/bin/bash -e
# ju 10-Aug-20

# Markdown in Latex + HTML5 + Wordpress Konvertieren"

# variablen
md="md"
texPandoc="texPandoc"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
CSS="../md/github.css" # oder design.css
BIB_1="../md/literatur.bib"
BIB_2="../md/literatur-kfz.bib"
BIB_3="../md/literatur-sport.bib"
CSL="zitierstil-number.csl"
HTML_OPTIONS="-s --toc  -t html5 --from markdown+smart --bibliography $BIB_1 --bibliography $BIB_2 --bibliography $BIB_3 --citeproc --csl $CSL --mathjax --strip-comments -c $CSS"
WP_OPTIONS="-t html5 --from markdown+smart --bibliography $BIB_1 --bibliography $BIB_2 --bibliography $BIB_3 --citeproc --csl $CSL --mathjax --strip-comments" 

echo "+ Markdown in Latex + HTML5 + Wordpress"

cd $md
for i in *.md; do
	filename=`basename "$i" .md`
	# Latex
	pandoc "$i" --from markdown --listings -o ../$texPandoc/$filename.tex
	# Wordpress
	pandoc "$i" $WP_OPTIONS -o ../$cms_lokal/$filename.html
	pandoc "$i" $WP_OPTIONS -o ../$cms_server/$filename.html
	# HTML5
	pandoc "$i" $HTML_OPTIONS -o ../$html/$filename.html
done

cd ..

#echo "fertig"
