# Debian 12 server setup

This is a guide to **automatically** install a new Debian 12 server on your device or VM.
To do this we will use a preseed.cfg file to skip all the annoying setup.
> **Note**: this preseed file will also enable automatically ssh login to the server.

## Getting started

This directory contains a [`preseed.cfg`](preseed.cfg) file, please make sure to edit it as you wish, for example you can remove the `sed -Ei ...` line located at the bottom, because probably you don't need to change the OpenSSH server port.

In particular:

- `d-i debian-installer/language string ...`
- `d-i debian-installer/country string ...`
- `d-i keyboard-configuration/xkb-keymap select ...`
- `d-i netcfg/get_hostname string ...`
- `d-i netcfg/hostname string ...`
- `d-i partman-auto/disk string /dev/sda`
- `d-i pkgsel/include string python3`

> **Note**: if you don't undestand anything abount the file you can simply ask [ChatGPT](https://chat.openai.com/).



