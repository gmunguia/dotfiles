#!/bin/bash
set -e

# Does this command wait for install to finish before exit?
# TODO Needs to be run before manually, because it's interactive
# xcode-select --install

# https://www.atlassian.com/git/tutorials/dotfiles
git clone --bare --recurse-submodules gmunguia/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
config submodule update --init --recursive
config remote set-url --push origin git@github.com:gmunguia/dotfiles.git

# Install homebrew.
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_BUNDLE_FILE="$HOME/.config/brewfile/Brewfile"
brew bundle

# Set up fish.
sudo sh -c "echo $(which fish) >> /etc/shells"
sudo chsh -s $(which fish) $USER
fish -c 'fish_add_path /opt/homebrew/bin'

# Set up NodeJS.
fnm install --lts

# Set up keeweb+yubikey
ln -s $(which ykman) /usr/local/bin/ykman

# Language servers
npm i -g \
	dockerfile-language-server-nodejs \
	typescript-language-server \
	typescript \
	vscode-langservers-extracted \
	yaml-language-server \
	@prisma/language-server

# Close any open System Preferences panes, to prevent them from overriding settings we're about to change.
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo systemsetup -settimezone Europe/Madrid

# I don't use the dock. https://apple.stackexchange.com/a/298826
defaults write com.apple.dock autohide-delay -float 1000
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock autohide -bool true
killall Dock

# I use raycast instead of spotlight. Idk if this is the right way of disabling it.
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 0;"name" = "APPLICATIONS";}' \
	'{"enabled" = 0;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
	'{"enabled" = 0;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Reload settings.
killall mds > /dev/null 2>&1

# Disable the sound effects on boot.
sudo nvram SystemAudioVolume=" "

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets.
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Finder: allow quitting via Cmd + Q; doing so will also hide desktop icons.
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations.
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default.
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Disable the warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default.
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Refresh settings.
killall Finder

# How to find correct values for defaults:
# 1. run `defaults read > before`
# 2. change setting
# 3. run `defaults read > after`
# 4. diff the two files to find out what's changed.

# Remove input source change shortcut.
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>786432</integer></array><key>type</key><string>standard</string></dict></dict>"
# Remove cmd+space spotlight shortcut.
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"

# Apply shortcut changes.
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
