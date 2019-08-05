#!/usr/bin/env sh
set -e
./build/tools/caffe test --model=./examples/Transfer/prototxt_files/test_ice.prototxt --weights=./examples/Transfer/snapshot/iter_1000.caffemodel -iterations=2048 -gpu=0


