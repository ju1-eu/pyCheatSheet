#!/bin/bash -e
# ju 10-Aug-20

# Erstellt Websiten & \LaTeX-Files mit Markdown und Pandoc.
# sed passt die \LaTeX-Syntax und HTML-Syntax an.
# Fotos optimieren (Web, Latex)
# Versionsverwaltung (Git)
# Backup
#
# Projekt wurde getestet unter "iMac"

# Erste Schritte
# 
# anpassen
# scripte/sed.sh
#  - codelanguage:    HTML5, Python, Bash, C, C++, TeX
#  - CMS Server Pfad: https://bw-ju.de/#
#  - Bildformat:      pdf, svg, png, jpg, webp

# projekt.sh
#  - Backupverzeichnis

# content/metadata.tex
#  - Datum, Titel, Autor

# $ ./projekt.sh
# $ make


# ANPASSEN
#------------------------------------------------------
	# anpassen
	THEMA="Notizen-TeX-Web-iMac"

	backup_USB="/Volumes/usb-daten/meineNotizen/backup/notizen-iMac"    

	archiv_USB="/Volumes/usb-daten/meineNotizen/archiv/notizen-iMac"    

	#repos_USB="/Volumes/usb-daten/meineNotizen/repository/notizen-iMac"    
#------------------------------------------------------

# Variable
info="+ Erstellt Websiten & \LaTeX PDFs mit Markdown und Pandoc."
scripte="scripteBash"
code="code"
img="images"
img_in="img-in"
img_out="img-out"
md="md"
tex="tex"
tex_pandoc="texPandoc"
css="css"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
archiv="archiv"
content="content"
git_file="git-log.txt"
timestamp_1=$(date +"%Y-%m-%d") # 2020-08-11
timestamp_2=$(date +"%d-%h-%y") # 11-Aug-20
timestamp_3=$(date +"%d%m%y")   # 110820
timestamp_4=$(date +"%d.%h.%Y") # 11.Aug.2020
copyright="ju $timestamp_2"

# ---------------------------
janein=1
while [ "$janein" -eq 1 ]; do
	###clear
	printf "\n $info \n"
	printf "\n  0) Projekt aufräumen"
	printf "\n  1) Projekt erstellen"
	printf "\n  2) Markdown in (tex, html5) + sed (Suchen/Ersetzen)"
	printf "\n  3) Kapitel erstellen + Scripte ausführen"
	printf "\n  4) Fotos optimieren (Web, Latex)"
	printf "\n  5) www + index.html"
	printf "\n  6) git init"
	printf "\n  7) git status + git log"
	printf "\n  8) Git-Version erstellen"
	printf "\n  9) Backup + Archiv erstellen"
	printf "\n 10) Beenden?"
	a=
	while [ -z "$a" ]; do
		printf "\n\n Eingabe Zahl >_ "
		read a
		# Zeichenketten eliminieren ,die Zeichen ausser 0-9  enthalten
		a=${a##*[^0-9]*}
		if [ -z "$a" ]; then
			echo "+ Ungueltige Eingabe"
		fi
	done

	echo "--------------------------"
	printf "\n"

    # --------------------
	if [ $a -eq 0 ]; then
		# Projekt aufräumen

		# löschen  
		if [ -d $tex-pandoc ]; then rm -rf $tex_pandoc; fi
		if [ -d $html ]; then rm -rf $html; fi
		if [ -d $cms_lokal ]; then rm -rf $cms_lokal; fi
		if [ -d $cms_server ]; then rm -rf $cms_server; fi
		if [ -d $img_out ]; then rm -rf $img_out; fi
		if [ -f index.html ]; then rm -rf index.html; fi
		if [ -f inhalt.txt ]; then rm -rf inhalt.txt; fi

		make clean
		#make distclean

		echo "fertig"

	# --------------------
	elif [ $a -eq 1 ]; then
		# Projekt erstellen
		# Scriptaufruf
		./$scripte/projekterstellen.sh

	# --------------------
	elif [ $a -eq 2 ]; then
		# Markdown in (tex, html5) - sed (Suchen/Ersetzen)
		# Scriptaufruf
		./$scripte/markdownLatexHtml.sh
		# FEHLER unter mac!!!!
	    ./$scripte/sed.sh

    # --------------------
	elif [ $a -eq 3 ]; then
		# Kapitel erstellen, Scripte ausführen
		# Scriptaufruf
		./$scripte/inputImgMarkdown.sh
		./$scripte/inputKapitelLatex.sh
		./$scripte/inputPdfsLatex.sh
		./$scripte/projektInhalt.sh
		./$scripte/codeFiles.sh
		./$scripte/artikel-anlegen.sh
		./$scripte/picFiles.sh

	# --------------------
    elif [ $a -eq 4 ]; then
		# Fotos optimieren (Web, Latex)
		# Scriptaufruf
		./$scripte/jpg-pdf.sh

	# --------------------
	elif [ $a -eq 5 ]; then
		# www & index.html
		# Scriptaufruf
		./$scripte/www.sh

    # --------------------
    elif [ $a -eq 6 ]; then
		# git init
		rm -rf .git
		git init
		git add .
		git commit -m"Projekt init"
		git status
		echo "# ----------------------------------------------"
		git log --abbrev-commit --pretty=oneline --graph --decorate
		git log --abbrev-commit --pretty=oneline --graph --decorate > $git_file  # neu anlegen
		echo "# ----------------------------------------------"

	# --------------------
	elif [ $a -eq 7 ]; then
		# git status und git log 
		git status
		echo "# ----------------------------------------------"
		git log --abbrev-commit --pretty=oneline --graph --decorate
		echo "# ----------------------------------------------"

    # --------------------
    elif [ $a -eq 8 ]; then
		# Git-Version erstellen
		# Scriptaufruf
		./$scripte/gitversionieren.sh
	
	# --------------------
    elif [ $a -eq 9 ]; then
		echo "+ Backup + Archiv erstellen"

		# Laufwerk vorhanden?
		if [ ! -d $backup_USB ]; then
		    echo "$backup_USB Laufwerk mounten."
		else
		    # backup 
		    rsync -av --delete ./ $backup_USB/$THEMA/
		fi
		
		# archiv
		ID=$(git rev-parse --short HEAD) # git commit (hashwert) = id
		
		tar cvzf $archiv_USB/$timestamp_3'_'$THEMA'_v_'$ID.tgz .

		#tar cvzf ../$timestamp_3'_'$THEMA'_v'$ID.tgz .
		#tar cvzf ../$THEMA.tgz .
	    #rm -rf ../$THEMA.zip
	    #zip -r ../$THEMA.zip .
		
		# zip
		if [ ! -f ../$THEMA.zip ]; then
			zip -r ../$THEMA.zip .
		else
		    # backup löschen
		    rm -rf ../$THEMA.zip
			zip -r ../$THEMA.zip .
		fi
		# version erstellen
		tar cvzf ../$timestamp_3'_'$THEMA'_v'$ID.tgz .
		
		rm -rf $archiv_USB/$THEMA.zip
	    zip -r $archiv_USB/$THEMA.zip .
		
		if [ ! -f $archiv/$tex.zip ]; then
			zip -r $archiv/$tex.zip tex/
		else
		    # backup löschen
		    rm -rf $archiv/$tex.zip
			zip -r $archiv/$tex.zip tex/
		fi
		if [ ! -f $archiv/$md.zip ]; then
			zip -r $archiv/$md.zip md/
		else
		    # backup löschen
		    rm -rf $archiv/$md.zip
			zip -r $archiv/$md.zip md/
		fi

		echo "# ----------------------------------------------"
	    echo "+ Archiv ($archiv_USB/)"
		echo "+ Backup ($backup_USB/)"
		echo "+ Archiv ($archiv/$tex/)"
		echo "+ Archiv ($archiv/$md/)"		
		echo "# ----------------------------------------------"

		echo "fertig"
	
	# --------------------
	else
		echo "Beenden"; break
	fi
done
