#!/bin/bash -e
# ju 10-Aug-20

# Abbildungen in Latex speichern

#%Abbildung1 (\autoref{fig:Abbildung1}).
#%
#\begin{figure}[!hb]% hier: !hb
#	\centering
#	\includegraphics[width=.60\textwidth]{images/Chili-1.pdf}%
#	\caption{Abbildung1}%\label{fig:Abbildung1}%% anpassen
#\end{figure}

# Variablen
file="Pics-files.tex"
images="images"
grafik="Grafiken"
bildgroesse=".80"    # width=.80\textwidth
archiv="archiv"
info="Alle Abbildungen '$images/' in Latex speichern"
info2="    * '$archiv/$file'"
info3="    * Bildgröße: 0.80/1"
timestamp=$(date +"%d-%h-%Y")
copyright="ju $timestamp $file"

echo "+ $info"
echo "  $info2"
echo "  $info3"

T1="%
\begin{figure}[!hb]% hier: !hb
    \centering"
T2="\end{figure}
"

# File neu anlegen
printf "%% ---------------------------------------------\n"  >  $archiv/$file
printf "%% $info \n"                                         >> $archiv/$file
printf "%% $info2 \n"                                        >> $archiv/$file
printf "%% $info3 \n"                                        >> $archiv/$file
printf "%% $copyright\n"                                     >> $archiv/$file
printf "%% ---------------------------------------------\n"  >> $archiv/$file
printf "%%\n"                                                >> $archiv/$file

cd $images

EXTENSION="eps" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
    # vorhanden
    for i in *.$EXTENSION; do
        # Dateiname ohne Endung
        picname=`basename "$i" .$EXTENSION` # anpassen
        # latex quellcode
        echo "%\section{$picname}"                       >> ../$archiv/$file
        echo "%"                                         >> ../$archiv/$file
        echo "%$picname (\autoref{fig:$picname}).% Referenz"   >> ../$archiv/$file
        echo "$T1"                                       >> ../$archiv/$file
        echo "  \includegraphics[width=$bildgroesse\textwidth]{$images/$i}%" >> ../$archiv/$file
	    echo "  \caption{$picname}%\label{fig:$picname}%% anpassen"         >> ../$archiv/$file   
        echo "$T2"                                       >> ../$archiv/$file                                       >> ../$archiv/$file
        echo "%\newpage"                                 >> ../$archiv/$file
        ((n+=1))
    done
fi

EXTENSION="pdf" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
    # vorhanden
    for i in *.$EXTENSION; do
        # Dateiname ohne Endung
        picname=`basename "$i" .$EXTENSION` # anpassen
        # latex quellcode
        echo "%\section{$picname}"                       >> ../$archiv/$file
        echo "%"                                         >> ../$archiv/$file
        echo "%$picname (\autoref{fig:$picname}).% Referenz"   >> ../$archiv/$file
        echo "$T1"                                       >> ../$archiv/$file
        echo "  \includegraphics[width=$bildgroesse\textwidth]{$images/$i}%" >> ../$archiv/$file
	    echo "  \caption{$picname}%\label{fig:$picname}%% anpassen"         >> ../$archiv/$file   
        echo "$T2"                                       >> ../$archiv/$file                                       >> ../$archiv/$file
        echo "%\newpage"                                 >> ../$archiv/$file
        ((n+=1))
    done
fi

cd ..

cd $grafik

EXTENSION="eps" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
    # vorhanden
    for i in *.$EXTENSION; do
        # Dateiname ohne Endung
        picname=`basename "$i" .$EXTENSION` # anpassen
        # latex quellcode
        echo "%\section{$picname}"                       >> ../$archiv/$file
        echo "%"                                         >> ../$archiv/$file
        echo "%$picname (\autoref{fig:$picname}).% Referenz"   >> ../$archiv/$file
        echo "$T1"                                       >> ../$archiv/$file
        echo "  \includegraphics[width=$bildgroesse\textwidth]{$grafik/$i}%" >> ../$archiv/$file
	    echo "  \caption{$picname}%\label{fig:$picname}%% anpassen"         >> ../$archiv/$file   
        echo "$T2"                                       >> ../$archiv/$file                                       >> ../$archiv/$file
        echo "%\newpage"                                 >> ../$archiv/$file
        ((n+=1))
    done
fi

EXTENSION="pdf" 
# FEHLER unter mac!!!!
#exist=$(find -iname "*.$EXTENSION" | wc -l)
exist=1
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
    # vorhanden
    for i in *.$EXTENSION; do
        # Dateiname ohne Endung
        picname=`basename "$i" .$EXTENSION` # anpassen
        # latex quellcode
        echo "%\section{$picname}"                       >> ../$archiv/$file
        echo "%"                                         >> ../$archiv/$file
        echo "%$picname (\autoref{fig:$picname}).% Referenz"   >> ../$archiv/$file
        echo "$T1"                                       >> ../$archiv/$file
        echo "  \includegraphics[width=$bildgroesse\textwidth]{$grafik/$i}%" >> ../$archiv/$file
	    echo "  \caption{$picname}%\label{fig:$picname}%% anpassen"         >> ../$archiv/$file   
        echo "$T2"                                       >> ../$archiv/$file                                       >> ../$archiv/$file
        echo "%\newpage"                                 >> ../$archiv/$file
        ((n+=1))
    done
fi

cd ..

echo "fertig"
