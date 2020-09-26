#!/bin/bash
# Install httpd
sudo yum install -y httpd
# Start httpd
sudo service httpd start

sleep 4m
# Install AWS EFS Utilities
sudo yum install -y amazon-efs-utils
# Mount EFS
sudo mkdir /efs
efs_id="${efs_id}"
sudo mount -t efs $efs_id:/ /efs
# Edit fstab so EFS automatically loads on reboot
sudo echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab