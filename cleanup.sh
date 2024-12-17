#!/bin/bash
sudo apt autoremove -y
sudo apt autoclean -y
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'


