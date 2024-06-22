#!/bin/bash

# Check if the input argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <url-or-file>"
  exit 1
fi

# Define the mpv options for high-quality playback
MPV_OPTS="\
  --hwdec=auto \
  --vo=gpu \
  --profile=high-quality \
  --scale=ewa_lanczos \
  --cscale=ewa_lanczos \
  --tscale=mitchell \
  --interpolation \
  --video-sync=display-resample \
  --audio-file-auto=fuzzy \
  --deband=yes \
  --hdr-compute-peak=yes \
  --vf=format=yuv420p,scale=1920:1080,subtitles \
  --cache=yes \
  --cache-secs=10 \
  --cache-pause=yes \
  --demuxer-max-bytes=50M \
  --demuxer-max-back-bytes=25M \
  --framedrop=decoder+vo \
  --video-aspect-override=16:9 \
  --af=lavfi=[loudnorm] \
  --autofit-larger=100%x100% \
  --autofit-smaller=50%x50% \
  --border=no \
  --geometry=50%:50% \
  --fullscreen=no \
  --osc=no \
  --really-quiet \
  --save-position-on-quit \
  --script-opts=osc-visibility=always,osc-hidetimeout=1000 \
  --sub-auto=fuzzy \
  --sub-font-size=55 \
  --sub-color='#FFFFFF' \
  --sub-border-color='#000000' \
  --sub-border-size=3 \
  --sub-shadow-offset=2 \
  --sub-shadow-color='#000000' \
"

# Play the video
mpv $MPV_OPTS "$1"
