#!/bin/bash

set -e

sudo apt-get update
sudo apt-get install -y git tmux tree curl socat jq shellcheck python3 python3-pip python3-venv

# TODO: in the future, include script to disable IPv6 here
