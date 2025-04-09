A=imread('diya.jpg'); %Original Cover image A
A=rgb2gray(A); 
A=im2double(A);
A=imresize(A,[400,400]);
imshow(A);title('original cover image')

W=imread('cameraman.tif'); %Water mark image W
W=im2gray(W); 
W=im2double(W);
W=imresize(W,[400,400]);
imshow(W);title('watermark image')

[U,S,V]=svd(A);
Alpha=0.5;
Sn=S+Alpha*W; % Water mark embedding 
AW=U*Sn*V'; % Get Watermarked Image as AW
figure; imshow(AW);title('watermarked image') 

W1=(1/Alpha)*(Sn-S); % Extract the watermark %
figure;imshow(W1);title('Extract the watermark')

