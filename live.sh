#! /bin/bash
#
# YouTube streaming with FFmpeg

VBR="2500k"                                    # Output video bitrate
FPS="30"                                       # Output video FPS
QUAL="medium"                                  # FFmpeg quality preset
# YouTube RTMP base URL

SOURCE="20230813_201849.mp4"                   # UDP source (see SAP announcements)
KEY="557bc9a78c34c519f18688ac59b523a7"                 # Key to retrieve from YouTube event
CUSTOM_RTMP_URL="rtmp://rtmp-in.rooter.io:443/show"

ffmpeg \
    -stream_loop -1 -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$CUSTOM_RTMP_URL/$KEY"
    
