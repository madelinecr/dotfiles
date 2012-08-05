## Dotfiles!

This is my dotfiles repository for storing, backing up and sharing my shell and
program configuration files. It's powered by a simple little Rakefile.

## Usage

Files and folders placed in the config dir without a preceding period will be
automatically expanded to their proper file path in $HuOME. For example, 
"config/vimrc" will be auto-expanded to "~/.vimrc".

### Commands

`rake symlinks` Default task, generates symlinks

`rake uninstall` Removes symlinks. Be careful with this! It isn't as gentle as
it should be (for now).
