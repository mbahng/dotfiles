# Neovim from Scratch

## Commands to run 


Make sure to remove or move your current `nvim` directory by deleting `~/.vimrc`, `~/.config/nvim`, and `~/.local/share/nvim`.

When you log into a new server, there will be two cases.
1. You don't have sudo privileges. In this case you probably won't be able to set up your nvim configuration and should stick to vim. You can just download >
```
ln -s ~/dotfiles/editor/vim/.vimrc ~/.vimrc 
```
go into the file and save it to trigger the install script I put into the file.

2. You do have sudo privileges, or know someone who does and can install packages (and modify global path variables) for you. In this case you should use ne>
```
ln -s ~/dotfiles/editor/nvim ~/.config/nvim 
```
You should have `conda`, `node`, `npm`, `python` installed and make sure they are in PATH. Make sure you're using bash or zsh rather than sh shell. From then on, you should run `:checkhealth` to see if you need anything else. You can uninstall plugins like vimtex which are ones that I only use locally. 


## SCP 

You can transfer large files from one server to another with the following. 

If you are on a local machine: 
1. To transfer a file or folder to a server, do 
```
scp Path/To/Local/File username@196.203.12.3:Path/To/Remote/File            # for files 
scp -r Path/To/Local/Folder username@196.203.12.3:Path/To/Remote/Folder     # for folders 
```

2. To transfer a file or folder from the server to you, do
```
scp username@196.203.12.3:Path/To/Remote/File Path/To/Local/File            # for files
scp -r username@196.203.12.3:Path/To/Remote/Folder Path/To/Local/Folder     # for folders with -r (recursive) 
```




