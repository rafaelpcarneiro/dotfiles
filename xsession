# set the keyboard layout
setxkbmap -model thinkpad -layout br -variant abnt2

# toggle esc to be capslock and viceversa
setxkbmap -option caps:swapescape

# source the .Xresources
xrdb .Xresources 


exec i3 
