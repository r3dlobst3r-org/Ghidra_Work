#!/bin/bash
changed=0
_now=$(date +"%m_%d_%Y")
cd /home/andrew/ghidra
git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 1 ]; then
rm -rf /home/andrew/ghidra/build/dist/*.zip
git pull
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle --init-script gradle/support/fetchDependencies.gradle init
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle buildGhidra
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle eclipse
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle buildNatives_linux64
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle sleighCompile
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle eclipse -PeclipsePDE
/home/andrew/.sdkman/candidates/gradle/5.0/bin/gradle prepDev
cd /home/andrew/
unzip /home/andrew/ghidra/build/dist/ghidra*.zip
cd ghidra_*_DEV
rsync -a  * /home/andrew/Ghidra_Linux/
cd /home/andrew/Ghidra_Linux/
git fetch
git add .
git commit -a -m new_build_$_now
git push git@github.com:Ghidra-Guys/Ghidra_Linux.git
rm -rf /home/andrew/ghidra_9*
shutdown
else
echo "All Good"
shutdown
fi
