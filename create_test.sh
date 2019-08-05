#!/usr/bin/env sh
# Create the imagenet lmdb inputs
# N.B. set the path to the imagenet train + val data dirs

EXAMPLE=examples/Transfer/data/test
DATA=/home/ouc/caffe-fast-rcnn/examples/Transfer/data/test
TOOLS=build/tools
#RAIN_DATA_ROOT=examples/Transfer/data/TRAIN/
VAL_DATA_ROOT=examples/Transfer/data/test/test_ice2/a/

# Set RESIZE=true to resize the images to 28x28. Leave as false if images have
# already been resized using another tool.
RESIZE=true
if $RESIZE; then
  RESIZE_HEIGHT=28
  RESIZE_WIDTH=28
else
  RESIZE_HEIGHT=0
  RESIZE_WIDTH=0
fi

# if [ ! -d "$TRAIN_DATA_ROOT" ]; then
  # echo "Error: TRAIN_DATA_ROOT is not a path to a directory: $TRAIN_DATA_ROOT"
  # echo "Set the TRAIN_DATA_ROOT variable in create_imagenet.sh to the path" \
       # "where the ImageNet training data is stored."
  # exit 1
# fi

 if [ ! -d "$VAL_DATA_ROOT" ]; then
   echo "Error: VAL_DATA_ROOT is not a path to a directory: $VAL_DATA_ROOT"
   echo "Set the VAL_DATA_ROOT variable in create_imagenet.sh to the path" \
        "where the ImageNet validation data is stored."
   exit 1
 fi

#echo "Creating train lmdb......"

# GLOG_logtostderr=1 $TOOLS/convert_imageset \
    # --resize_height=$RESIZE_HEIGHT \
    # --resize_width=$RESIZE_WIDTH \
    # --shuffle  
    # $TRAIN_DATA_ROOT \
    # $DATA/TRAIN/train.txt \
    # $EXAMPLE/train_lmdb

echo "Creating val lmdb......"

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    $VAL_DATA_ROOT \
    $DATA/test_ice2/test.txt \
    $EXAMPLE/test_lmdb

echo "Done."
