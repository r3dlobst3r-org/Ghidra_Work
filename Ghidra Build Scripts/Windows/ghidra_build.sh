#!/bin/bash
changed=0
_now=$(date +"%m_%d_%Y")
cd ghidra
git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 1 ]; then
rm -rf ghidra/build/dist/*.zip
git pull
gradle --init-script gradle/support/fetchDependencies.gradle init
gradle buildGhidra
gradle eclipse
gradle buildNatives_win64
gradle sleighCompile
gradle eclipse -PeclipsePDE
gradle prepDev
cd
unzip ghidra/build/dist/ghidra*.zip
rsync -a  ghidra_*_DEV/* Ghidra_Win64
cd Ghidra_Win64
git fetch
git add .
git commit -a -m new_build_$_now
git push git@github.com:Ghidra-Guys/Ghidra_Win64.git
cd
rm -rf ghidra_9*
shutdown -s -t 0
else
echo "All Good"
shutdown -s -t 0
fi
