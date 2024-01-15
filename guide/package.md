

Common commands:
1. Install a package: `sudo pacman -S pkg1` (`-s` stands for synchronize)
2. Remove a package: `sudo pacman -R pkg`
    - remove dependencies also: `-s` (recursive)
    - also remove configuration files: `-n` (no save) 
    - also removes children packages: `-c` (cascade)
3. Update all packages: `sudo pacman -Syu`
    - synchronize: `-S` 
    - refresh package databases: `-y` (completely refresh: `-yy`)
    - system upgrade: `-u`
4. List installed packages: `pacman -Q`
    - List detailed info about package: `pacman -Qi pkg` 
    - List all files provided by pkg: `pacman -Ql pkg` 
    - List all orphaned packages: `pacman -Qdt`
    - List all packages that have updates available: `pacman -Qu`
    - List all explicitly installed packages: `pacman -Qet`

Beyond the minimalities, we can also 
1. use the `pactree pkg` command from `pacman-contrib` to see the dependency tree of a package. 
2. The configuration file can be found in `/etc/pacman.conf`
3. The package cache stored in `/var/cache/pacman/pkg/` keeps old or uninstalled versions of packages automatically. 
     - We can delete all cached versions of installed and uninstalled packages, except for the most recent 3, by running `paccache -r` (provided by the `pacman-contrib` package). 
     - To remove all cached packages not currently installed, run `pacman -Sc`
     - To remove all cached aggressively, run `pacman -Scc`
4. To check the size of current packages and their dependencies, download `expac` and run `expac -H M '%m\t%n' | sort -h`
5. To list the last 20 installed packages, run `expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 20`
