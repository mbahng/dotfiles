# Command glossary

Click a status widget or its group icon to read its section in Kitty.
Right-click a group icon to expand/collapse it. Commands are never run by the glossary.
Edit these sections to keep your own notes; no Qtile reload is needed for text changes.
Keep section names unchanged because the bar uses them as topic identifiers.

## cpu
htop                               — Interactive process monitor (q to quit)
top                                — Built-in alternative process monitor
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -20
                                   — Processes using the most CPU
lscpu                              — CPU model, cores, and architecture
uptime                             — Uptime and load averages
sensors                            — Hardware temperatures (lm_sensors package)
kill -TERM PID                     — Ask a specific process to exit

## gpu
nvtop                              — Interactive GPU process monitor
nvidia-smi                         — NVIDIA usage, memory, temperature, and processes
watch -n 1 nvidia-smi               — Refresh NVIDIA status every second (Ctrl+C to stop)
nvidia-smi -L                       — List NVIDIA GPUs
nvidia-settings                    — Graphical NVIDIA settings

## memory
free -h                            — RAM and swap usage
htop                               — Press F6 and choose memory to sort processes
ps -eo pid,comm,%mem,rss --sort=-rss | head -20
                                   — Largest processes by resident memory
vmstat 1                           — Memory, swap, CPU, and I/O activity (Ctrl+C to stop)
swapon --show                       — Active swap devices/files

## disk
df -h                              — Free space on mounted filesystems
df -i                              — Inode usage (useful when space appears available)
lsblk -f                           — Disks, partitions, filesystems, and mounts
du -h --max-depth=1 ~ | sort -h      — Home-directory usage, including hidden directories
ncdu ~                             — Interactive disk usage browser (optional ncdu package)
findmnt                            — Mounted filesystems

## wifi
iw dev wlp8s0 link                  — SSID, frequency (MHz), signal (dBm), TX/RX link rates
iw dev wlp8s0 link | grep -E 'freq|signal|bitrate'
                                   — Show only radio signal, frequency, and link rates
watch -n 1 iw dev wlp8s0 link        — Refresh link details every second (Ctrl+C to stop)
nmtui                              — Interactive Wi-Fi/connection manager
nmcli device status                — Network device connection state
nmcli device wifi list             — Available Wi-Fi networks
nmcli --ask device wifi connect "SSID"
                                   — Join a network; prompt for its password
nmcli connection show              — Saved connection profiles
nmcli connection up "PROFILE"      — Activate a saved connection
nmcli connection down "PROFILE"    — Disconnect a connection
nmcli radio wifi on                — Enable Wi-Fi (use off to disable)
rfkill list                        — Check airplane-mode/hardware blocks
nm-connection-editor               — Graphical connection settings

Bar icons: 📡 received power in dBm (less negative is stronger).
📻 is the channel's frequency in MHz. TX/RX are radio rates in Mb/s,
not actual transfer throughput; N/A means the driver did not report that field.
⬇/⬆ show actual received/sent traffic on the routed interface in megabits per
second. The bar refreshes every second and automatically follows Ethernet or
Wi-Fi, preferring the IPv4 route and falling back to IPv6. Wi-Fi radio details
appear only when Wi-Fi is selected. 8 bits = 1 byte.
Reference: https://wireless.docs.kernel.org/en/latest/en/users/documentation/iw.html

## network
Ethernet's Link field shows the negotiated link speed (for example, 1 Gbps),
not actual throughput. N/A means the driver did not report a valid speed.
On full-duplex links, that speed is available in each direction simultaneously.

ip -br addr                        — Interfaces and IP addresses
ip route                           — Routes and default gateway
ping -c 4 1.1.1.1                  — Test external IP connectivity
getent hosts example.com           — Test hostname resolution
ss -tulpn                          — Listening TCP/UDP sockets (process details may need sudo)
nmcli connection show --active     — Active NetworkManager connections
nmcli device show                  — Connection details, including DNS servers
journalctl -u NetworkManager -b -n 50
                                   — Recent networking logs

## bluetooth
bluetoothctl                       — Interactive Bluetooth console (quit to exit)
bluetoothctl show                  — Controller state
bluetoothctl devices               — Known devices and their addresses
bluetoothctl power on              — Enable the Bluetooth controller
bluetoothctl scan on               — Discover nearby devices; use inside the console
bluetoothctl scan off              — Stop discovery; use inside the console
bluetoothctl pair MAC              — Pair with a discovered device
bluetoothctl trust MAC             — Mark a device as trusted
bluetoothctl connect MAC           — Connect to a device
bluetoothctl disconnect MAC        — Disconnect a device
rfkill list bluetooth              — Check Bluetooth radio blocks

## audio
wpctl status                       — Devices and IDs; * marks defaults
wpctl get-volume @DEFAULT_AUDIO_SINK@
                                   — Current output volume and mute state
wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%
                                   — Set output volume
wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
                                   — Raise volume by 5%, capped at 100%
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
                                   — Lower volume by 5%
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
                                   — Toggle output mute
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
                                   — Toggle microphone mute
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 70%
                                   — Set microphone level
wpctl set-default ID                — Choose a sink/source ID from wpctl status as default
wpctl inspect ID                    — Inspect a device/node's properties
pavucontrol                        — Graphical volume, routing, and device controls
alsamixer                          — Hardware mixer (F6 selects sound card)
systemctl --user status pipewire wireplumber
                                   — Audio service status

Sinks are outputs; sources are inputs. IDs can change: check wpctl status first.
Reference: https://pipewire.pages.freedesktop.org/wireplumber/man/wpctl.html

## updates
checkupdates                       — Check repository updates (pacman-contrib package)
pacman -Q                          — List installed packages
pacman -Qs KEYWORD                 — Search installed packages
pacman -Ss KEYWORD                 — Search repository packages
pacman -Qi PACKAGE                 — Installed package details
pacman -Si PACKAGE                 — Repository package details
sudo pacman -Syu                   — Synchronize repositories and upgrade the system
sudo pacman -S PACKAGE             — Install a package
less /var/log/pacman.log           — Package-manager history

## clock
date                               — Current local date/time
date -u                            — Current UTC date/time
cal                                — Calendar for this month
cal -y                             — Calendar for this year
timedatectl status                 — Time zone and clock synchronization status
timedatectl list-timezones         — Available time zones
TZ=Europe/London date              — Show time in another zone

## wallpaper
ls ~/Media/Pictures/wallpaper/      — List configured wallpapers
feh --bg-fill "/path/to/image.jpg" — Set an X11 wallpaper manually
feh ~/Media/Pictures/wallpaper/     — Browse images with feh
xdg-open ~/Media/Pictures/wallpaper/
                                   — Open the wallpaper folder

## markets
xdg-open 'https://www.tradingview.com/symbols/AMEX-SPY/'
                                   — Open an SPY market page
xdg-open 'https://www.coingecko.com/en/coins/ethereum'
                                   — Open an Ethereum market page
date                               — Check local time when comparing quote timestamps

The SPY bar widget uses end-of-day quotes and polls hourly; it is not a live price.

## news
xdg-open 'https://www.nytimes.com/section/world'
                                   — Open world news in your browser
curl -L 'https://rss.nytimes.com/services/xml/rss/nyt/World.xml' | less
                                   — Inspect the RSS feed used by the bar
newsboat                           — Terminal RSS reader, if installed/configured

Wi-Fi reference: https://networkmanager.pages.freedesktop.org/NetworkManager/NetworkManager/nmcli-examples.html
