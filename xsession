# set the keyboard layout
setxkbmap -model thinkpad -layout br -variant abnt2

# toggle esc to be capslock and viceversa
setxkbmap -option caps:swapescape

# source the .Xresources
xrdb .Xresources 

# Load the emacsclient daemon
# exec emacsclient -a "" -c


exec i3
