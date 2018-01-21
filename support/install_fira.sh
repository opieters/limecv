#!/bin/bash

# cf from http://programster.blogspot.com/2014/05/ubuntu-14-desktop-install-fira-sans-and.html

pushd /tmp

sudo apt-get install unzip -y
wget "http://www.carrois.com/downloads/fira_4_1/FiraFonts4106.zip" -O FiraMainFonts.zip
wget "http://www.carrois.com/downloads/fira_mono_3_2/FiraMonoFonts3206.zip"  -O FiraMonoFonts.zip
unzip FiraMainFonts.zip -d FiraMain
unzip FiraMonoFonts.zip -d FiraMono
sudo mkdir -p /usr/share/fonts/truetype/FiraSans
sudo mkdir -p /usr/share/fonts/opentype/FiraSans
sudo cp FiraMain/Fira*/WEB/TTF/*.ttf /usr/share/fonts/truetype/FiraSans/
sudo cp FiraMono/Fira*/OTF/Fira* /usr/share/fonts/opentype/FiraSans/
sudo fc-cache -fv

popd