#! /bin/bash
#
# YouTube streaming with FFmpeg

VBR="2500k"                                    # Output video bitrate
FPS="30"                                       # Output video FPS
QUAL="medium"                                  # FFmpeg quality preset
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # YouTube RTMP base URL

SOURCE="20230813_201849.mp4"                   # UDP source (see SAP announcements)
KEY="zkae-3zte-ee9s-yv6r-942w"                 # Key to retrieve from YouTube event

ffmpeg \
    -stream_loop -1 -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$YOUTUBE_URL/$KEY"
    
