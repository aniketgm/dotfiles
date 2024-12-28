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

### For Windows:

1. Install Git

```sh
winget install --id Git.Git --exact --source winget
```

2. Install Rotz (highly recommended to use Powershell):

```sh
Invoke-RestMethod volllly.github.io/rotz/install.ps1 | Invoke-Expression
```

3. Then restart the system just so that Git and Rotz are installed properly.

- Meaning the all links after installation are in place OR registry entries updated OR env variables synced up, etc..)

4. Once restarted, clone the repo using Rotz.

```sh
cd ~
rotz clone https://gitlab.com/aniketgm/dotfiles.git
```

- This will clone the _dotfiles_ repo into the home directory as _~/.dotfiles_

5. Now, either run the _setup.ps1_ OR install further softwares/configure the system manually. It's up to you.

- For running the script, open powershell as admin and do this:

```sh
cd ~/.dotfiles    # Assuming you cloned the dotfiles in the $HOME directory
.\setup.ps1
```

6. The _setup.ps1_ will perform the following things (check inside the _setup.ps1_ script for more details):

- Install packages/softwares
  - Microsoft VCRedist 2015-2022 (required for various Win apps to run)
  - PowerShell 7 (Latest PowerShell with cool features)
  - Windows Terminal (Terminal tool provided by Microsoft)
  - LazyGit (Git management tool)
  - Scoop (CLI installer for Windows)
- Other softwares using scoop like 7zip, fzf, ripgrep, etc.. (See the scoop folder for more details)
  - LazyVim (NeoVim distribution, IDE for development)
  - Wezterm (Cross-platform terminal emulator and multiplexer)
- Link configurations to their respective locations.
  - These will be symlinks. Check out the [config.yaml](https://gitlab.com/aniketgm/dotfiles/-/blob/main/rotz/config.yaml) under the rotz folder
- Other misc tools
  - For taskwarrior, there are two options:
    - WSL Or Msys2 (my recommend is Msys2, due to less hasle)
  - For Msys2, install it from [official](https://www.msys2.org) site and then `pacman -Syu task`
  - For WSL, again install from [official](https://learn.microsoft.com/en-us/windows/wsl/install) site, with latest Ubuntu, and then `sudo apt install taskwarrior`
----

### For Linux new system setup (assuming Ubuntu):

```sh
# Install Git required for rotz
sudo apt install git

# Install rotz
curl -fsSL volllly.github.io/rotz/install.sh | sh
echo "export ROTZ_INSTALL=~/.rotz" >> ~/.bashrc
echo "export PATH=$ROTZ_INSTALL:$PATH" >> ~/.bashrc

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
