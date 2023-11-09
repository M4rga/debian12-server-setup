# Debian 12 server setup

This is a guide to **automatically** install a new Debian 12 server on your device or VM.
To do this we will use a `preseed.cfg` file to skip all the annoying setup.
> **Note**: this preseed file will also enable automatically ssh login to the server.

## Getting started

This directory contains a [`preseed.cfg`](preseed.cfg) file, download it and put in a folder all alone, please make sure to edit it as you wish, for example you can remove the `sed -Ei ...` line located at the bottom, because probably you don't need to change the OpenSSH server port.

In particular:

- `d-i debian-installer/language string ...`
- `d-i debian-installer/country string ...`
- `d-i keyboard-configuration/xkb-keymap select ...`
- `d-i netcfg/get_hostname string ...`
- `d-i netcfg/hostname string ...`
- `d-i partman-auto/disk string /dev/sda`
- `d-i pkgsel/include string python3`

> **Note**: if you don't undestand anything about the file you can simply ask [ChatGPT](https://chat.openai.com/).

Download a **Debian installation image** (e.g. `debian-12.0.0-amd64-netinst.iso`) from https://www.debian.org/, if you are using a **VM** create one and select the **iso**.

If you are using a **physical server**, flash the iso onto a **USB pendrive**. To do that you can use [Rufus](https://rufus.ie/en/), then insert the USB stick into the remote host, power it on and **boot from the pendrive**.

## Installation

In the Debian installation image boot screen, you can select `Advanced options` &rarr; `Automated install` from the menu and wait untill it asks you the location of the initial preconfiguration file to perform the OS setup using a **Debian Preseed** file.

Now in your control host, open cmd and type:

```cmd
ipconfig
```

and memorize your IPv4.

Now open the folder in [Git](https://git-scm.com/) with `right-click` &rarr; `Open Git Bash here` and type this:

```bash
python3 -m http.server -b '0.0.0.0'
```

> **Note**: If you dont get any output it means that it worked, else make sure you have [python3](https://www.python.org/) downloaded

Now on you remote host type:

```bash
http://(yourIPv4):8000/preseed.cfg
```

Wait till the computer shuts down