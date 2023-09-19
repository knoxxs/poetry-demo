#!/usr/bin/env bash

declare -a apps=("asdf-export-plugin" "asdf-import-plugin-install-versions")

show_menus() {
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo " SSH M A I N - M E N U"
    echo "~~~~~~~~~~~~~~~~~~~~~"
    for i in "${!apps[@]}"; do
       printf "%s. %s\n" "$(expr $i + 1)" "${apps[$i]}"
    done
}

# read input from the keyboard and take a action
read_options(){
    local choice
    read -p "Enter choice [ 1 - ${#apps[@]}] " choice
    if (($choice >= 1 && $choice <= ${#apps[@]}))
    then
       ${apps[$(expr $choice - 1)]}
       exit 0
    else
       echo "Invalid Choice!!"
       exit 1
    fi
}

asdf-export-plugin() {
   asdf plugin list --urls > .tool-plugins
}

asdf-import-plugin-install-versions() {
    while read -r x y; do asdf plugin add $x $y; done < .tool-plugins
    asdf install
}

show_menus
read_options
