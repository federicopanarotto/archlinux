## Customization

We raccomand you to use a window manager after to have installed the base system  
It is a software that controls the placement and appereance of windows within a windowing system in a GUI  
``DOCUMENTATION``: https://wiki.archlinux.org/title/window_manager

There are different options to choose:
- bspwm
- xmonad
- i3  
- ...

These are some examples  
In this guide I will use bspwm because I think is good and nice to configure  
``DOCUMENTATION``: https://wiki.archlinux.org/title/bspwm

##
### Bspwm
#### Driver installation
First at all you need to install Xorg and X11 window server

    $ sudo pacman -S xorg xorg-server xorg-apps xorg-xinit

You have to check to the drivers of your GPU so check this guide  
``DOCUMENTATION``: https://wiki.archlinux.org/title/Xorg#Driver_installation

If you are using a vm follow these istructions:  
You need to install virtualbox utils and drivers

    $ sudo pacman -S virtualbox-guest-utils
    $ sudo pacman -S xf86-video-qxl

##
#### Install bspwm

Now you can install the window manager and the shortcut manager

    $ sudo pacman -S bspwm sxhkd

##
#### Config base bspwm
We need to create some directories to put bspwm file configurations

    mkdir ~/.config/bspwm
    mkdir ~/.config/sxhkd

Then we copy the base configuration file in these directories

    cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm
    cp /usr/share/doc/bspwm/examples/sxhkd ~/.config/sxhkd

## 
#### Install the terminal
For this tutorial I use Xterm  
To install follow this command:

    $ sudo pacman -S xterm

To make it as default window terminal we need to change sxhkd configuration  
For to this edit `~/.config/sxhkd/sxhkdrc`  
On the comment terminal emulator change the name of the terminal to

    xterm

##
#### Config X server
After previously xorg install now we edit the file to start the server  
First copy and them edit the configuration file:  

    $ sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
    $ vim ~/.xinitrc

Disable any other exec lines and add this at the bottom of the file

    exec bspwm

Before exec we add this line
    
    setxkbmap it &

This set the keyboard layout at xorg startup

##
#### Start xorg
To start xorg you have to just exec this command

    $ startx

Now you are in the base bspwm window manager

##
#### Set monitor resolution
For setting the resolution we use a program called arandr  
To install follow this:

    $ sudo pacman -S arandr

Execute it running its name on the terminal and on outputs label set your monitor resolution  
Then click on the save button and save as `display`  

It will create a directory and we load the script with xinit so we edit the xinitrc file
First we have to get run permission on the file

    $ chmod +x ~/.screenlayout/display.sh

In `xnitrc` before exec istruction we add this line

    $HOME/.screenlayout/display.sh

Now when we startx the resolution would be good

##
#### Set wallpaper
To set the wallpaper I use feh
So first install it

    $ sudo pacman -S feh

Now set the wallpaper

    $ feh --bg-center wallpaper_path

I suggest to put the wallpaper image in `~/.config/wallpaper/`  
Now we have to add this line in xinitrc configuration

    $ vim ~/.xinitrc


## 
#### Next

To install other feature you need a lot of time lol  
To make my configuration I have spent a week, so watch the dotfiles