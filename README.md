# netscreen

Use a secondary laptop as a second screen for your primary PC or laptop (like deskscreen but using ffmpeg+ssh+screen+mpv)

## Requirements

### Primary PC or Laptop

Available options:

* Linux (tested on Ubuntu MATE 20.04):

    1. Bash
    2. VKMS (for virtual display)
    3. OpenSSH client
    4. FFmpeg

* Windows (tested on Windows 10):

    1. Powershell Core
    2. Amyuni usbmmidd_v2 (for virtual display)
    3. OpenSSH client
    4. FFmpeg

### Secondary Laptop

Linux (tested on Alpine 3.15):

1. OpenSSH server
2. Screen
3. MPV

## Usage

Run from the primary PC or laptop:

* Linux

    ```bash
    $ netscreen.sh root@192.168.5.5   # Connect to secondary laptop via SSH
    ```

* Windows

    ```pwsh
    C:\> netscreen.ps1 192.168.5.5  # Connect to secondary laptop via SSH
    ```

## How It Works

1. Connect to secondary laptop via SSH and start MPV listening to UDP port 55555
2. Grab virtual screen in primary PC or laptop as video using FFmpeg and send it to MPV running in secondary laptop via UDP port 55555