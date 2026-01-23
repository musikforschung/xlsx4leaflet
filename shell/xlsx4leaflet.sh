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

sed -i "5s/xlsx4leaflet/\l$Title/g" index.html
sed -i "s/src\=\"template\.js\"/src\=\"\l$Title\.js\"/g" index.html

catmandu convert XLSX to Text --fix ./fix/xlsx4leaflet.fix < ${Title}.xlsx > ${Title}.js &&

sed -i '1ivar addressPoints = [' ${Title}.js &&
sed -i '$a];' ${Title}.js &&

cd fix
catmandu convert xlsx < ../${Title}.xlsx > ../${Title}.csv &&

echo "Verarbeitung erfolgreich."
