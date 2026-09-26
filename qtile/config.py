from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
import os
import math
import re
import shlex
import xml.etree.ElementTree as ET

import subprocess
import json
import time
import psutil
# from qtile_extras import widget 
# from qtile_extras.widget.decorations import PowerLineDecoration

mod = "mod4"
terminal = "kitty"
bring_front_click = True


def audio_output_status():
    """Read the default output in GenPollText's worker thread."""
    try:
        def pactl(*args):
            return subprocess.run(
                ["pactl", *args], capture_output=True, text=True,
                timeout=2, check=True, env={**os.environ, "LC_ALL": "C"},
            ).stdout

        default_sink = pactl("get-default-sink").strip()
        sinks = json.loads(pactl("--format=json", "list", "sinks"))
        sink = next((s for s in sinks if s["name"] == default_sink), None)
        if sink is None:
            return "Audio: no output"
        device = sink.get("description") or sink["name"]
        volume = "0%" if sink["mute"] else next(iter(sink["volume"].values()))["value_percent"]
        return f"{volume} | {device[:5]}"
    except (OSError, subprocess.SubprocessError, ValueError, KeyError, StopIteration):
        return "Audio: unavailable"


def format_wifi_link(output, interface):
    """Format iw link data; missing driver fields stay explicitly unavailable."""
    if "Not connected." in output:
        return "Wi-Fi: disconnected"
    if not output.lstrip().startswith("Connected to "):
        return "Wi-Fi: unavailable"
    fields = dict(line.strip().split(":", 1) for line in output.splitlines()
                  if ":" in line and not line.startswith("Connected to "))
    try:
        signal = f"{float(fields['signal'].split()[0]):4.0f}"
    except (KeyError, ValueError, IndexError):
        signal = f"{'N/A':>4}"
    try:
        frequency = f"{float(fields['freq']):4.0f}"
    except (KeyError, ValueError):
        frequency = f"{'N/A':>4}"

    def bitrate(direction):
        match = re.match(r"\s*([\d.]+)\s+MBit/s", fields.get(f"{direction} bitrate", ""))
        try:
            return f"{float(match[1]):6.1f}" if match else f"{'N/A':>6}"
        except ValueError:
            return f"{'N/A':>6}"

    return (f"Wi-Fi {interface}|📻{frequency}MHz|📡{signal}dBm|"
            f"TX{bitrate('tx')}Mb/s|RX{bitrate('rx')}Mb/s")


def wifi_link_status(interface):
    """Called by GenPollText's worker thread so iw cannot block the bar."""
    try:
        result = subprocess.run(
            ["iw", "dev", interface, "link"],
            capture_output=True, text=True, timeout=2, check=True,
            env={**os.environ, "LC_ALL": "C"},
        )
    except FileNotFoundError:
        return "Wi-Fi: iw not installed"
    except (OSError, subprocess.SubprocessError):
        return "Wi-Fi: unavailable"
    return format_wifi_link(result.stdout, interface)


def active_network_interface():
    """Ask the kernel which interface carries internet traffic; sends no packets."""
    for destination in ("1.1.1.1", "2606:4700:4700::1111"):
        try:
            result = subprocess.run(
                ["ip", "-j", "route", "get", destination],
                capture_output=True, text=True, timeout=2, check=True,
            )
            routes = json.loads(result.stdout)
            if routes and routes[0].get("dev"):
                return routes[0]["dev"]
        except (OSError, subprocess.SubprocessError, ValueError):
            continue
    return None


class NetworkStatus:
    """Keep link details and throughput on the same routed interface."""

    def __init__(self):
        self.previous = None

    def __call__(self):
        interface = active_network_interface()
        counters = psutil.net_io_counters(pernic=True).get(interface)
        if interface is None or counters is None:
            self.previous = None
            return "Network: disconnected"
        now = time.monotonic()
        down = up = 0.0
        if self.previous and self.previous[0] == interface:
            _, then, previous = self.previous
            elapsed = now - then
            if elapsed > 0:
                down = max(0, counters.bytes_recv - previous.bytes_recv) * 8 / elapsed / 1e6
                up = max(0, counters.bytes_sent - previous.bytes_sent) * 8 / elapsed / 1e6
        self.previous = (interface, now, counters)
        if os.path.isdir(f"/sys/class/net/{interface}/wireless"):
            link = wifi_link_status(interface)
        else:
            kind = "Ethernet" if os.path.exists(f"/sys/class/net/{interface}/device") else "Network"
            link = f"{kind}"
            if kind == "Ethernet":
                try:
                    with open(f"/sys/class/net/{interface}/speed") as speed_file:
                        speed = int(speed_file.read().strip())
                    if speed <= 0:
                        raise ValueError("Unknown link speed")
                    rate = f"{speed / 1000:g} Gbps" if speed >= 1000 else f"{speed} Mbps"
                except (OSError, ValueError):
                    rate = "N/A"
                link += f"|Link: {rate}"
        return f"{link}|⬇{down:6.1f}Mb/s|⬆{up:6.1f}Mb/s"


_mouse_sens_script = os.path.join(os.path.dirname(os.path.realpath(__file__)), "mouse_sens.sh")


def _kill_or_minimize(qtile):
    win = qtile.current_window
    if win is None:
        return
    if Match(wm_class="thunderbird").compare(win):
        win.minimize()
    else:
        win.kill()


def _show_thunderbird(qtile):
    for win in qtile.windows_map.values():
        if Match(wm_class="thunderbird").compare(win):
            win.minimized = False
            win.group.toscreen()
            win.group.focus(win)
            return
    qtile.spawn("thunderbird")


show_thunderbird = lazy.function(_show_thunderbird)

def get_mouse_sensitivity():
    try:
        return subprocess.check_output([_mouse_sens_script], text=True).strip()
    except Exception:
        return "N/A"


def glossary(topic):
    """Open a reference in Kitty, followed by an interactive shell."""
    script = os.path.join(os.path.dirname(os.path.realpath(__file__)), "glossary.py")
    return lazy.spawn(shlex.join([terminal, "--title", f"Commands: {topic}",
                                 "-e", "python3", script, topic]))


def glossary_box(topic, **config):
    """Left-click for help; right-click to expand/collapse the group."""
    box = widget.WidgetBox(mouse_callbacks={"Button1": glossary(topic)}, **config)
    box.add_callbacks({"Button3": box.toggle})
    return box

# autostart on qtile 
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])


keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
   
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),


    # Launching/Closing application shortcuts 
    Key([mod], "Return", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(["mod1", "control"], "t", lazy.spawn(terminal), desc="Launch terminal"), 
    
    Key([mod], "q", lazy.function(_kill_or_minimize), desc="Kill focused window (minimize Thunderbird)"),
    Key([mod], "w", lazy.spawn("whatsapp-for-linux"), desc="Launch whatsapp (w - whatsapp)"), 
    Key([mod], "e", lazy.spawn("nemo"), desc="Launch file manager nemo (e - nEmo)"), 
    Key([mod], "r", lazy.spawn("dotfiles/custom_scripts/wechat"), desc="Launch WeChat"), 
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "y", lazy.spawn("youtube-music-desktop-app"), desc="Launch Youtube Music (y - Youtube Music)"),  
    Key([mod], "u", lazy.spawn(""), desc=""), 
    Key([mod], "i", lazy.spawn("bluebubbles"), desc="Launch iMessage (i - imessage)"),
    Key([mod], "o", lazy.spawn(""), desc=""),  
    Key([mod], "p", lazy.spawn("beeper"), desc="Launch beeper (p - beePer)"),

    
    Key([mod], "a", lazy.spawn("dotfiles/custom_scripts/vpn"), desc=""), 
    Key([mod], "s", lazy.spawn("slack"), desc="Launch slack (s - slack)"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch discord (d - Discord)"), 
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "g", lazy.spawn(""), desc=""),
   

    Key([mod], "z", lazy.spawn("zoom"), desc="Launch zoom (z - zoom)"), 
    Key([mod], "x", lazy.spawn("virtualbox"), desc="Launch VirtualBox (x - boX)"),
    Key([mod], "c", lazy.spawn("caprine"), desc="Launch caprine (c - caprine)"), 
    Key([mod], "v", lazy.spawn("code"), desc="Launch vscode (v - vscode)"), 
    Key([mod], "b", lazy.spawn("brave"), desc="Launch brave (b - browser)"),
    Key([mod, "shift"], "i", lazy.spawn("inkscape"), desc="Launch iNkscape"),
    Key([mod], "m", lazy.spawn("thunderbird"), desc="Launch thunderbird (m - mail)"), 
    
    Key([mod, "shift"], "n", lazy.spawn("screenkey"), desc="Launch screenkey (sk - ScreenKey)"),
    Key([mod, "shift"], "m", lazy.spawn("obs"), desc="Launch obs screen & audio recorder"), 

    # Extra utilities
    # actual print screen key is "Print" 
    Key([], "F10", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle mute/unmute volume"),
    Key([], "Print", lazy.spawn("ksnip -r -s"), desc="Print Screen Selection"),
    Key(["shift"], "Print", lazy.spawn("ksnip -f -s"), desc="Print current screen"),
    
    # Adjust screen brightness keys 
    # Key([], "F6", lazy.spawn("brightnessctl --device=intel_backlight set 20-"), desc="Increase brightness -20/400"), 
    # Key([], "F7", lazy.spawn("brightnessctl --device=intel_backlight set 20+"), desc="Increase brightness +20/400"), 

    # Adjust keyboard brightness keys 
    # Key([], "F5", lazy.spawn("brightnessctl --device=dell::kbd_backlight set 1+"), desc="Increase keyboard backlight by 1"), 
    # Key(["control"], "F5", lazy.spawn("brightnessctl --device=dell::kbd_backlight set 1-"), desc="Decrease keyboard backlight by 1"), 
    
    # Volume Adjustment
    Key([], "F1", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle mute/unmute volume"), 
    Key([], "F2", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease volume by 5%"), 
    Key([], "F3", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase volume by 5%"),
    Key([], "F11", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease volume by 5%"),
    Key([], "F12", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase volume by 5%"),


    # Reloading and quitting Qtile configuration
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(
        border_focus = "#36c3d6",
        border_normal = "#082e70", 
        margin=5, 
        border_width = 2
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=13,
    padding=2,
)
extension_defaults = widget_defaults.copy()

colors = {
    "red" : "#edc9d4",  
    "orange" : "#ffd3c9",  
    "yellow" : "#fff7cf", 
    "green" : "#e4f0c9", 
    "blue" : "#c7e0ff",  
    "purple" : "#cfcfff", 
    "violet" : "#bac3ff", 
    "white" : "#ffffff",  
    "black" : "#000000" 
} 

def stock_parser(data):
    try:
        price = float(data["Global Quote"]["05. price"])
        if math.isfinite(price) and price > 0:
            return f"SPY: ${price:.2f}"
    except (KeyError, TypeError, ValueError):
        pass
    return "SPY: unavailable"


def news_parser(body):
    try:
        root = ET.fromstring(body)
    except (ET.ParseError, TypeError, ValueError):
        return "NYTimes: unavailable"
    headlines = [
        title.text.strip()
        for title in root.findall("./channel/item/title")
        if title.text and title.text.strip()
    ]
    return "          ".join(headlines) or "NYTimes: unavailable"


screens = [
    Screen(
        top  = bar.Bar(
            [
                # The boxes that indicate the workspaces
                widget.GroupBox(
                    borderwidth=1, 
                    rounded = True, 
                    padding_x = 10, 
                    padding_y = 8
                ),
                widget.Sep(),
                widget.GenPollUrl(
                    mouse_callbacks={"Button1": glossary('markets')},
                    # The free quote endpoint provides end-of-day prices.
                    url="https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=SPY&apikey=S8TMOKO9BYQ38JXO",
                    parse=stock_parser,
                    update_interval = 3600, 
                    padding = 2, 
                ), 
                widget.TextBox("/"), 
                widget.CryptoTicker(
                    mouse_callbacks={"Button1": glossary('markets')},
                    crypto="ETH", 
                    padding = 2, 
                    update_interval = 600, 
                ), 
                widget.Sep(), 
                widget.GenPollUrl(
                    mouse_callbacks={"Button1": glossary('news')},
                    foreground='#ffffff',
                    scroll = True, 
                    scroll_delay = 5, 
                    width = 560, 
                    update_interval=1800,
                    fmt = "{}",
                    url = "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
                    json = False,
                    parse = news_parser, 
                ),
                widget.Sep(), 
                widget.Prompt(),
                widget.Spacer(

                ), 
                # widget.WindowName(
                #     format = "{state} {name}", 
                #     max_chars = 50, 
                #     padding = 8,     
                #),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },start_opened = True, 
                    name_transform=lambda name: name.upper(),
                ),
                 
                widget.TextBox(
                    text = "\N{ENVELOPE}",
                    background = colors["red"],
                    foreground = "#FFFFFF",
                    padding = 8,
                    mouse_callbacks = {"Button1": show_thunderbird},
                ),
                widget.Systray(     # needed for app icons
                    background = colors["red"],
                    padding = 8,
                ),
                glossary_box('updates',
                    start_opened = True,
                    widgets = [
                        widget.CheckUpdates(
                            mouse_callbacks={"Button1": glossary('updates')},
                            distro = "Arch",
                            initial_text = "Updates", 
                            no_update_string = "0 Updates", 
                            background = "#AA78A6",
                            foreground = "#000000", 
                            padding = 3, 
                        )
                    ], 
                    text_closed = "\N{CANADIAN SYLLABICS CARRIER TTA}", 
                    text_open = "\N{CANADIAN SYLLABICS CARRIER TTA}", 
                    background = "#AA78A6", 
                    padding = 5, 
                    close_button_location = "right", 
                ), 
                glossary_box('performance',
                    start_opened = True,
                    widgets = [
                        widget.CPU(
                            background = "#AC80A0", 
                            foreground = "#000000", 
                            format = "CPU: {freq_current} GHz ({load_percent}%)",
                            mouse_callbacks={"Button1": glossary('cpu')},
                            padding = 5, 
                        ), 
                        widget.NvidiaSensors(
                            background = "#AC80A0", 
                            foreground = "#000000", 
                            format = "GPU: {temp} C {perf}",
                            mouse_callbacks={"Button1": glossary('gpu')}, 
                            padding = 5
                        )
                    ], 
                    background = "#AC80A0", 
                    text_closed = "\N{PERSONAL COMPUTER} ", 
                    text_open = "\N{PERSONAL COMPUTER} ", 
                    padding = 2, 
                    close_button_location = "right", 
                ),
                glossary_box('memory',
                    start_opened = True,
                    widgets = [
                        widget.Memory(
                            mouse_callbacks={"Button1": glossary('memory')},
                            background = "#89AAE6", 
                            foreground = "#000000",
                            format = "{MemUsed:.0f}/{MemTotal:.0f}{mm}B",
                            padding = 4, 
                        )    
                    ],   
                    text_closed = "\N{RAM} ", 
                    text_open = "\N{RAM} ", 
                    background = "#89AAE6", 
                    close_button_location = "right", 
                ), 
                glossary_box('disk',
                    start_opened = True,
                    widgets = [
                        widget.DF(
                            background = "#89AAE6", 
                            foreground = "#000000",
                            warn_color = "#000000",
                            measure = "G",
                            mouse_callbacks={"Button1": glossary('disk')}, 
                            format = "{uf:.0f}/{s:.0f}{m}B Free", 
                            warn_space = 1e9, 
                            padding = 4, 
                            update_interval = 5, 
                        )
                    ], 
                    text_closed = "\N{FILE FOLDER} ", 
                    text_open = "\N{FILE FOLDER} ", 
                    background = "#89AAE6", 
                    close_button_location = "right", 
                ),  
                glossary_box('networking',
                    start_opened = True,
                    widgets = [
                        widget.Bluetooth(
                            mouse_callbacks={"Button1": glossary('bluetooth')},
                            default_text = "ᛒ {connected_devices}",
                            default_timeout = 5,
                            separator = ", ",
                            markup = False,
                            background = "#0471A6", 
                            foreground = "#000000", 
                            padding = 4, 
                        ),
                        widget.GenPollText(
                            background = "#3685B5",
                            foreground = "#000000",
                            func = NetworkStatus(),
                            font = "monospace",
                            update_interval = 1,
                            markup = False,
                            padding = 2,
                            mouse_callbacks={"Button1": glossary('network')},
                        ), 
                    ], 
                    text_closed = "\N{GLOBE WITH MERIDIANS} ", 
                    text_open = "\N{GLOBE WITH MERIDIANS} ", 
                    background = "#3685B5", 
                    close_button_location = "right", 
                ),
                # widget.WidgetBox(
                #     widgets = [
                #         widget.Backlight(
                #             backlight_name = "intel_backlight",
                #             #    fmt="Brightness {}",
                #             fmt="{}",
                #             background= "#0471A6",
                #             foreground="#FFFFFF", 
                #             padding = 4, 
                #             mouse_callbacks = {"Button1" : lazy.spawn(f"{terminal} -e nvtop")}, 
                #             )
                #     ], 
                #     background = "#0471A6", 
                #     text_closed = "\N{GLOWING STAR}", 
                #     text_open = "\N{GLOWING STAR}", 
                #     close_button_location = "right", 
                #     start_opened = True, 
                # ), 
                widget.GenPollText(
                    func = get_mouse_sensitivity,
                    update_interval = 1,
                    background = "#0471A6",
                    foreground = "#FFFFFF",
                    padding = 6,
                    mouse_callbacks = {
                        "Button4": lazy.spawn(f"bash {_mouse_sens_script} up"),
                        "Button5": lazy.spawn(f"bash {_mouse_sens_script} down"),
                    },
                ),
                glossary_box('audio',
                    widgets = [
                        widget.GenPollText(
                            func = audio_output_status,
                            update_interval = 1,
                            markup = False,
                            mouse_callbacks={
                                "Button1": glossary('audio'),
                                "Button4": lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
                                "Button5": lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
                            },
                            background = "#0471A6", 
                            foreground = "#FFFFFF", 
                            padding = 0,
                        )
                    ], 
                    background = "#0471A6", 
                    text_closed = "\N{SPEAKER WITH THREE SOUND WAVES}", 
                    text_open = "\N{SPEAKER WITH THREE SOUND WAVES}", 
                    close_button_location = "right", 
                    start_opened = True, 
                ), 
                # widget.WidgetBox(
                #     widgets = [
                #         widget.Battery(
                #             background = "#0471A6", 
                #             foreground = "#FFFFFF",
                #             charge_char = "+", 
                #             discharge_char = "-", 
                #             empty_char = "",
                #             full_char = "", 
                #             # format = "{char}{percent:2.0%}",  
                #             format = "{char}{percent:2.0%} [{hour:d}:{min:02d} / {watt:.2f}W]", 
                #             padding = 3, 
                #             show_short_text = False, 
                #             update_interval = 1, 
                #         )
                #     ], 
                #     background = "#0471A6", 
                #     text_closed = "\N{BATTERY} ", 
                #     text_open = "\N{BATTERY} ", 
                #     close_button_location = "right", 
                #     start_opened = True, 
                # ),
                glossary_box('clock',
                    widgets = [
                        widget.Clock(
                            mouse_callbacks={"Button1": glossary('clock')},
                            background = "#061826", 
                            # background = colors["violet"], 
                            foreground = "#FFFFFF",
                            format="%m/%d/%Y - %H:%M:%S", 
                            padding = 5,  
                        )
                    ], 
                    background = "#061826", 
                    text_closed = "\N{CALENDAR} ", 
                    text_open = "\N{CALENDAR} ", 
                    close_button_location = "right", 
                    start_opened = True, 
                ),
                widget.Wallpaper(
                    mouse_callbacks={"Button1": glossary('wallpaper')},
                    background = "#000000", 
                    label = "\N{MOUNTAIN}",
                    directory = "~/Media/Pictures/wallpaper/"
                ), 
            ],
            24,
            # border_width=[2, 2, 2, 2],  # Draw top and bottom borders
            # border_color=["FFFFFF", "FFFFFF", "FFFFFF", "FFFFFF"], 
            background = "#222a38", 
            margin = [4, 4, 2, 4], 
            opacity = 1.0, 
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False 
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="sxiv"),
        Match(wm_class="nemo"),
        Match(wm_class="zoom"),
        Match(wm_class="matplotlib"), 
        Match(wm_class="feh"),
        Match(wm_class="thunderbird"),

    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
