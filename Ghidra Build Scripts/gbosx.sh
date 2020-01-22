#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
changed=0
_now=$(date +"%m_%d_%Y")
cd ghidra
git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 1 ]; then
    rm -rf /Users/andrew/ghidra/build/dist/*.zip
    git pull
    gradle --init-script gradle/support/fetchDependencies.gradle init
    gradle buildGhidra
    gradle eclipse
    gradle buildNatives_osx64
    gradle sleighCompile
    gradle eclipse -PeclipsePDE
    gradle prepDev
    cd
    unzip ghidra/build/dist/ghidra*.zip
    cd ghidra_*
    rsync -a  * /Users/andrew/Ghidra_macOS/
    cd /Users/andrew/Ghidra_macOS/
    git fetch
    git add .
    git commit -a -m new_build_$_now
    git push git@github.com:Ghidra-Guys/Ghidra_macOS.git
    rm -rf /Users/andrew/ghidra_9*
else
    echo "All Good"
fi
