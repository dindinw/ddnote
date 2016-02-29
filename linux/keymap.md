Swapping the left Alt and Ctrl keys
-----------------------------------

```
$ xmodmap -pk
```

```
$ xmodmap -pm
```

```
$ xev
```

`Alt_L`  --> keycode 64

```
KeyRelease event, serial 37, synthetic NO, window 0x3000001,
    root 0x83, subw 0x0, time 9067433, (646,311), root:(647,396),
    state 0x8, keycode 64 (keysym 0xffe9, Alt_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False
```
`Ctrl_L`  --> keycode 37
```
KeyRelease event, serial 37, synthetic NO, window 0x1000001,
    root 0x83, subw 0x0, time 9249758, (451,271), root:(452,356),
    state 0x4, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False
```
now create a file `~/.Xmodmap` and add following lines

```
clear control
clear mod1
keycode 37 = Alt_L Meta_L
keycode 64 = Control_L
add control = Control_L Control_R
add mod1 = Alt_L Meta_L
```

```
$ xmodmap ~/.Xmodmap
```

you can add the above line to your `~/.xinitrc`

https://earthviaradio.wordpress.com/2012/02/06/swapping-the-left-alt-and-ctrl-keys-in-ubuntu-11-10/


***Note For Windows* : How to Switch Alt_L and Ctrl_L and use Ctrl-Tabl using AutoHotKey**

load a script like this

```
; --------------------------------------------------------------------
; Switches the left Control and Alt keys but Ctrl-Tab works as Alt-Tab
; --------------------------------------------------------------------
*tab::
{
if(GetKeyState("LAlt", "P")){
    Send {LControl up}{Alt down}{tab}
    KeyWait, tab
} else if(GetKeyState("LShift", "P")){
    Send {LShift down}{tab}
    KeyWait, tab
}else
{   send {tab}
}
return
}
~LAlt Up::
{   send {lalt up}
return
}
LCtrl::LAlt
LAlt::LCtrl
```

Switch Windows by using CTL-TAB
-------------------------------
Ubuntu windows manager use `Alt-TAB` to switch windows by default.
I want to change to `CTL-TAB`, for mocking the MacOSX's `CMD+TAB`

```
/usr/share/gnome-control-center/keybindings
```
```
$ gsettings get org.gnome.desktop.wm.keybindings switch-applications
['<Super>Tab', '<Alt>Tab']
$ gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab', '<Ctrl>Tab']" 
$ gsettings get org.gnome.desktop.wm.keybindings switch-applications
['<Super>Tab', '<Ctrl>Tab']
```
You can also install a GUI tool for convenience 

```
$ sudo apt-get install dconf-editor
```
https://wiki.ubuntu.com/Keybindings
http://askubuntu.com/questions/573535/setting-special-keys-as-keyboard-shortcuts


Re-mapping gnome-terminal shortcut keys for tab nav
---------------------------------------------------

default : `CTL+PageUp/PageDown` `CTL+SHIFT+PageUp/PageDown`

-->     : `CTL+SHIFT+]/[`  tab nav

```
gconftool-2 --set /apps/gnome-terminal/profiles/Default/default_size_columns \
            --type=int 125
gconftool-2 --set /apps/gnome-terminal/profiles/Default/default_size_rows \
            --type=int 38
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_custom_default_size \
            --type=bool true
gconftool-2 --set /apps/gnome-terminal/keybindings/close_tab --type=string "<Ctrl>w"
```

```
$ gconftool-2 --get  /apps/gnome-terminal/keybindings/new_tab
<Ctrl><Shift>t
$ gconftool-2 --set /apps/gnome-terminal/keybindings/new_tab --type=string "<Ctrl>t"
```

```
$ gconftool-2 --get  /apps/gnome-terminal/keybindings/next_tab
<Control>Page_Down
alex@ubuntu-box:~
$ gconftool-2 --get  /apps/gnome-terminal/keybindings/prev_tab
<Control>Page_Up
```
Set to `Ctrl>+[` and `Ctrl+[` 

```
$ gconftool-2 --set /apps/gnome-terminal/keybindings/next_tab --type=string "<Ctrl>bracketright"
$ gconftool-2 --set /apps/gnome-terminal/keybindings/prev_tab --type=string "<Ctrl>bracketleft"
```

Set to `Ctrl+Shift+]` and `Ctrl+Shift+[`

```
$ gconftool-2 --set /apps/gnome-terminal/keybindings/next_tab --type=string "<Ctrl><Shift>braceright"
$ gconftool-2 --set /apps/gnome-terminal/keybindings/prev_tab --type=string "<Ctrl><Shift>braceleft"
```

Close window set to `Ctrl+Q`

```
$ gconftool-2 --set /apps/gnome-terminal/keybindings/close_window --type=string "<Ctrl>Q"
```


Re-mapping firefox shortcut keys for tab nav

--------------------------------------------
default : `CTL+Tab` `CTL+PageUp/PageDown`

-->     : `CTL+SHIFT+]/[' tab nav
