#!/usr/bin/env bash


green="$(tput setaf 2)"
red="$(tput setaf 1)"
sgr0="$(tput sgr0)"
cyan="$(tput setaf 6)"

set -euo pipefail

BASE_DIR="$HOME/xlsx4leaflet"
TEMP_DIR="$BASE_DIR/template"

while true; do
    echo ""
    read -p "${cyan}Please enter a project title (or 'q' to quit): ${sgr0}" Title

    # exit option
    if [[ "$Title" == "q" ]]; then
        echo "Script terminated."
        break
    fi

    while [[ ! "$Title" =~ ^[a-zA-Z0-9._-]+$ ]] ; do
      echo "${red}Invalid input (no spaces or special characters allowed)${sgr0}"
      read -p "${cyan}Please enter another title: ${sgr0}" Title
    done

    echo "Processing started for '$Title'..."

   
    if [ -f $TEMP_DIR/template.xlsx ] && [ -f $TEMP_DIR/template_index.html ]; then
       cp $TEMP_DIR/template.xlsx "$BASE_DIR/${Title}.xlsx"
       cp $TEMP_DIR/template_index.html $BASE_DIR/index.html
    else
       echo "${red}Error: Template files (template.xlsx or template_index.html) not found!${sgr0}"
       continue # Skip to next loop iteration
    fi

    # replace placeholders in the copied index.html
    sed -i "5s/xlsx4leaflet/\l$Title/g" $BASE_DIR/index.html
    sed -i "s/src\=\"template\.js\"/src\=\"\l$Title\.js\"/g" $BASE_DIR/index.html
    
    cd ./fix || { echo "${red}CRITICAL ERROR: Directory './fix' not found. Terminating.${sgr0}"; exit 1; }

    catmandu convert xlsx to js < "$BASE_DIR/${Title}.xlsx" > "$BASE_DIR/${Title}.js"
    catmandu convert xlsx to csv < "$BASE_DIR/${Title}.xlsx" > "$BASE_DIR/${Title}.csv"
    catmandu convert xlsx to tsv < "$BASE_DIR/${Title}.xlsx" > "$BASE_DIR/${Title}.tsv"
	
    cd .. 

    # format js file
    if [ -f "$BASE_DIR/${Title}.js" ]; then
        sed -i "1ivar addressPoints = [" "$BASE_DIR/${Title}.js"
        sed -i '$a];' "$BASE_DIR/${Title}.js"
    fi

    echo "${green}Processing for '$Title' successfully completed.${sgr0}"
    echo "---------------------------------------------------"
done
