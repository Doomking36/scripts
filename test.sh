#!/bin/bash

# Check if mpv is installed
if ! command -v mpv &> /dev/null; then
    echo "mpv could not be found. Please install mpv and try again."
    exit 1
fi

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp could not be found. Please install yt-dlp and try again."
    exit 1
fi

# Prompt the user for a URL or video file path
echo "Enter URL or Video File Path:"
read input

# Check if input is provided
if [ -z "$input" ]; then
    echo "No input provided. Exiting."
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

# Check if the input is a URL or a file path
if [[ "$input" =~ ^https?:// ]]; then
  # Input is a URL, directly pass it to mpv
  mpv $MPV_OPTS "$input"
else
  # Input is a file path
  if [ -f "$input" ]; then
    mpv $MPV_OPTS "$input"
  else
    echo "File not found: $input"
    exit 1
  fi
fi
