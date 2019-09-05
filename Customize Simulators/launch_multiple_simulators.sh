#!/bin/bash

xcrun simctl shutdown all

path=$(find ~/Library/Developer/Xcode/DerivedData/riderapp-*/Build/Products/Debug-iphonesimulator -name "riderapp.app" | head -n 1)
echo "${path}"


filename=MultiSimConfig.txt
grep -v '^#' $filename | while read -r line
do
  echo $line
  xcrun instruments -w "$line"
  xcrun simctl install booted $path
  xcrun simctl launch booted fleet.riderapp
done
