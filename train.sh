#!/usr/bin/env sh

./build/tools/caffe train --solver=./examples/Transfer/prototxt_files/solver.prototxt -weights ./examples/Transfer/models/iter_LCCD.caffemodel$@