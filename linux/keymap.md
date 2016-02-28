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


How re-mapping gnome-terminal shortcut keys 
-------------------------------------------

