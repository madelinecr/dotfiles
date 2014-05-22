## Dotfiles!

This is my dotfiles repository for storing, backing up and sharing my shell and
program configuration files. It's powered by a simple little shell script.

## Usage

Files and folders placed in the config dir without a preceding period will be
automatically expanded to their proper file path in $HOME. For example, 
"config/vimrc" will be auto-expanded to "~/.vimrc".

It will also automatically symlink binaries. "bin/z.sh" will be auto-expanded to
"~/bin/z.sh".

### Commands

`[-s]` Sandbox mode, performs all symlinking operations in the `sandbox`
 subdirectory of the repository.

`[-d]` Dry run, does not actually perform system commands (mkdir, ln, rm)

`./bootstrap.sh` Default task, generates symlinks

`./bootstrap.sh install` Same as above, generates symlinks

`./bootstrap.sh uninstall` Removes symlinks.
