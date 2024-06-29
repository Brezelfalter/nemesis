#! /usr/bin/bash


# ---------- USER DEFINED ----------
# define the standard client version
install_version="check-mk-agent_2.3.0p3-1_all.deb"
# ---------- ------------ ----------


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


# ask for checkmk server url
pad "Connection" 100
echo "Give the Checkmk server URL (for example: http://myserver.de)"
read -p "Enter URL: " server_url
echo 
echo "Give the name of the monitoring site you would like to download the client file from"
read -p "Enter checkmk site: " sitename
echo "Selected Server $server_url and Site $sitename as the Checkmk site to pull from"
echo

PS3="Do you want to use $install_version as the client version?"

select option in "Keep standard version" "Use other version"
do
    if [[ "$option" == 2 ]]; then 
        read -p "Specify the version to install: " install_version
        echo "Selected given version $install_version to be installed"
        break
    else
        echo "Keeping standard version to be installed." 
        break
    fi
done
echo


# pulling install file
pad "Pulling installation file" 100
wget $server_url/$sitename/check_mk/agents/$install_version


# Installing file
pad "Installing" 100
sudo su
dpkg -i $install_version
echo 


# Finished
pad "Finished installation" 100