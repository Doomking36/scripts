#!/bin/sh

echo File Name:
read output_name

video_size="1920x1080"
framerate="60"
input_display=":1.0"
input_audio="default"
#output_name="output"

ffmpeg -video_size $video_size -framerate $framerate -f x11grab -i $input_display -f pulse -ac 2 -i $input_audio -filter_complex "[1:a]pan=stereo|c0<c0+c1|c1<c0+c1[a]" -map 0:v -map "[a]" -c:v libx265 -preset ultrafast -tune zerolatency -crf 18 -c:a opus -strict experimental -shortest $output_name.mkv
