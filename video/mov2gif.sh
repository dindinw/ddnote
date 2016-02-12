#!/usr/bin/env bash

mov2gif=./_mov2gif
scale=640
framerate=1
delay=50
convert_only=1;

USAGE="Usage : mov2gif.sh [parameters]
    Convert a QuickTime movie into an animation GIF
    The available parameters:
        -i <.mov file>       # The full path of the input file : QuickTime movie.
        -o <.gif file>       # The full path of the output file, the animation GIF.
        --scale=<scale>      # The size of photo, ex 320, 640, default is 640
        --framerate=<rate>   # the rate of frame, the higher the generate file is larger, default is 1
        --delay=<delay>      # the delay of every GIFs being shown, the value no effect to file size.
                             # the default is 50
        --convert_only       # if the flag set, try to re-create GIF by using last splited photoes.
"
function error(){
    echo "ERROR : $@"
    echo "$USAGE"
    exit 1
}

while (( "$#" )); do
    case $1 in
        -i)
            shift;
            input=$1;
            shift;;
        -o)
            shift;
            output=$1;
            shift;;
        --scale=*)
            scale=`echo $1|sed -e 's/--scale=//'`
            shift;;
        --framerate=*)
            framerate=`echo $1|sed -e 's/--framerate=//'`
            shift;;
        --delay=*)
            delay=`echo $1|sed -e 's/--delay=//'`
            shift;;
        --convert_only)
            shift;
            convert_only=0;
            shift;;
        *)
            error "unknown paramerter $1"
    esac
done

if [ -z ${input} ]; then error "input should not emplty"; fi;
if [ ! -e ${input} ]; then error "$input not found" ; fi;
if [ -z ${output} ]; then error "output should not emplty"; fi;

if [ ! ${convert_only} -eq 0 ]; then
    if [ -e ${mov2gif} ]; then
        rm -rf ${mov2gif};
        mkdir ${mov2gif};
    else
        mkdir ${mov2gif};
    fi
    ffmpeg -i ${input} -vf scale=${scale}:-1 -r ${framerate} ${mov2gif}/ffout%3d.png
else
    if [ ! -e ${mov2gif} ]; then
        error "$mov2gif not exist, can't --convert_only"
    fi
fi

convert -delay ${delay} -loop 0 ${mov2gif}/ffout*.png ${output}
