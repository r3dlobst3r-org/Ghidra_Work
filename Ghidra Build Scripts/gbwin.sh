#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
/usr/local/bin/VBoxManage startvm "Windows 10" --type headless
sleep 60
export SSH_AUTH_SOCK=$( ls /private/tmp/com.apple.launchd.*/Listeners )
ssh -t andrew@192.168.86.28 'sh ghidra_build.sh'
