#!/bin/bash

echo url:
read input

mpv --hwdec=auto --vo=gpu --profile=high-quality --scale=ewa_lanczos --cscale=ewa_lanczos --tscale=mitchell --interpolation --video-sync=display-resample --audio-file-auto=fuzzy $input

