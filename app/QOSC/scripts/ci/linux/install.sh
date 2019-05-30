#!/bin/bash
set -ev

sudo add-apt-repository --yes ppa:ubuntu-sdk-team/ppa
sudo apt-get update -qq

sudo apt-get install qt5-default
sudo apt-get install qt5-qmake
sudo apt-get install qtbase5-dev-tools
