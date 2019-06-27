# crt-live-coding

[![In action](https://img.youtube.com/vi/_8ITuKIi_Is/maxresdefault.jpg)](https://www.youtube.com/watch?v=_8ITuKIi_Is)

## Description

This project it's an attempt to a nice looking music live coding environment based on a cool-retro-term fork.
It currently makes use of FoxDot, supercollider and vim, but any cli with a supercollider backend is theoretically supported.

Beware, you are dealing with a *very early* release so don't expect a plug and play experience!
    
## Build instructions (Linux)

Make sure FoxDot and supercollider (with sc3 plugins) are property installed.

```bash
# Get it from GitHub
git clone --recursive https://github.com/Swordfish90/crt-live-coding.git

cd crt-live-coding

qmake && make
```

## Run instructions

Open a terminal into the project root and type:

```bash

# Launch supercollider and the FoxDot server
sclang sc-foxdot-visual.scd & python3 foxdot-server.py

# This will launch crt-live-coding running vim with a custom vimrc file
./crt-live-coding -e vim -u vimrc

# Press enter (in normal mode) to play that line of foxdot code!
```

## How does it work

There are a few pieces here working together.

sc-foxdot-visual.scd launches FoxDot.start and analyzes the audio stream, extracting features needed for graphical effects. These are sent to crt-live-coding via OSC commands on port 7089.

foxdot-server.py runs a FoxDot server in the background and listens on port 7088 for FoxDot instructions.

crt-live-coding is running vim with a custom vimrc file. Every time you press enter (in normal mode) vim will send the current line to port 7088.

## Donations
I made this project in my spare time because I love what I'm doing. If you are enjoying it and you want to buy me a beer click [here](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=flscogna%40gmail%2ecom&lc=IT&item_name=Filippo%20Scognamiglio&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted).
