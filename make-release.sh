#!/bin/bash -e
berks vendor --delete pihole-release
tar -zcvf pihole-release.tar.gz pihole-release
scp pihole-release.tar.gz pi@192.168.1.87:/random
