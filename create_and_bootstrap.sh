#!/bin/bash

set -x

echo "Hello! starting $(date)"

sudo rm -rf p3-tools.img
singularity create -s 1024 p3-tools.img
sudo singularity bootstrap p3-tools.img ubuntu.sh

echo "Goodbye! ending $(date)"
