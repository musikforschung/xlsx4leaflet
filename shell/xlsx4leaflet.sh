#!/usr/bin/env bash

green="`tput setaf 2`"
red="`tput setaf 1`"
sgr0="`tput sgr0`"
cyan="`tput setaf 6`"

#Abfrage des Projekttitels und automatische Vergabe als Dateinamen etc.
read -p "${cyan}			Bitte einen Projekttiel ohne Leer- und Sonderzeichen eingeben: ${sgr0}" Title
while [[ ! "$Title" =~ ^[a-zA-Z0-9._-]+$ ]] ; do
  echo "${red}Ungültige Eingabe${sgr0}"
  read -p "${cyan}			Bitte einen anderen Titel ohne Leer- und Sonderzeichen eingeben: ${sgr0}" Title
done
echo "
Verarbeitung begonnen"

if [ -f template.js ]; then
   rm template.js
fi &&

if [ -f template.csv ]; then
   rm template.csv
fi &&

if [ -f template.xlsx ]; then
   mv template.xlsx ${Title}.xlsx
fi &&

sed -i "5s/xlsx4leaflet/\l$Title/g" index.html &&
sed -i "s/src\=\"template\.js\"/src\=\"\l$Title\.js\"/g" index.html &&
sed -i "s/\.\/template\.xlsx/\.\/\l$Title\.xlsx/g" ./fix/catmandu.yml &&

cd ./fix

catmandu convert xlsx to js > ../${Title}.js &&
catmandu convert xlsx to csv > ../${Title}.csv &&

cd ..

sed -i '1ivar addressPoints = [' ${Title}.js &&
sed -i '$a];' ${Title}.js &&




echo "Verarbeitung erfolgreich."
