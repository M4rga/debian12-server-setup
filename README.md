# Debian 12 server setup

This is a guide to **automatically** install a new Debian 12 server on your device or VM.
To do this we will use a `preseed.cfg` file to skip all the annoying setup.
> **Note**: this preseed file will also enable automatically ssh login to the server.

## Getting started

This directory contains a [`preseed.cfg`](preseed.cfg) file, download it and put in a folder, please make sure to edit it as you wish, for example if you change the **username** make sure to edit it in the last lines of the file.

In particular:

- `echo "(YOUR PUBLIC SSH KEY)" >> ~mainuser/.ssh/authorized_keys`
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

When its done the computer server will shut down, if needed, turn on the device again and change the main user's password immediately (you can use the passwd command).

At this point you can press **CTRL+C** on the **Git Bash** to close the http server.

You can access the server remotely using: 

```cmd
ssh -p(port) (user)@(ip)
```
e.g. ssh -p2222 mainuser@localhost

## Provisioning

This directory contains a [`provisioning`](provisioning/main.sh) file witch contains a lot of different codes that i suggest you to run when setting up a new server, for example install basic things like tree, curl, shellcheck, python...

> **Note**: if you don't undestand anything about the file you can simply ask [ChatGPT](https://chat.openai.com/).

To run the script you need to open this folder in **Git bash** with `right-click` &rarr; `Open Git Bash here` and type this:

```bash
ssh -p(port) (user)@(ip) 'bash -s' < provisioning.sh
```
e.g. ssh -p2222 mainuser@localhost 'bash -s' < provisioning.sh
