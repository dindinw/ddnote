
Mac animation GIF how to 
=========================

### Overview 

1. Screencast (QuickTime) -> .mov

2. .mov(ffmpeg) -> .png 

3. .png(imagemagick's convert) -> animation.gif

### Installation

```
$ brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-frei0r --with-libass --with-libvo-aacenc --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools
$ brew install imagemagick
```

### Usage

```
Usage : mov2gif.sh [parameters]
    Convert a QuickTime movie into an animation GIF
    The available parameters:
        -i <.mov file>       # The full path of the input file : QuickTime movie.
        -o <.gif file>       # The full path of the output file, the animation GIF.
        --scale=<scale>      # The size of photo, ex 320, 640, default is 640
        --framerate=<rate>   # the rate of frame, the higher the generate file is larger, default is 1
        --delay=<delay>      # the delay of every GIFs being shown, the value no effect to file size.
                             # the default is 50
        --convert_only       # if the flag set, try to re-create GIF by using last splited photoes.
```


### References

* http://ffmpeg.org/
* http://www.imagemagick.org/

### Many Thanks and Great Articles 

* https://gist.github.com/tskaggs/6394639
* https://gist.github.com/dergachev/4627207
* http://superuser.com/questions/556029/ffmpeg-converts-flv-video-to-gif-with-awful-quality
* http://www.atrixnet.com/animated-gifs/

