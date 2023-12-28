# Setting up Vim and Neovim 

Vim is guaranteed to be on every Linux system, so there is no need to install it. However, you may have to install Neovim (which is just a command away). Vim can be a really big pain in the ass to learn, but I got into it when I was watching some video streams from a senior software engineer at Netflix called The Primeagen. He moved around the code like I've never seen, and I was pretty much at the limit of my typing speed, so I decided to give it a try during the 2023 fall semester. My productivity plummetted during the first 2 days (which was quite scary given that I had homework due), but within a few weeks I was faster than before, so if you have the patience, I would recommend learning it. Here is a summary of reasons why I would recommend learning Vim: 
1. It pushes you to know the ins and outs of your editor. As a mechanic with his tools, a programmer should know exactly how to configure their editor. 
2. The plugin ecosystem is much more diverse than other editors such as VSCode. You can find plugins/extensions for everything. Here is a summmary of them [here](https://github.com/rockerBOO/awesome-neovim#neovim-lua-development). 
3. You're faster. If you're going to be coding for the next 5 years, then why no t spend a month to master something that will make you faster? You'll increase total productivity. 
4. Computing clusters and servers will be much easier to navigate since they all run Linux with Vim. 
5. Vim is lightweight, and you don't have to open up VSCode every time you want to edit a configuration file.  

## Vim vs Neovim

Experience wise, Vim and Neovim are very similar, and if you configure things rihght, you may not even be able to tell the difference. But there are 3 differences that I want to mention. 
1. Neovim can be configured in Lua, which is much cleaner than Vimscript. 
2. Neovim provides mouse control right out of the box, which is convenient for me at times and can be easier to transition into, while Vim does not provide any mouse support. 
3. There are some plugins that are provided in Neovim that are not in Vim. 


## Setting up Vim

In Vim, your configuration files are located in `~/.vimrc`. 


and plugins are located in `~/.vim/`

## Setting up Neovim

In Neovim, your configuration files are locatd in `~/.config/nvim/` and I use the packer package manager. The installed plugins are located at `~/.local/share/nvim/site/pack/packer/`, which contains two directories. The packages in `start/` are loaded up every time Neovim starts, and those in `opt/` are packages that are loaded up when a command is called in a certain file (known as lazy loading). Each package is just a gitub repository that has been clone into the respective folder. 

I have my configuration written in Lua. First, in the `nvim/` directory you shoul have an `init.lua` file, which is called first. If you look in my configuration file, it goes through all the files in the `nvim/lua/user/` directory and runs them. Basic options and keymaps are stored in `options.lua` and `keymaps.lua`. Other plugin-specific options are in their respective files. 


#### TroubleShooting

A good test to run is `:checkhealth`, which checks for any errors or warnings in your Neovim configuration. You should aim to have every (non-optional) warning cleared, which usually involves having to install some package, making it executable and/or adding to `$PATH`. 

If you are getting plugin errors, you can also manually delete the plugin directory in `pack/packer` and run `PackerInstall` to re-pull the repos. This may help. 
