#!/bin/bash -e
# ju 10-Aug-20

# sudo apt install -y webp
# ACHTUNG:   * EPS > PDF (Unterschied Ubuntu / Win10)
# 			 * Umlaute, Leerzeichen, _, *.JPG, *.jpeg eliminieren 

# http://www.eci.org/de/downloads
# Farbraum: ISOcoated_v2_eci.icc
# Das ECI-Offsetprofil ISOcoated_v2_eci.icc
# basiert auf der Charakterisierungsdatei
# "FOGRA39L.txt" und gilt für die folgenden
# Druckbedingungen gemäß internationalem
# Standard ISO 12647-2:2004

# identify -verbose ./bild.jpg
# Colorspace: sRGB
# Handy: 4032x3024

# FEHLER unter mac!!!!


# ANPASSEN
quelle="img-in"
ziel="img-out"
tmp="WEB"
tmp_2="TEX"
timestamp=$(date +"%d-%h-%Y") # 11-Aug-2020
file="pics-liste.txt"
AUFLOESUNG_TEX="1200"  # 1200x
AUFLOESUNG_WEB="1600"  # 1600x1200
QUALITAET="75"         # 75% 

clear

printf "\n+ Fotos bearbeiten - $timestamp\n"

echo "+ Directory anlegen"
# Ordner prüfen
if [ ! -d $ziel ];   then mkdir -p $ziel; fi
if [ ! `ls -a $quelle | wc -l` -gt 2  ]; then echo "Fehler: $quelle leer"; exit; fi

# Ordnername in file speichern 
find $quelle/* -type d -exec basename {} \; | sort > $ziel/$file

# $file zeilenweise lesen
cd $ziel
while read ORDNER ; do 
	printf "\n--------------------------------------\n";
	printf "	Bilderordner: $ORDNER";
	printf "\n--------------------------------------\n";

	# ordner anlegen
	if [ ! -d "$ORDNER"/$tmp ]; then 
    	mkdir -p "$ORDNER"/$tmp; 
		mkdir -p "$ORDNER"/$tmp_2; 
	else
		rm -rf "$ORDNER"/$tmp;
		rm -rf "$ORDNER"/$tmp_2;
		mkdir -p "$ORDNER"/$tmp; 
		mkdir -p "$ORDNER"/$tmp_2; 
	fi
	cp -p ../$quelle/"$ORDNER"/* "$ORDNER"/$tmp

	# Bildbearbeitung
	cd $ORDNER/$tmp

	# files umbenennen
	EXT="jpg" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
  		ls *.$EXT | cat -n | while read zaehler file; do 
								mv "$file" "$ORDNER-$zaehler.$EXT"; 
							done
	fi
	EXT="png" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		ls *.$EXT | cat -n | while read zaehler file; do 
								mv "$file" "$ORDNER-$zaehler.$EXT"; 
							done
	fi

	#------------------------------------------------------------------------------
	# Umlaute, Leerzeichen, _, *.JPG, *.jpeg eliminieren
	### 's/suchen/ersetzen/g'
	#find ./ -name "*.JPG"  -exec rename 's/.JPG/.jpg/g'  {} +
	#find ./ -name "*.jpeg" -exec rename 's/.jpeg/.jpg/g' {} +
	#find ./ -name "*"      -exec rename 's/ü/ue/g' {} +
	#find ./ -name "*"  	-exec rename 's/ä/ae/g' {} +
	#find ./ -name "*"  	-exec rename 's/ö/oe/g' {} +
	#find ./ -name "*"      -exec rename 's/Ü/ue/g' {} +
	#find ./ -name "*"      -exec rename 's/Ä/ae/g' {} +
	#find ./ -name "*"      -exec rename 's/Ö/oe/g' {} +
	#find ./ -name "*"      -exec rename 's/ß/ss/g' {} +
	#find ./ -name "*"      -exec rename 's/_/-/g'  {} +
	#find ./ -name "*"      -exec rename 's/ //g'   {} +
	#------------------------------------------------------------------------------

	# Latex - pdf
	echo ""
	echo "+ TeX - optimierte Fotos"
	echo "+-----------------------"
	#cd $ORDNER/$tmp
	cd ..

	cp -p $tmp/* $tmp_2/

	cd $tmp_2

	# 300dpi
	#echo "+ Druck 300 dpi + cmyk Farbprofil ISOcoated_v2_eci.icc"
	#mogrify -resample 300x300 ./*	
	#mogrify -colorspace cmyk -profile ../../../scripteBash/ISOcoated_v2_eci.icc ./*	
	
	# Auflösung
	echo "+ Auflösung $AUFLOESUNG_TEX"
	mogrify -resize "$AUFLOESUNG_TEX" ./*

	# jpg > eps
	EXT="jpg" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		echo "+ jpg > eps"
		for filename in *.$EXT; do
			epsname=${filename%.$EXT}.eps
			echo "processing $filename $epsname"
			# 
			convert $filename -compress none -auto-orient -strip eps3:$epsname
		done
	fi
#	# png > eps
	EXT="png" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		echo "+ png > eps"
		for filename in *.$EXT; do
			epsname=${filename%.$EXT}.eps
			echo "processing $filename $epsname"
			# 
			convert $filename -compress none -auto-orient -strip eps3:$epsname
		done
	fi

	echo "+ eps > pdf"
	for filename in *.eps; do
		pdfname=../${filename%.eps}.pdf
		echo "processing $filename $pdfname"
		# win10
		#gswin64.exe -dEPSCrop -dBATCH -dNOPAUSE -sOutputFile=$pdfname -sDEVICE=pdfwrite -f $filename
		# ubuntu & mac
		gs -dEPSCrop -dBATCH -dNOPAUSE -sOutputFile=$pdfname -sDEVICE=pdfwrite -f $filename		
	done

	# aufraeumen
	echo "+ Aufräumen (TEX)"

	cd ..
	rm -rf *.eps 
	#------------------------------------------------------------------------------

	# web 
	echo ""
	echo "+ Web - optimierte Fotos"
	echo "+-----------------------"
	#cd $ORDNER/$tmp
	cd $tmp

	# Progressiv -auto-orient - Meta entfernen
	echo "+ Progressiv -auto-orient - Meta entfernen"
	EXT="jpg" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		for filename in *.$EXT; do 
			filename_neu=../$filename
			echo "processing $filename"
			convert $filename -auto-orient -strip -interlace Plane $filename_neu
		done 
	fi

	# Auflösung
	echo "+ Auflösung $AUFLOESUNG_WEB"
	mogrify -resize "$AUFLOESUNG_WEB" ./*

	# Qualität
	echo "+ Qualität $QUALITAET%"
	EXT="jpg" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		for filename in *.$EXT; do 
			filename_neu=./$filename 
			echo "processing $filename $filename_neu"
			convert $filename -quality $QUALITAET $filename_neu
		done 
	fi

	# jpg > webp
	EXT="jpg" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		echo "+ jpg > webp"
		for filename in *.$EXT; do 
			webpname=${filename%.$EXT}.webp
			echo "processing $filename $webpname"
			convert $filename -auto-orient $webpname
		done 
	fi
#	# png > webp
	EXT="png" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		echo "+ png > webp"
		for filename in *.$EXT; do 
			webpname=${filename%.$EXT}.webp
			echo "processing $filename $webpname"
			convert $filename -auto-orient $webpname
		done 
	fi

	# aufraeumen
	echo "+ Aufräumen (WEB)"
	EXT="webp" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		mv *.$EXT ../
	fi

	EXT="jpg" 
	exist=$(find . -type f -iname "*.$EXT" | wc -l)
	if [ $exist -ge 1 ]; then
		mv *.$EXT ../
	fi

	cd ..
	#------------------------------------------------------------------------------

	rm -rf $tmp/ $tmp_2/

	cd ..

done < $file

