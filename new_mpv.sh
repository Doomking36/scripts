#!/bin/bash

echo "Enter URL or local video path:"
read input

#Function to check if the input is a URL
is_url() {
    case "$1" in
        http://*|https://*) return 0 ;;
        *) return 1 ;;
    esac
}

#Check if the input is a URL or a local file
if is_url "$input"; then
    # It's a URL, use it as is
    video_source="$input"
else
    # It's not a URL, check if it's a valid local file
    if [ -f "$input" ]; then
        video_source="$input"
    else
        echo "Error: File not found or invalid input."
        exit 1
    fi
fi

#Run mpv with the determined video source
mpv \
--profile=gpu-hq \
--scale=ewa_lanczossharp \
--cscale=ewa_lanczossharp \
--video-sync=display-resample \
--interpolation \
--tscale=oversample \
--hwdec=auto-safe \
--ao=pipewire \
--vo=gpu-next \
--input-ipc-server=/tmp/mpvsocket \
--ytdl-format="bestvideo[height<=?1080]+bestaudio/best" \
--cache=yes \
--cache-secs=300 \
--demuxer-max-bytes=500M \
--demuxer-max-back-bytes=100M \
--sub-auto=fuzzy \
--audio-pitch-correction=yes \
--volume-max=150 \
--save-position-on-quit \
--script-opts=ytdl_hook-ytdl_path=yt-dlp "$video_source"
