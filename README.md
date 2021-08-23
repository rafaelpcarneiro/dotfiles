# dotfiles

All my config files are here. They are
- **bashrc**:
     configurations for the terminal, such as the PS1 info, a
     function to synchronize my local repository with my github
     account using ssh, and some others;

- **vimrc**:
     configurations for VIM;

- **i3config**:
     small changes on the configuration done automatically by i3;

- **i3blocks.conf**:
     settings regarding what informations will be displayed at the
     status bar. I use i3blocks instead of i3status;

- **xsession**:
     configuration for the X session;

- **Xresources**: 
    the configurations for the Urxvt terminal, regarding its
    appearance;

- **xinitrc**:
    script responsible to start the X server with startx

- **shrc**:
    shell script used on my freebsd


**Obs1**: On the **xsession** file:
1. I choose which window manager to launch 
2. I source the urxvt terminal configuration with the command *xrdb*
3. I load the correct keyboard layout for my old thinkpad (pt-br). 
4. I switch ESC for CAPSLOCK and viceversa -- it is handy for VIM
