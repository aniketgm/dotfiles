# Table of Contents

- [Dotfile Managment](#dotfile-managment)
  - [Overview](#overview)
  - [Setup start](#setup-start)
  - [Script actions](#script-actions)

## Dotfile Managment

### Overview

For managing the dotfiles I'm using the [Rotz](https://github.com/volllly/rotz) tool.

Best part of Rotz is it can be used on any system (Linux/Mac and even Windows as well).
Another thing is that you can not only configure but also install softwares using Rotz.
One just has to maintain config files for it. Supports yaml, toml and json formats for config files.
I work on Windows and Linux (mostly Ubuntu), so I have created two script files, _setup.ps1_ for Windows and _setup_ for Linux.

Below is the setup for Windows and Linux

### For Windows:

```sh
# NOTE: All below commands are run in Powershell

# Install Git
winget install --id Git.Git --exact --source winget
# OR one can use scoop, however, I recommend installing from either winget / using official Git executable.

# Install Rotz (highly recommended to use Powershell):
Invoke-RestMethod volllly.github.io/rotz/install.ps1 | Invoke-Expression

# Restart the system just so that Git and Rotz are installed properly.
# Once restarted, clone the repo using Rotz.
# It is highly recommended to clone it in home folder.
cd ~
rotz clone https://gitlab.com/aniketgm/dotfiles.git

# This will clone the dotfiles repo into the home directory as ~/.dotfiles
# After this, either run the setup.ps1 file OR manually run 'rotz' for each packages.
# For running the script, open powershell as admin and do this:
cd ~/.dotfiles
.\setup.ps1
```

- Notes: The _setup.ps1_ file when run performs the following operations:
  - First install essential packages/softwares:
    - [x] Microsoft VCRedist 2015-2022 (required for various Win apps to run)
    - [x] PowerShell 7 (Latest PowerShell with cool features)
  - Then install other softwares:
    - [x] Scoop (CLI installer for Windows)
    - [x] Windows Terminal (Terminal tool provided by Microsoft)
    - [x] LazyGit (Git management tool)
    - [x] LazyVim (NeoVim distribution, IDE for development)
    - [x] Using scoop install further packages like 7zip, fzf, ripgrep, wezterm, etc..
  - Finally, Link configurations to their respective locations.
    - These will be symlinks. Check out the [config.yaml](https://gitlab.com/aniketgm/dotfiles/-/blob/main/config.yaml) under the rotz folder
  - Other misc tools of interest (not covered in the setup)
    - Taskwarrior, there are two options to install this: WSL Or Msys2
      - For Msys2, install it from [official](https://www.msys2.org) site and then `pacman -Syu task` from inside Msys2 prompt
      - For WSL, again install from [official](https://learn.microsoft.com/en-us/windows/wsl/install) site, with latest Ubuntu, and then `sudo apt install taskwarrior` from inside WSL
----

### For Linux new system setup (assuming Ubuntu):

```sh
# Install Git required for rotz
sudo apt install git unzip dos2unix

# Install rotz
curl -fsSL volllly.github.io/rotz/install.sh | sh
echo "export ROTZ_INSTALL='/home/$USER/.rotz'" >> ~/.bashrc
echo 'export PATH="$ROTZ_INSTALL/bin:$PATH"' >> ~/.bashrc

# Source bashrc to enable rotz
source ~/.bashrc

# Clone dotfiles using rotz. This will clone as ~/.dotfiles
cd ~
rotz clone https://gitlab.com/aniketgm/dotfiles.git

# Now install rest of the packages
cd ~/.dotfiles    # Assuming you cloned the dotfiles in the $HOME directory
chmod +x ./setup  # Set execute permissions if not set.
./setup
```

- Notes: The setup file when run performs the following operations:
  - First install essential packages/softwares:
    - [x] build-essentials, clangd, curl, ctags, etc.
  - Then install other softwares:
    - [x] LazyGit (Git management tool)
    - [x] LazyVim (NeoVim distribution, IDE for development)
    - [x] Other tools like fzf, ripgrep, wezterm, etc..
  - Finally, Link configurations to their respective locations.
    - These will be symlinks. Check out the [config.yaml](https://gitlab.com/aniketgm/dotfiles/-/blob/main/config.yaml) under the rotz folder
