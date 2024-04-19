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


# specify packages to install via apt
apt_install='
    nmap 
    htop 
    speedtest-cli
    cmatrix
    git
    iperf3
    etherape
    wireshark
    iftop
    hping3
    ptunnel
    tcpdump
    masscan
    whois
    whatweb 
    curl
    nikto
    tshark
    tmux
    openssh-client
    openssh-server
    kleopatra
    vim
    net-tools
    neofetch
    python3-pip
    '

# specify packages to install via snap
snap_install='
    discord 
    '


# ask yes / no 
pad "Packages to install via apt" 100
echo $apt_install
echo 
pad "Packages to install via snap" 100
echo $snap_install
echo
echo Install these packages?


select yn in "Yes" "No"
do 
    case $yn in 
        Yes ) break;;
        No ) exit;;
    esac
done


# run apt update
echo
pad "Running apt update" 100
sudo apt update
echo 
echo
pad "Installing snap" 100
sudo apt install -y snapd
sudo systemctl restart snapd snapd.socket # hopefully solve for snapd not running properly
echo 
echo


# install via apt
for apt_package in $apt_install
do 
    pad "Packages (apt): Installing $apt_package" 100
    sudo apt install -y $apt_package
    echo 
    echo
done


# install via snap
for snap_package in $snap_install
do 
    pad "Packages (snap): Installing $snap_package" 100
    sudo snap install $snap_package
    echo 
    echo
done


pad "Finished installing" 100