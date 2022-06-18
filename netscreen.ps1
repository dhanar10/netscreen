Param (
	[string]$IpAddress
)

#$IpAddress = Read-Host -Prompt 'IP Address'

ssh root@$IpAddress "killall -q mpv; screen -dmfa -S mpv mpv -vo=gpu --profile=low-latency --untimed udp://${IpAddress}:55555"

Start-Job -ScriptBlock {
  $WShell = New-Object -Com "Wscript.Shell"
  while (1) { $WShell.SendKeys("{SCROLLLOCK}"); Start-Sleep 60 }
}

while (1) {
  Start-Sleep 2

  ffmpeg -f gdigrab -framerate 60 -offset_x -1360 -video_size 1360x768 -show_region 0 -i desktop `
    -c:v h264_amf -b:v 5M -usage 1 -profile:v 256 `
    -fflags flush_packets -f mpegts udp://${IpAddress}:55555

  # ffmpeg -f gdigrab -framerate 60 -offset_x -1360 -video_size 1360x768 -show_region 0 -i desktop `
  #    -c:v h264_nvenc -preset:v p1 -tune ull -zerolatency 1 -profile:v 1 -cbr 1 -b:v 5M -pix_fmt yuv420p `
  #    -fflags flush_packets -f mpegts udp://${IpAddress}:55555

  #ffmpeg -f gdigrab -framerate 30 -offset_x -1360 -video_size 1360x768 -show_region 0 -i desktop `
  #    -c:v libx264 -preset:v ultrafast -tune zerolatency -b:v 5M `
  #    -fflags flush_packets -f mpegts udp://${IpAddress}:55555
}
