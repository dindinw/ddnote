Keyboard ShortCuts for Mac Os
=============================

Mac Icons
---------
 ⌃⌥⇧⌘
 ⎋⏏⌫↑⇡↖⇞⇥

`⇧` => `SHIFT`

`⌃` => `CONTROL`

`⌥` => `ALT` or `OPTION`

`⌘` => `COMMAND`

Go to spotlight 
---------------
 `⌃SPACE` 

Copy and Move
-------------
`⌘C`,  `⌥⌘V`,  

ScreenShoot
------------
* `⌘⇧3` Command-Shift-3. whole screen
* `⌘⇧4` Command-Shift-4. part of screen

Zoom
----
* `⌘⌥8` Command-Option-8	Turn zoom on or off.
* `⌘⌥+` Command–Option–Plus Sign (+)	Zoom in.
* `⌘⌥-` Command–Option–Minus Sign (-)	Zoom out.
> You might need to turn on the feature at `System Pereference/Accessibility`

Press And Hold
--------------
If you use VIM, press and hold h/j/k/l to move.   

`/System/Library/Input Methods/PressAndHold.app`

```
defaults write -g ApplePressAndHoldEnabled -bool false
```

```
defaults write -g ApplePressAndHoldEnabled -bool true
```

```
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
```

see (https://gist.github.com/kconragan/2510186) 

OS X El Capitan disable System Integrity Protection
----------------------------------------------------
1. Boot into the Recovery HD by restarting whilst holding ⌘R.
2. Open Terminal (from the Utilities menu).
3. Run the following command in Terminal:
```
csrutil disable
```
4. Restart.


References
----------
* http://meta.apple.stackexchange.com/questions/193/keyboard-icons-terminology
* http://meta.apple.stackexchange.com/questions/683/put-the-%E2%86%91-characters-somewhere-for-people-to-copy-paste?lq=1
* https://pqrs.org/osx/karabiner/xml.html.en
* How to take a screenshot on your Mac (https://support.apple.com/en-us/HT201361)
* Mac keyboard shortcuts for accessibility features (https://support.apple.com/en-us/HT204434)
