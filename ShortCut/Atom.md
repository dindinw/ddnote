## Let Atom work with my favor.

### Vim Mode
Install `vim-mode` package, (`ctrl-,` to open settings-view )
**Issues**
* `:w` not working, need to install `ex-mode` plugin
* `ctl-w` is slow, because `vim-mode`, use `ctl-w q` override it.

### open external terminal
Install [atom-terminal](https://atom.io/packages/atom-terminal)
use `git-bash` in windows override windows cmd
```
"atom-terminal":
    app: 'C:\\git-sdk-64\\git-bash.exe'
    args: ''
```
### Key Remapping
Atom has a very nice feature, you can copy and paste the default and modify one by one. It's cool!
Edit your `keymap.cson` (`File->open Your Keymap`)

notice!!, you need to use }, instead of shift+], `ctrl+.` is always your friend for debugging tc
 add short-cut setting view
 https://github.com/atom/settings-view/blob/master/menus/settings-view.cson
```
'body':
  'alt-}': 'pane:show-next-item'
  'alt-{': 'pane:show-previous-item'
  'alt-w': 'core:close'
  'alt-i': 'settings-view:install-packages-and-themes'
  'alt-k': 'settings-view:show-keybindings'
  'alt-shift-k': 'application:open-your-keymap'

# orrdide `alt-\` to toggle tree view, mock cmd-1, in the Mac Idea
'.platform-win32, .platform-linux':
  'alt-1': 'tree-view:toggle-focus'

# override `ctrl-t` to toggle find any file, mock `cmd-shift-o` in Idea
'.platform-win32':
  'alt-shift-o': 'fuzzy-finder:toggle-file-finder'
```
