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


# install prerequisites (git, make, rust, cargo) 
pad "Installing Prerequisites" 100
sudo apt update
sudo apt install git -y
sudo apt-get install make -y
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install cargo -y

# install normal spotify 
pad "Installing spotify" 100
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6224F9941A8AA6D1
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update 
sudo apt-get install spotify-client


# Begin Install
pad "clone into spotify-adblock.git" 100
sudo git clone https://github.com/abba23/spotify-adblock.git
cd spotify-adblock
make 


# Install adblocked spotify
pad "Install adblock" 100
sudo make install
sudo mkdir -p ~/.spotify-adblock && cp target/release/libspotifyadblock.so ~/.spotify-adblock/spotify-adblock.so
sudo mkdir -p ~/.config/spotify-adblock && cp config.toml ~/.config/spotify-adblock
flatpak override --user --filesystem="~/.spotify-adblock/spotify-adblock.so" --filesystem="~/.config/spotify-adblock/config.toml" com.spotify.Client


# adding .desktop file
pad "Creating desktop file" 100

sudo touch /usr/share/applications/spotify-adblock.desktop
echo "[Desktop Entry]" | sudo tee /usr/share/applications/spotify-adblock.desktop
echo "Name=Spotify Adblock" | sudo tee /usr/share/applications/spotify-adblock.desktop -a
echo "Exec=env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify" | sudo tee /usr/share/applications/spotify-adblock.desktop -a
echo "Type=Application" | sudo tee /usr/share/applications/spotify-adblock.desktop -a 

sudo chmod a+x /usr/share/applications/spotify-adblock.desktop
