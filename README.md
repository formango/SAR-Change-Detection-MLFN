This code is for our paper "Transferred deep learning for sea ice change detection from synthetic aperture radar images". 
If you use this code, please kindly cite our paper:
Yunhao Gao, Feng Gao*, Junyu Dong, Shenke Wang. "Transferred deep learning for sea ice change detection from synthetic aperture radar Images". IEEE Geoscience and Remote Sensing Letters, 2019.

If you have any questions, please contact us. 
Email:  gaoyunhao128@163.com

Before running this code, you should correctly install ubuntu system and caffe framework. Refer to this guildeline "http://caffe.berkeleyvision.org/installation.html" After correctly installing ubuntu and caffe, you can run this code by the following procedures. 

(1) Opening the Matlab and changing the current path,
    running the "generating_train.m" and "generating_test.m" to generate the training and testing samples 
	
(2) Running the "create_train.sh" and "create_test.sh" in Caffe. 
    Therefore, the format "png" can be converted to format "lmdb" which is efficent for the caffe input

(3) Opening the terminal and running this script to execute the training of MLFN:
    "sh train.sh"

(4) After training, running the following script to executes the testing of MLFN and record testing logs:
    "sh test.sh >& info/result.txt"

(5) Running the "extract_prob.sh" in Caffe to extract probability from the "result.txt"

(6) Running the "calculating_result.m" in Matlab to calculate the matrics (PCC, Kappa, FP and FN) and draw the final change map.

