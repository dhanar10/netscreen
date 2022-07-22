IP_ADDRESS=192.168.5.5

ssh root@${IP_ADDRESS} "killall -q mpv; sleep 1; screen -dmfa -S mpv mpv -vo=gpu --profile=low-latency --untimed udp://${IP_ADDRESS}:55555"

while true; do
    sleep 2

    # Capture frame rate need to be less than virtual screen framerate to maintain sync
    
    CAPTURE_OPTS="-video_size 1360x768 -framerate 45 -f x11grab -i :0.0+0,0"
    
    #VCODEC_OPTS="-c:v libx264 -preset:v ultrafast -tune zerolatency -b:v 20M -pix_fmt yuv420p"
    #VCODEC_OPTS="-vaapi_device /dev/dri/renderD129 -vf format=nv12,hwupload -c:v hevc_vaapi"
    #VCODEC_OPTS="-vaapi_device /dev/dri/renderD129 -vf format=nv12,hwupload -c:v h264_vaapi"
    #VCODEC_OPTS="-c:v hevc_nvenc -preset:v llhp -rc cbr_ld_hq -cbr 1 -zerolatency 1"
    VCODEC_OPTS="-c:v h264_nvenc -preset:v llhp -rc cbr_ld_hq -cbr 1 -zerolatency 1"

    ffmpeg ${CAPTURE_OPTS} ${VCODEC_OPTS} -fflags flush_packets -f mpegts udp://${IP_ADDRESS}:55555
done
