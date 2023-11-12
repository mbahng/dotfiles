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

For my Arch installation I used the Sep 1 ISO version and followed https://www.youtube.com/watch?v=8oCHxzJky4U)). 

### Ubuntu 22.04


## Essential Packages

### Network Managers 

At this point you should have already set up your network, probably in the installation boot, since you need a working network to download any packages. I use NetworkManager. 

### Desktop Environment / Windows Manager 

In this context, the DE and WM are the same thing. If the installation package does not come with a desktop environment, you won't even have a GUI to work with. I used GNOME + Ubuntu and Qtile + Arch, and I tend to prefer tiling windows managers, but other choice include KDE Plasma, Cinamon, Hyprland, i3. All these packages have their benefits and drawbacks.


### Audio 



### Bluetooth 



### Monitor Control 



### File Manager

Note that this is not the same thing as a file system. This includes nemo, nautilus. 

### Additional Package Managers 

For Arch, yay is very important to download from the AUR and flatpak/snapd are good for Ubuntu. 


### SSH, Bash, and Git 

## Additional Packages & Setup 

### Media 
PDF Viewer, Image viewer, video player 


### Browser 


### Vim/Neovim & Vimtex 


### Program Development

Install VScode, with Python, set up Conda, then Julia.


### Connect to GPU  Driver

### Work & Social Applications 


### Music Players 

Spotify does the job for me. 

### Gaming 
Lutris with Overwatch, and make sure you can connect it to the GPU driver. Additional gaming software packages would be good.


### Virtual Machines

Install VirtualBox 

### Custom Scripts 



### 

Set up configuration folders with symbolic links and update it with the stuff in this repository. 
