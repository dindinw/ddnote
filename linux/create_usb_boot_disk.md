Reference
---------
https://wiki.archlinux.org/index.php/USB_flash_installation_media

### In MAC

```
$ diskutil list
```

```
$ diskutil unmountDisk /dev/disk2
$ sudo dd if=~/Downloads/archlinux-2016.02.01-dual.iso of=/dev/rdisk2 bs=4096
```

