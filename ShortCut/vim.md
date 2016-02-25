VIM ShortCuts
=============

Vim Cheat Sheet
---------------
### Cursor movement
```
    h - move cursor left
    j - move cursor down
    k - move cursor up
    l - move cursor right
    w - jump forwards to the start of a word
    W - jump forwards to the start of a word (words can contain punctuation)
    e - jump forwards to the end of a word
    E - jump forwards to the end of a word (words can contain punctuation)
    b - jump backwards to the start of a word
    B - jump backwards to the start of a word (words can contain punctuation)
    0 - jump to the start of the line
    ^ - jump to the first non-blank character of the line
    $ - jump to the end of the line
    gg - go to the first line of the document
    G - go to the last line of the document
    5G - go to line 5
    fx - jump to next occurrence of character x
    tx - jump to before next occurrence of character x
    } - Jump to next paragraph (or function/block, when editing code)
    { - Jump to previous paragraph (or function/block, when editing code)
```

> Tip Prefix a cursor movement command with a number to repeat it. For example, 4j moves down 4 lines.

###  Insert mode - inserting/appending text
```
    i - insert before the cursor
    I - insert at the beginning of the line
    a - insert (append) after the cursor
    A - insert (append) at the end of the line
    o - append (open) a new line below the current line
    O - append (open) a new line above the current line
    ea - insert (append) at the end of the word
    Esc - exit insert mode
```

###  Editing

    r - replace a single character
    J - join line below to the current one
    cc - change (replace) entire line
    cw - change (replace) to the end of the word
    c$ - change (replace) to the end of the line
    s - delete character and substitute text
    S - delete line and substitute text (same as cc)
    xp - transpose two letters (delete and paste)
    u - undo
    Ctrl + r - redo
    . - repeat last command

### Marking text (visual mode)

    v - start visual mode, mark lines, then do a command (like y-yank)
    V - start linewise visual mode
    o - move to other end of marked area
    Ctrl + v - start visual block mode
    O - move to other corner of block
    aw - mark a word
    ab - a block with ()
    aB - a block with {}
    ib - inner block with ()
    iB - inner block with {}
    Esc - exit visual mode

#### Visual commands

    > - shift text right
    < - shift text left
    y - yank (copy) marked text
    d - delete marked text
    ~ - switch case

### Cut and paste

    yy - yank (copy) a line
    2yy - yank (copy) 2 lines
    yw - yank (copy) word
    y$ - yank (copy) to end of line
    p - put (paste) the clipboard after cursor
    P - put (paste) before cursor
    dd - delete (cut) a line
    2dd - delete (cut) 2 lines
    dw - delete (cut) word
    D - delete (cut) to the end of the line
    d$ - delete (cut) to the end of the line
    x - delete (cut) character

### Exiting

    :w - write (save) the file, but don't exit
    :wq or :x or ZZ - write (save) and quit
    :q - quit (fails if there are unsaved changes)
    :q! or ZQ - quit and throw away unsaved changes

### Search and replace

    /pattern - search for pattern
    ?pattern - search backward for pattern
    \vpattern - 'very magic' pattern: non-alphanumeric characters are interpreted as special regex symbols (no escaping needed)
    n - repeat search in same direction
    N - repeat search in opposite direction
    :%s/old/new/g - replace all old with new throughout file
    :%s/old/new/gc - replace all old with new throughout file with confirmations
    :noh - remove highlighting of search matches

### Working with multiple files

    :e filename - edit a file in a new buffer
    :bnext or :bn - go to the next buffer
    :bprev or :bp - go to the previous buffer
    :bd - delete a buffer (close a file)
    :sp filename - open a file in a new buffer and split window
    :vsp filename - open a file in a new buffer and vertically split window
    Ctrl + ws - split window
    Ctrl + ww - switch windows
    Ctrl + wq - quit a window
    Ctrl + wv - split window vertically
    Ctrl + wh - move cursor to the left window (vertical split)
    Ctrl + wl - move cursor to the right window (vertical split)
    Ctrl + wj - move cursor to the window below (horizontal split)
    Ctrl + wk - move cursor to the window above (horizontal split)

### Tabs

    :tabnew filename or :tabn filename - open a file in a new tab
    Ctrl + wT - move the current split window into its own tab
    gt or :tabnext or :tabn - move to the next tab
    gT or :tabprev or :tabp - move to the previous tab
    #gt - move to tab number #
    :tabmove # - move current tab to the #th position (indexed from 0)
    :tabclose or :tabc - close the current tab and all its windows
    :tabonly or :tabo - close all tabs except for the current one


```
count    normal mode command    motion *=takes count

n        c (change)             0 (first column)
         y (yank/copy)          ^ (first non-whitespace char)
         d (delete)             $ (last character)
         > (indent)             g_ (last non-whitespace char)
         < (outdent)            w (next beginning of word*)
         gq ("go quote")        W (next beginning of WORD*)
         g= (format)            e (next end of word*)
         gu (go lower)          E (next end of WORD*)
         gU (go upper)          b (previous beginning of word*)
         g~ (go case toggle)    B (previous beginning of WORD*)
         v (visual stream)      gg (line*, or start of buffer)
         V (visual line)        G (line*, or end of buffer)
         Ctrl+v (visual block)  j (down*)
                                k (up*)
                                h (left*)
                                l (right*)
                                } (next blank line*)
                                { (previous blank line*)
                                H (top of window (high))
                                M (middle of window)
                                L (bottom of window (low))
                                /foo (next foo*)
                                ?foo (previous foo*)
                                n (next match*)
                                N (previous match*)
                                fx (forward onto x*)
                                Fx (backward onto x*)
                                tx (to x*)
                                Tx (backward to x*)
                                ; (repeat t, T, f, or F*)
                                , (repeat t, T, f, or F, backwards*)
                                | (to column*)
                                * (to next word under cursor*)
                                # (to previous word under cursor*)
                                `x (to line/col of mark x)
                                'x (to line of mark x, first non-white)
                                ]] (next start of block*)
                                [[ (previous start of block*)
                                ][ (next end of block*)
                                [] (previous end of block*)
                                ]m (next start of method*)
                                [m (previous start of method*)
                                ]M (next end of method*)
                                [M (previous end of method*)
                                etc...
```

Column Edit Mode
----------------
1. `Ctrl` + `V` to go into column mode
2. Select the columns and rows where you want to enter your text
3. `Shift` + `I` to go into insert mode in column mode
4. Type in the text you want to enter. Dont be discouraged by the fact that only the first row is changed.
5. `Esc` to apply your change (or alternately Ctrl+c)

Cheat Sheet Collections
-----------------------

1. VIM Cheat Sheet for Programmers
> http://michael.peopleofhonoronly.com/vim/

2. Beautiful VIM Cheat Sheet
> http://vimcheatsheet.com/products/vim-cheat-sheet-digital  (paid)

3. Vi / Vim Graphical Cheat Sheet
> http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html (a gaphic tutorial included)

4. Vi-Linux-Terminal Help sheet 
> http://downloads.gosquared.com/help_sheets/10/VI%20Help%20Sheet%20outlined.pdf

5. Mobile Friendly VIM Cheat Sheet
> http://vim.rtorr.com/lang/zh_cn/  (chinese translation included)
> https://github.com/rtorr/vim-cheat-sheet  (github site)


REFERENCES
----------
* 5 Best VIM Cheat Sheet
> https://rumorscity.com/2014/08/16/5-best-vim-cheat-sheet/

* 阅读原文 (暂时使用外站链接，真实发布时候，可以建立Github页面来Host）
> https://github.com/rtorr/vim-cheat-sheet

