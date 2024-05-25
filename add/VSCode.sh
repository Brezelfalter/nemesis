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


# specify install app
flathub_install='
    com.visualstudio.code
    '


# ask yes / no 
pad "Packages to install via flathub" 100
echo $flathub_install
echo
echo Install these packages?


select yn in "Yes" "No"
do 
    case $yn in 
        Yes ) break;;
        No ) exit;;
    esac
done


# add flatpak to repos
echo 
pad "Add flatpak to repositories" 100
sudo add-apt-repository -y ppa:alexlarsson/flatpak
echo 
echo


# run apt update
pad "Running apt update" 100
sudo apt update
echo 
echo


# install flatpak from repo
pad "Instaling flatpak" 100
sudo apt install -y flatpak
echo 
echo


# install support for GNOME Software
pad "Installing support for GNOME Software" 100
sudo apt install -y gnome-software-plugin-flatpak
echo 
echo


# add remote location of flathub
pad "Adding flathub remote" 100
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo
echo


# install via flathub
for flathub_package in $flathub_install
do 
    pad "Packages (flathub): Installing $flathub_package" 100
    sudo flatpak install -y flathub $flathub_package
    echo 
    echo
done


# end of installation
pad "Finished installing" 100
echo 
echo


# announce need for reboot
pad "Reboot" 100
echo "The system may need to be rebooted in order to complete the installation and in order for the software to show up properly."
echo "Reboot now?"


select yn in "Yes" "No"
do 
    case $yn in 
        Yes ) break;;
        No ) exit;;
    esac
done


# reboot
echo "Rebooting..." 
reboot