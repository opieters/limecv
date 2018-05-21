#!/bin/bash

# cf from http://programster.blogspot.com/2014/05/ubuntu-14-desktop-install-fira-sans-and.html

pushd /tmp

# install unzip
sudo apt-get install unzip -y
# create directory for cache
sudo mkdir -p limecvFonts
pushd limecvFonts

# download fonts
if [ ! -f FiraMainFonts.zip ]; then
    wget "http://www.carrois.com/downloads/fira_4_1/FiraFonts4106.zip" -O FiraMainFonts.zip
fi
if [ ! -f FiraMonoFonts.zip ]; then
    wget "http://www.carrois.com/downloads/fira_mono_3_2/FiraMonoFonts3206.zip"  -O FiraMonoFonts.zip
fi
if [ ! -f FontAwesome.zip ]; then
    wget "https://github.com/FortAwesome/Font-Awesome/archive/v4.7.0.zip" -O FontAwesome.zip
fi

# extract fonts
unzip FiraMainFonts.zip -d FiraMain
unzip FiraMonoFonts.zip -d FiraMono
unzip FontAwesome.zip -d FontAwesome

# create target directories for fonts
sudo mkdir -p /usr/share/fonts/truetype/FiraSans
sudo mkdir -p /usr/share/fonts/opentype/FiraSans
sudo mkdir -p /usr/share/fonts/truetype/FontAwesome
sudo mkdir -p /usr/share/fonts/opentype/FontAwesome

# copy fonts
sudo cp FiraMain/Fira*/WEB/TTF/*.ttf /usr/share/fonts/truetype/FiraSans/
sudo cp FiraMono/Fira*/OTF/Fira* /usr/share/fonts/opentype/FiraSans/
sudo cp FontAwesome/Font-Awesome*/fonts/fontawesome-webfont.ttf /usr/share/fonts/truetype/FontAwesome/fontawesome.ttf
sudo cp FontAwesome/Font-Awesome*/fonts/FontAwesome.otf /usr/share/fonts/opentype/FontAwesome/

# build cache
sudo fc-cache -fv

popd
popd