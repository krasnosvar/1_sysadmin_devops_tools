#install wine
#https://help.ubuntu.com/community/Wine
wget https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
sudo apt install wine
sudo apt-get install cabextract #needs for dotnet
winecfg

#install dotnet48
#install winetrics
#https://appdb.winehq.org/objectManager.php?sClass=version&iId=32828
sudo wget 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -O /usr/local/bin/winetricks
sudo chmod +x /usr/local/bin/winetricks
env WINEPREFIX=$HOME/winedotnet winetricks --force dotnet48 corefonts
sudo apt-get install cabextract
