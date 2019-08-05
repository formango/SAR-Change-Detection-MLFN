%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script is used to generate the testing samples

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

addpath('./Utils');

% PatSize ±ØÐëÎªÆæÊý

PatSize = 7;
k_n = 3;

fprintf(' ... ... read image file ... ... ... ....\n');
im1 = imread('./pic/bern_1.bmp');
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

% Select patch for each pixel center

mag = (PatSize-1)/2;
imTmp = zeros(ylen+PatSize-1, xlen+PatSize-1);
imTmp((mag+1):end-mag,(mag+1):end-mag) = nrmap; 
nrmap = im2col_general(imTmp, [PatSize, PatSize]);

clear imTmp mag;

nrmap = mat2imgcell(nrmap, PatSize, PatSize, 'gray');

fid = fopen('E:\matlab workplace\DFFN\picture\test\test.txt','wt');
for i = 1:xlen*ylen
    if (im_gt(i)==0)
        fprintf(fid,'%s','img_');
        fprintf(fid,'%g',i);
         fprintf(fid,'%s\t','.png');
        fprintf(fid,'%g\n',0);
    else
        fprintf(fid,'%s','img_');
        fprintf(fid,'%g',i);
        fprintf(fid,'%s\t','.png');
        fprintf(fid,'%g\n',1)
    end
end
fclose(fid);

% Testing samples generation

  for i = 1:xlen*ylen
       pic = nrmap{i};
       imwrite(uint8(pic),['E:\matlab workplace\DFFN\picture\test\a\','img_',num2str(i),'.png'],'png');
   end
 
 fprintf(' ... ... over !!! !!!\n\n');



