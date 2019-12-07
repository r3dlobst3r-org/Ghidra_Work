#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
/usr/local/bin/VBoxManage startvm Ubuntu --type headless
sleep 30
export SSH_AUTH_SOCK=$( ls /private/tmp/com.apple.launchd.*/Listeners )
ssh -t andrew@192.168.86.32 './ghidra_build.sh'
