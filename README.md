# Debian 12 server setup

This is a guide to **automatically** install a new Debian 12 server on your device or VM.
To do this we will use a `preseed.cfg` file to skip all the annoying setup.

> **Note**: this preseed file will also enable automatic SSH login to the server.

## Getting started

This directory contains a [`preseed.cfg`](preseed.cfg) file: download it and put it in a folder. Please make sure to edit it as you wish, for example if you change the **username** make sure to edit it in the last lines of the file.

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

Download a **Debian installation image** (e.g. `debian-12.0.0-amd64-netinst.iso`) from https://www.debian.org/. If you are using a **VM**, create one and select the **ISO**.

If you are using a **physical server**, flash the ISO onto a **USB pendrive**. To do that, you can use [Rufus](https://rufus.ie/en/), then insert the USB stick into the remote host, power it on and **boot from the pendrive**.

## Installation

In the Debian installation image boot screen, you can select `Advanced options` &rarr; `Automated install` from the menu and wait until it asks you the location of the initial preconfiguration file to perform the OS setup using a **Debian Preseed** file.

Now in your control host, open cmd and type:

```cmd
ipconfig
```

and memorize your IPv4.

Now open the folder in [Git](https://git-scm.com/) with `right-click` &rarr; `Open Git Bash here` and type this:

```bash
python3 -m http.server -b '0.0.0.0'
```

> **Note**: If you don't get any output, it means that it worked. Otherwise, make sure you have [python3](https://www.python.org/) installed.

Now, on your remote host type:

```
http://(yourIPv4):8000/preseed.cfg
```

When it's done, the computer server will shut down. If needed, turn on the device again and change the main user's password immediately (you can use the `passwd` command).

At this point, you can press **CTRL+C** on the **Git Bash** to close the HTTP server.

You can access the server remotely using:

```cmd
ssh -p(port) (user)@(ip)
```

e.g. `ssh -p2222 mainuser@localhost`

## Provisioning

This directory contains a [`provisioning`](provisioning/main.sh) file, which contains some setup that I suggest you to run when setting up a new server. For example, install basic packages like `tree`, `curl`, `shellcheck`, `python3`...

> **Note**: if you don't undestand anything about the file you can simply ask [ChatGPT](https://chat.openai.com/).

To run the script, you need to open this folder in **Git Bash** with `right-click` &rarr; `Open Git Bash here` and type this:

```bash
ssh -p(port) (user)@(ip) 'bash -s' < provisioning.sh
```

e.g. `ssh -p2222 mainuser@localhost 'bash -s' < provisioning.sh`

Inspired by https://github.com/dmotte/misc
