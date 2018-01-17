# source: https://gist.github.com/muammar/a5ffb635eb7f532346a8e777b847f8a7#file-getfirafonts-sh-L16

pushd /tmp

sudo apt-get install unzip -y
wget "http://www.carrois.com/downloads/fira_4_1/FiraFonts4106.zip"
wget "http://www.carrois.com/downloads/fira_mono_3_2/FiraMonoFonts3206.zip"
unzip FiraSans4106.zip
unzip FiraMono3206.zip
sudo mkdir -p /usr/share/fonts/truetype/FiraSans
sudo mkdir -p /usr/share/fonts/opentype/FiraSans
sudo cp Fira*/WEB/*.ttf /usr/share/fonts/truetype/FiraSans/
sudo cp Fira*/OTF/Fira* /usr/share/fonts/opentype/FiraSans/
sudo fc-cache -fv

popd