# Dotfiles Management

## Overview

  - The dotfiles are managed using [GNU Stow](https://www.gnu.org/software/stow/). The idea is simple:
      - For each folder, store/restore the config that's in that respective folder.
      - Reason for having separate folders is that I can restore only the things I want rather than restoring all of them.
      - Again, why, because 2 main reasons:
        a. My home and my office PC contains may contain different setups. So I make it generic rather than specialized to one setup. If not, then my home config will all over the place in my office config OR vice-versa, which I don't want.
        b. Say, today my office uses Linux (thankfully, because I love Linux), but let's say I switch to some another organization, which uses Windows, so all my linux config may not work.

### How does it work ?

  - The bash related dotfiles, (`.bashrc`, `.bash_aliases`, etc..) are stored in a folder called 'bash'. So when setting up a new machine and assuming the 'Dotfiles' folder is cloned in $HOME directory, then doing a simple: `stow bash`, will restore/add the files in proper places in the $HOME directory.

## Steps to restore:

  - Pre-requisite: Install GNU Stow

<!-- end list -->

``` bash
sudo apt install stow # This is for ubuntu. Check stow docs for how to install for other platforms
```

  - Clone the repo:

<!-- end list -->

``` bash
cd ~
git clone https://github.com/aniketgm/Dotfiles.git
```

  - Goto inside the Dotfiles and restore whatever you want:

<!-- end list -->

``` bash
cd Dotfiles
stow bash
```

  - This will restore bash files in the $HOME directory.

  - Similarly, doing `stow <folder_name_inside_Dotfiles>`, will restore other respective configs.

  - NOTE: The bashrc file contains an entry at the end for [zoxide](https://github.com/ajeetdsouza/zoxide) and [starship](https://starship.rs). So you may want to install that first before using the config.

