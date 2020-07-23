#!/bin/bash


#Chinese
gsettings set org.gnome.gedit.preferences.encodings candidate-encodings "['GB18030', 'UTF-8', 'CURRENT', 'ISO-8859-15', 'UTF-16']"


### Gedit themes
git clone https://github.com/ricardograca/gedit-themes.git
sudo mv -i gedit-themes/*xml /usr/share/gtksourceview-3.0/styles/
#Local Gedit3 = "$HOME/.local/share/gtksourceview-3.0/styles"
#Global Gedit3 = "/usr/share/gtksourceview-3.0/styles"
#Local Gedit2 = "$HOME/.gnome2/gedit/styles"
#Global Gedit2 = "/usr/share/gtksourceview-2.0/styles"



###Gmate color your code
sudo apt-add-repository ppa:ubuntu-on-rails/ppa
sudo apt-get update
sudo apt-get install gedit-gmate

