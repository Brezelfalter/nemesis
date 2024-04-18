#! /usr/bin/bash


pad () {
    text=$1
    length=$2
    text_length=${#text}
    
    if [ $((text_length % 2)) -eq 0 ];
    then 
        text="- $text -"
    else 
        text="- $text --"
    fi

    remaining=$((length-text_length))
    temp=""
    
    for n in $(seq 1 $((remaining/2)))
    do 
        temp+="-"
    done
    
    output_text="$temp$text$temp"
    echo $output_text
}


# specify libraries to install via pip
pip_install='
    discord
    '


# ask yes / no 
pad "Packages to install via pip" 100
echo $pip_install
echo 
echo Install these packages?


select yn in "Yes" "No"
do 
    case $yn in 
        Yes ) break;;
        No ) exit;;
    esac
done


# install via apt
for pip_package in $pip_install
do 
    pad "Packages (apt): Installing $pip_package" 100
    python3 pip install -y $pip_package
    echo 
    echo
done


pad "Finished installing" 100