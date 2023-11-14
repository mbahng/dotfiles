# config
This repository contains all my configuration files and steps to streamline setting up on a new computer. I will go over how to do an ArchInstall in case I ever need it again for future         reference. It's been a great pain for me to install, so at the cost of an hour now at 3am before my machine learning homework is due, I hope that my future uses will reciprocate.  


## Preparing the Drive and FileSystem

### Partitioning the SSD (for Dual/Triple Boot) 

You should first partition your drive.  You should allocate at minimum 25GB of space for your new computer. For example, on Windows, go to Disk Management, right click on the disks and shrink them so that there's enough allocated disk space for the new operating system. There may be many reasons why you can't shrink, expand, or move around these already existing partitions, and to do that you'll need to use more powerful disk management toosl like DISKPART (especially to delete those annoying EFI partitions). If you are originally on Linux, then I don't know, but you would likely use Gparted, and you may have to modify these partitions from a bootable USB (just download a Ubuntu ISO, create a bootable USB drive with Rufus, and Ubuntu should have Gparted by default). 

### Create Partitions and Choose FileSystem 
You want to create a /boot, /swap, and / (root) partitions. There are 4 main ones: Ext4, btrfs, XFS, and OpenZFS. 

## Choose Linux Distribution

I've only had experience with Ubuntu and Arch, but others include PopOS, Kali Linux, Debian, etc. You should then download the proper ISO file online, create a bootable USB drive with Rufus, and boot into the ISO when you restart your computer. 

### Arch Linux

For my Arch installation I used the Sep 1 ISO version and followed https://www.youtube.com/watch?v=8oCHxzJky4U. 

### Ubuntu 22.04


## Essential Packages

### Network Managers 

At this point you should have already set up your network, probably in the installation boot, since you need a working network to download any packages. I use NetworkManager. 

### Desktop Environment / Windows Manager 

In this context, the DE and WM are the same thing. If the installation package does not come with a desktop environment, you won't even have a GUI to work with. I used GNOME + Ubuntu and Qtile + Arch, and I tend to prefer tiling windows managers, but other choice include KDE Plasma, Cinamon, Hyprland, i3. All these packages have their benefits and drawbacks.


### Audio 

There are mainly 2 sound software drivers: pulseAudio and pipewire. I've had a few problems with pulseAudio on Ubuntu so I currently use pipewire for Arch.   

### Bluetooth 

Install blueman for audio. Watch this video: https://www.youtube.com/~D_RdJjCU&t=298s for bluetooth on Arch. Should be straightforward to connect. 

### Monitor Control 

You should install xrandr and arandr, which provide both graphical and command line interfaces to switch monitor configurations. 

### File Manager

Note that this is not the same thing as a file system. This includes nemo, nautilus. 

### Additional Package Managers 
All the packages that you need should be available within the default package manager (apt, pacman, etc.). For Arch, yay is very important to download from the AUR and flatpak/snapd are good for Ubuntu. Also follow the video above to get the top 10 fastest routes for downloading, and allow parallel downloading. 


### SSH, Bash, and Git 
You can first download git but to git clone with ssh, you need to set up some default configuration files.  

You first make a key using ssh-keygen and just accept defaults. Now you want to activate the ssh-agent, so you do the eval "$(ssh-agent -s)" and then you do ssh-add ~/.ssh/id_ed2551 and then you do ssh-add ~/.ssh/id_ed25519. You paste the public key on github and whatever other organization sites you may need to ssh into. Then you can edit the ~/.ssh/config file to make things a bit easier. 

Now you also probably want to configure your bash terminal. This can be done through the .bashrc file, where you can change the color and prompt for your terminal. It is also needed for permanently adding stuff to the $PATH. 

## Additional Packages & Setup 

While you on this just download `htop`, `tree`, `nvtop`, `cmatrix`, `pactl` (to control audio),  

### Media

To me, the most important traits of these programs is that it is lightweight, fast, good keyboard shortcuts, and is aesthetic.  
  1) PDF Viewer: zathura (nice CLI like Vim, good with vimtex) 
  2) Image Viewer: feh (may try out qimgv)  
  3) Video Player: mpv 
  4) Screenshot Tool: flameshot 

### Browser 
You can download whatever, but my preferences in order are: Nightly, Firefox, Brave, Chrome, Edge. 

### Vim/Neovim & Vimtex 
You should have vim installed already. Now you install vim-plug by going on the github page and running their commands. Then you take the config file and run everything. You may have problems installing coc and vimtex. coc you need to install nodejs. For vimtex you need to make sure zathura (plus the other plugins that helps it render pdfs, epub, etc) are installed, and finally make sure that when you run. 

### VScode

First you want to install VScode (for Arch make sure to install the proprietary version by Microsoft since for the Arch one the ssh doesn't work). Then if you sign in you should have all your configurations and extensions loaded, which is good. 


### Python & Conda 

The next thing to do is to install Python, which you can do using yay or apt. It's not hard. Now I like to use the conda package manager since I do a lot of machine learning. I install miniconda3 from the website (prefer to do it over the apt or yay repository, and check where it is saved (could be in /opt/miniconda3 or /mbahng/miniconda3 or ~/.conda). You want your base environment to be minimial and almost never used. I personally don't install anything on there. I create one environment called `torch-base` which contains just a working installation of PyTorch. You must be very careful to check these dependencies (as of Nov 2023, PyTorch completely supports up to Python 3.10, though Python 3.12 is out). You want this env to be the rock solid deep learning package you can always fall back to or copy in case other ones break (which has happened to me quite often). The environment yaml and txt files are in this repo.  


### Julia 
This can be easily done in with the default package manager (e.g. yay for Arch). 


### C++ 


### JavaScript 


### Flutter & Dart 


### Connect to Nvidia GPU  Driver

Then run nvidia-smi to see if it's working. Then install pytorch and see if it detects cuda.
https://github.com/~rnel-parameter.

### Work & Social Applications 
I'll list some that I use: Zulip, Slack, Caprine (Facebook Messenger), Bluebubbles (iMessage), Whatsapp, Simplenote, Zoom, Skype

### Music Players 

Spotify does the job for me. 

### Gaming 
Lutris with Overwatch, and make sure you can connect it to the GPU driver. Additional gaming software packages would be good.
https://www.reddit.com/r/wine_gaming/comments/bkvhdx/play_overwatch_on_archlinux_with_3_steps/

### Virtual Machines

Install VirtualBox 

### Custom Scripts 

'mkdir /bin/custom_scripts' and put it into PATH in ~/.bashrc. 
Get the wiki, vimtex, and vstex commands all ready.

### Organizing Dotfiles  

Set up configuration folders with symbolic links and update it with the stuff in this repository.


### Startup Programs
The ~./xprofile file runs everything when X loads up. 


## Ricing 

### Qtile & Picom 

WARNING: Do not change under section `Corners`, the variable `corner-radius` to anything other than 0 (or whatever the default is). Doing this led to extremely large memory leaks in the shared RAM in my comptuer, which led to a huge headache solving it.  
### Conky 


