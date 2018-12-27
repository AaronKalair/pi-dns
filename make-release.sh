#!/bin/bash -e
# Vendors all the cookbooks needed to run this cookbook into a tar archive
# and then SCPs them onto a device

# Args: IP address of device to SCP the files onto

berks vendor --delete pihole-release
rm pihole-release-tar.gz || true
tar -zcvf pihole-release.tar.gz pihole-release
scp pihole-release.tar.gz pi@$1:/chef
