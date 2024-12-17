#!/bin/bash

echo "Clearing cache memory..."
sync; echo 3 > /proc/sys/vm/drop_caches
echo "Cache cleared."


