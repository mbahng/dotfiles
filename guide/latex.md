 # LaTeX 

Latex is a great way to take notes. One can go to Overleaf and have everything preconfigured, but in here I set it up on my local desktop. 


## Setting up VimTex

I will already assume you have a PDF viewer installed. I use `zathura`, which is lightweight and also comes with vim motions for navigation. 

First install the VimTex plugin. 

```
use 'lervag/vimtex'
```
Then, you want to install TexLive, which is needed to compile tex files and to manage packages. The directions for TexLive installation is available [here](https://tug.org/texlive/quickinstall.html). Once I downloaded the install files, I like to run  
```
sudo perl ./install-tl --scheme=small
```
Be careful with the server location (which can be set with the `--location` parameter), as I have gotten some errors. I set `--scheme=small`, which installs about 350 packages compared to the default scheme, which installs about 5000 packages (~7GB). I also did not set `--no-interaction` since I want to slightly modify the `--texuserdir` to some other path rather than just my home directory. 

Once you installed everything, make sure to add the binaries to PATH, which will allow you to access the `tlmgr` package manager and gives VimTex access to these executables. Unfortunately, the small scheme installation does not also install the `latexmk` compiler, which is recommended by VimTex. We can simply install this by running 
```
sudo tlmgr install latexmk
```
Now run `:checkhealth` in Neovim and make sure that everything is OK. 


To install other Latex packages, we can also use tlmgr. All the binaries and packages are located in `/usr/loca/texlive/202*/` and since we're modifying this, we should run it with root privileges. The binaries can also be found here. Let's go through some basic commands: 
1. List all available packages: `tlmgr list` 
2. List installed packages: `tlmgr list --only-installed` (the packages with the `i` next to them are installed)
3. Install a package and dependencies: `sudo tlmgr install amsmath tikz`
4. Reinstall a package: `sudo tlmgr install amsmath --reinstall` 
5. Remove a package: `sudo tlmgr remove amsmath` 
More commands can be found [here](http://tug.ctan.org/info/tlmgrbasics/doc/tlmgr.pdf) for future reference. 
