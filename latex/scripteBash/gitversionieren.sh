#!/bin/bash -e
# ju 10-Aug-20

# Git versionieren

# Variablen
#------------------------------------------------------
	THEMA="Notizen-TeX-Web-iMac" # = REPOSITORY
	repos_USB="/Volumes/usb-daten/meineNotizen/repository/notizen-iMac"    
#------------------------------------------------------

info="Git versionieren"
git_file="git-log.txt"
timestamp=$(date +"%d-%h-%Y")  # 11-Aug-2020
copyright="ju $timestamp $git_file"

echo "+ $info"

#----------------------------------------------------------
# Voraussetzung:
# (1) lokales Repository: master
	# anpassen 
	# git config --global init.defaultBranch master
#git init # rm -rf .git
#git add .
#git commit -m"Projekt init"

# (2) Github Repository:  origin/master
	# anpassen    
#git remote add origin https://github.com/ju1-eu/Notizen-TeX-Web-iMac.git
#git push -u origin master

# (3) backup Repository:  backupUSB/master
    # anpassen
#repos_USB="/Volumes/usb-daten/meineNotizen/repository/notizen-iMac"    
#REPOSITORY="Notizen-TeX-Web-iMac"
#LESEZEICHEN="backupUSB"
#git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY.git 
#git remote add $LESEZEICHEN $repos_USB/$REPOSITORY.git 
#git push --all $LESEZEICHEN
#----------------------------------------------------------

# Git-Version
# lokales Repository: HEAD -> master
#
# usereingabe
read -p "lokales Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# lokales Repository: HEAD -> master
	git add .
	git commit -a # editor
	echo "# ------------------------"
	echo $copyright > $git_file
	git log --abbrev-commit --pretty=oneline --graph --decorate >> $git_file  # version anlegen
	echo "# ------------------------"
else
	# beenden
	echo "Ende: $antwort"
fi

# Github Repository: origin/master
#
# usereingabe
read -p "Github Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# Github Repository: origin/master
	git push
	echo "# ------------------------"
else
	# beenden
	echo "Ende: $antwort"
fi

# Backup Repository: backupUSB/master
#
# usereingabe
read -p "Backup Repository $repos_USB vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# Fehler: String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# Speicher - Laufwerk vorhanden?
	if [ ! -d $repos_USB ]; then
		echo "$repos_USB mounten."
	else
		# Backup Repository
		LESEZEICHEN="backupUSB"
		git push --all $LESEZEICHEN 
		echo "# ------------------------"
	fi
else
	# beenden
	echo "Ende: $antwort"
fi

echo "# ------------------------"
git status
git log --abbrev-commit --pretty=oneline --graph --decorate
echo "# ------------------------"

echo "fertig"
