%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script is used to generate the training samples

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

addpath('./Utils');

% PatSize ±ØÐëÎªÆæÊý

PatSize = 7;
k_n = 3;

fprintf(' ... ... read image file ... ... ... ....\n');
im1 = imread('./pic/bern.bmp');
im2 = imread('./pic/bern_2.bmp');
im_gt = imread('./pic/bern_gt.bmp');
fprintf(' ... ... read image file finished !!! !!!\n\n');

im1 = double(im1(:,:,1));
im2 = double(im2(:,:,1));
im_gt = double(im_gt(:,:,1));

[ylen, xlen] = size(im1);

% Caculate neighborhood-based ratio image

fprintf(' ... .. compute the neighborhood ratio ..\n');
nrmap = nr(im1, im2, k_n);
nrmap = max(nrmap(:))-nrmap;
nrmap = nr_enhance( nrmap );
feat_vec = reshape(nrmap, ylen*xlen, 1);

im_lab = gao_clustering(feat_vec, ylen, xlen);

% Label of preclassification

pos_idx = find(im_lab == 0);
neg_idx = find(im_lab == 1);
tst_lab = find(im_lab == 0.5);

% Select patch for each pixel center

mag = (PatSize-1)/2;
imTmp = zeros(ylen+PatSize-1, xlen+PatSize-1);
imTmp((mag+1):end-mag,(mag+1):end-mag) = nrmap; 

nrmap = im2col_general(imTmp, [PatSize, PatSize]);
nrmap = mat2imgcell(nrmap, PatSize, PatSize, 'gray');

pos_idx = pos_idx(randperm(numel(pos_idx)));
neg_idx = neg_idx(randperm(numel(neg_idx)));
[ylen, xlen] = size(im1);

% Proportion setting of training samples

%  PosNum = numel(pos_idx);
%  NegNum = numel(neg_idx);

PosNum = 300;
NegNum = 300;

% Index and label of training samples

pos_lab = ones(PosNum,1);
neg_lab = zeros(NegNum,1);
pos_idx = pos_idx(1:PosNum,:);
neg_idx = neg_idx(1:NegNum,:);
train_lab = [pos_lab;neg_lab];
train_idx = [pos_idx;neg_idx];
train_data = [train_idx,train_lab];

fid = fopen('E:\matlab workplace\DFFN\picture\train\train.txt','wt');
for i=1:PosNum+NegNum-1
    idx_i = train_data(i,1);
    lab_i = train_data(i,2);
        fprintf(fid,'%g',lab_i);
        fprintf(fid,'%s','/img_');
        fprintf(fid,'%g',idx_i);
        fprintf(fid,'%s\t','.png');
        fprintf(fid,'%g\n',lab_i);
 
end
fclose(fid);

% Training samples generation

  for i = 1:NegNum
       pic = nrmap{neg_idx(i)};
       imwrite(uint8(pic),['E:\matlab workplace\DFFN\picture\train\0\','img_',num2str(neg_idx(i)),'.png'],'png');
   end
  for i = 1:PosNum
      pic = nrmap{pos_idx(i)};
      imwrite(uint8(pic),['E:\matlab workplace\DFFN\picture\train\1\','img_',num2str(pos_idx(i)),'.png'],'png');
  end
  
save train_ice.mat train_data
 
fprintf(' ... .. over ..\n');

