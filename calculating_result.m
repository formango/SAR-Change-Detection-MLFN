%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script is used to calculating the final result

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

% Number of classes

num_classes = 2;  
 
pre_result = load('train_ice.mat');
 
prob_data_temp=importdata('./info/prob.txt');

im_gt = imread('./pic/bern_gt.bmp');
im_gt = double(im_gt(:,:,1));
im_gt(im_gt==255)=1;

[ylen, xlen] = size(im_gt);

predict_label = [];
test_prob = [];

for i = 1:length(prob_data_temp)/num_classes
    prob_temp = prob_data_temp((i-1)*num_classes+1:i*num_classes,:)';
    test_prob = [test_prob;prob_temp];
    predict_label = [predict_label;find(prob_temp==max(prob_temp))];
end

predict_label = predict_label-1;
resultmap = reshape(predict_label,[ylen,xlen]);

% Load preclassification result

for j = 1:600
   resultmap(pre_result(j,2))=pre_result(j,1);
end

% Calculate the matrics
   
 aa = find(im_gt==0&resultmap~=0);
 bb = find(im_gt~=0&resultmap==0);
 
 FP = numel(aa);
 FN = numel(bb);
 OE = FP + FN; 

CA = 1-OE/(ylen*xlen);  

imwrite(resultmap,'result_ice.jpg','jpg'); 

figure,imshow(resultmap,[]);
