#!/usr/bin/env bash

# color definitions
green="$(tput setaf 2)"
red="$(tput setaf 1)"
sgr0="$(tput sgr0)"
cyan="$(tput setaf 6)"


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

   
    if [ -f template.xlsx ] && [ -f template_index.html ]; then
       cp template.xlsx "${Title}.xlsx"
       cp template_index.html index.html
    else
       echo "${red}Error: Template files (template.xlsx or template_index.html) not found!${sgr0}"
       continue # Skip to next loop iteration
    fi

    # remove old temporary files if they exist
    [ -f example.js ] && rm -f example.js
    [ -f example.csv ] && rm -f example.csv

    # replace placeholders in the copied index.html
    sed -i "5s/xlsx4leaflet/\l$Title/g" index.html
    sed -i "s/src\=\"template\.js\"/src\=\"\l$Title\.js\"/g" index.html
    
    cd ./fix || { echo "${red}CRITICAL ERROR: Directory './fix' not found. Terminating.${sgr0}"; exit 1; }

    catmandu convert xlsx to js < "../${Title}.xlsx" > "../${Title}.js"
    catmandu convert xlsx to csv < "../${Title}.xlsx" > "../${Title}.csv"
    
    cd .. 

    # format js file
    if [ -f "${Title}.js" ]; then
        sed -i "1ivar addressPoints = [" "${Title}.js"
        sed -i '$a];' "${Title}.js"
    fi

    echo "${green}Processing for '$Title' successfully completed.${sgr0}"
    echo "---------------------------------------------------"
done
