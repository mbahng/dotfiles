from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
import os

import subprocess
# from qtile_extras import widget 
# from qtile_extras.widget.decorations import PowerLineDecoration

mod = "mod4"
terminal = "kitty"
bring_front_click = True

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
    
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "w", lazy.spawn("whatsapp-for-linux"), desc="Launch whatsapp (w - whatsapp)"), 
    Key([mod], "e", lazy.spawn("nemo"), desc="Launch file manager nemo (e - nEmo)"), 
    Key([mod], "r", lazy.spawn("dotfiles/custom_scripts/wechat"), desc="Launch WeChat"), 
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "y", lazy.spawn("skypeforlinux"), desc="Launch skype (y - skYpe)"),  
    Key([mod], "u", lazy.spawn("zulip"), desc="Launch zulip (u - zUlip)"), 
    Key([mod], "i", lazy.spawn("bluebubbles"), desc="Launch iMessage (i - imessage)"),
    Key([mod], "o", lazy.spawn(""), desc=""),  
    Key([mod], "p", lazy.spawn(""), desc=""),

    
    Key([mod], "a", lazy.spawn("dotfiles/custom_scripts/vpn"), desc=""), 
    Key([mod], "s", lazy.spawn("slack"), desc="Launch slack (s - slack)"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch discord (d - Discord)"), 
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "g", lazy.spawn("google-chrome-stable"), desc="Launch chrome (g - google chrome)"),
    Key([mod], "h", lazy.spawn(""), desc=""),   
    Key([mod], "j", lazy.spawn(""), desc=""),  
    Key([mod], "k", lazy.spawn("dotfiles/custom_scripts/kakaotalk"), desc="Launch kakaotalk (aka kiwitalk). "), 
    Key([mod], "l", lazy.spawn(""), desc=""), 
   

    Key([mod], "z", lazy.spawn("zoom"), desc="Launch zoom (z - zoom)"), 
    Key([mod], "x", lazy.spawn("virtualbox"), desc="Launch VirtualBox (x - boX)"),
    Key([mod], "c", lazy.spawn("caprine"), desc="Launch caprine (c - caprine)"), 
    Key([mod], "v", lazy.spawn("code"), desc="Launch vscode (v - vscode)"), 
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch firefox (b - browser)"),
    Key([mod], "n", lazy.spawn("inkscape"), desc="Launch iNkscape"),   
    Key([mod], "m", lazy.spawn("kitty -e ncmpcpp"), desc="Launch spotify (m - music)"), 
    
    Key([mod, "shift"], "n", lazy.spawn("screenkey"), desc="Launch screenkey (sk - ScreenKey)"),
    Key([mod, "shift"], "m", lazy.spawn("obs"), desc="Launch obs screen & audio recorder"), 

    # Extra utilities
    # actual print screen key is "Print" 
    Key([], "F10", lazy.spawn("flameshot gui"), desc="Print Screen Selection"), 
    Key(["shift"], "F10", lazy.spawn("flameshot screen"), desc="Print current screen"), 
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Print Screen Selection"), 
    Key(["shift"], "Print", lazy.spawn("flameshot screen"), desc="Print current screen"), 
    
    # Adjust screen brightness keys 
    Key([], "F6", lazy.spawn("brightnessctl --device=intel_backlight set 20-"), desc="Increase brightness -20/400"), 
    Key([], "F7", lazy.spawn("brightnessctl --device=intel_backlight set 20+"), desc="Increase brightness +20/400"), 

    # Adjust keyboard brightness keys 
    Key([], "F5", lazy.spawn("brightnessctl --device=dell::kbd_backlight set 1+"), desc="Increase keyboard backlight by 1"), 
    Key(["control"], "F5", lazy.spawn("brightnessctl --device=dell::kbd_backlight set 1-"), desc="Decrease keyboard backlight by 1"), 
    
    # Volume Adjustment
    Key([], "F1", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle mute/unmute volume"), 
    Key([], "F2", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease volume by 5%"), 
    Key([], "F3", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase volume by 5%"), 



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

def news_parser(dct): 
    dct = dct["results"]
    headers = [x["title"] for x in dct][1:]
    return "          ".join(headers)


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
                widget.StockTicker(
                    apikey="S8TMOKO9BYQ38JXO", 
                    symbol="SPY", 
                    update_interval = 3600, 
                    padding = 2, 
                ), 
                widget.TextBox("/"), 
                widget.CryptoTicker(
                    crypto="ETH", 
                    padding = 2, 
                    update_interval = 600, 
                ), 
                widget.Sep(), 
                widget.GenPollUrl(
                    foreground='#ffffff',
                    scroll = True, 
                    scroll_delay = 5, 
                    width = 560, 
                    update_interval=1800,
                    fmt = "{}",
                    url = "https://api.nytimes.com/svc/topstories/v2/world.json?api-key=dkGrnGNxfmyBquMO2jANZqceWxQyh8Q0", 
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
                 
                widget.Systray(     # needed for app icons
                    background = colors["red"], 
                    padding = 8, 
                ),
                widget.WidgetBox(
                    widgets = [
                        widget.CheckUpdates(
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
                widget.WidgetBox(
                    widgets = [
                        widget.CPU(
                            background = "#AC80A0", 
                            foreground = "#000000", 
                            format = "CPU: {freq_current} GHz ({load_percent}%)",
                            mouse_callbacks = {"Button1" : lazy.spawn("alacritty -e htop")},
                            padding = 5, 
                        ), 
                        widget.NvidiaSensors(
                            background = "#AC80A0", 
                            foreground = "#000000", 
                            format = "GPU: {temp} C {perf}",
                            mouse_callbacks = {"Button1" : lazy.spawn("alacritty -e nvtop")}, 
                            padding = 5
                        )
                    ], 
                    background = "#AC80A0", 
                    text_closed = "\N{PERSONAL COMPUTER} ", 
                    text_open = "\N{PERSONAL COMPUTER} ", 
                    padding = 2, 
                    close_button_location = "right", 
                ),
                widget.WidgetBox(
                    widgets = [
                        widget.Memory(
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
                widget.WidgetBox(
                    widgets = [
                        widget.DF(
                            background = "#89AAE6", 
                            foreground = "#000000",
                            warn_color = "#000000",
                            measure = "G",
                            mouse_callbacks = {"Button1" : lazy.spawn(f"{terminal} -e 'du -shc .[^.]* ~/*'")}, 
                            format = "{uf}/{s}{m}B Free", 
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
                widget.WidgetBox(
                    widgets = [
                        widget.Bluetooth(
                            background = "#00ff00", 
                            foreground = "#000000", 
                            padding = 4, 
                        ),
                        widget.Net(
                            background = "#3685B5", 
                            foreground = "#000000", 
                            format = "{interface} {down:6.2f}{down_suffix:<2}↓↑{up:6.2f}{up_suffix:<2}", 
                            padding = 4, 
                        ), 
                        widget.Wlan(
                            background = "#3685B5", 
                            foreground = "#000000",
                            format = "{essid} {percent:2.0%}", 
                            padding = 4, 
                            mouse_callbacks = {"Button3" : lazy.spawn("nm-connection-editor"), 
                                            "Button1" : lazy.spawn("alacritty -e 'nmtui'")}, 
                        )
                    ], 
                    text_closed = "\N{GLOBE WITH MERIDIANS} ", 
                    text_open = "\N{GLOBE WITH MERIDIANS} ", 
                    background = "#3685B5", 
                    close_button_location = "right", 
                ),
                widget.WidgetBox(
                    widgets = [
                        widget.Backlight(
                            backlight_name = "intel_backlight",
                            #    fmt="Brightness {}",
                            fmt="{}",
                            background= "#0471A6",
                            foreground="#FFFFFF", 
                            padding = 4, 
                            mouse_callbacks = {"Button1" : lazy.spawn("alacritty -e 'nvtop'")}, 
                            )
                    ], 
                    background = "#0471A6", 
                    text_closed = "\N{GLOWING STAR}", 
                    text_open = "\N{GLOWING STAR}", 
                    close_button_location = "right", 
                    start_opened = True, 
                ), 
                widget.WidgetBox(
                    widgets = [
                        widget.Volume(
                            background = "#0471A6", 
                            foreground = "#FFFFFF", 
                            # fmt = "Volume {}", 
                            fmt = "{}",
                            get_volume_command = "pactl get-sink-volume @DEFAULT_SINK@", 
                            volume_down_command = "pactl set-sink-volume @DEFAULT_SINK@ -5%", 
                            volume_up_command = "pactl set-sink-volume @DEFAULT_SINK@ +5%", 
                            padding = 0,
                            emoji = False, 
                        )
                    ], 
                    background = "#0471A6", 
                    text_closed = "\N{SPEAKER WITH THREE SOUND WAVES}", 
                    text_open = "\N{SPEAKER WITH THREE SOUND WAVES}", 
                    close_button_location = "right", 
                    start_opened = True, 
                ), 
                widget.WidgetBox(
                    widgets = [
                        widget.Battery(
                            background = "#0471A6", 
                            foreground = "#FFFFFF",
                            charge_char = "+", 
                            discharge_char = "-", 
                            empty_char = "",
                            full_char = "", 
                            # format = "{char}{percent:2.0%}",  
                            format = "{char}{percent:2.0%} [{hour:d}:{min:02d} / {watt:.2f}W]", 
                            padding = 3, 
                            show_short_text = False, 
                            update_interval = 1, 
                        )
                    ], 
                    background = "#0471A6", 
                    text_closed = "\N{BATTERY} ", 
                    text_open = "\N{BATTERY} ", 
                    close_button_location = "right", 
                    start_opened = True, 
                ),
                widget.WidgetBox(
                    widgets = [
                        widget.Clock(
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
