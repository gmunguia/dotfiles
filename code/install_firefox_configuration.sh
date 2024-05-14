#!/bin/bash

PROFILE_FOLDER=$(find ~/Library/Application\ Support/Firefox/Profiles -name '*.default-release')

if [ ! -d "$PROFILE_FOLDER" ]; then
  echo "Couldn't find profile folder"
  exit 1
fi

ln -s ~/.config/firefox/user.js "$PROFILE_FOLDER/user.js"
