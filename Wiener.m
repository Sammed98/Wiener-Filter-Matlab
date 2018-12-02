%Training
K_matrices=zeros(512,512,30);
for i=1:30
    img=im2double(imread(strcat('dataset/',int2str(i),'.gif')));
    n=imnoise(img,'gaussian',0,0.01)-img;
    N=fft2(n);
    F=fft2(img);
    K_matrices(:,:,i)=(abs(N).^2)./(abs(F).^2);
end
K_final=zeros(512,512);
for i=1:30
    K_final=K_final+K_matrices(:,:,i);
end
K_final=K_final/30;
%%
%Reading the image in Grayscale
originalImage=im2double(imread('dataset/40.gif'));
[m,n]=size(originalImage);

%Blur the image
h=fspecial('gaussian',[5 5],10);
im_blurred=imfilter(originalImage,h,'conv','symmetric');

%Add noise
mean = 0;
variance = 0.01;
im_blur = imnoise(im_blurred,'gaussian',mean,variance);

%FFT of Point Spread Function
H=fft2(h,m,n);
H_al=abs(H)/max(max(abs(H)));

%FFT of Distorted[Blurred] image
G=fft2(im_blur);
G_func=abs(G)*255/max(max(abs(G)));

%FFT of Grayscale Original Image
F=fft2(originalImage);
F_func=abs(F)*255/max(max(abs(F)));



%Restoration of Image
H_func = conj(H);
fraction = H_func./((abs(H).^2)+K_final);
temp = G.*fraction;
temp2=ifft2(temp);
restoredImage=abs(temp2);

%Viewing of images
subplot(2,3,1)
imshow(originalImage)
title("GrayScale Image")
subplot(2,3,2)
imshow(im_blur)
title("Blurred Image")
subplot(2,3,3)
imshow(restoredImage)
title("Restored Image")
subplot(2,3,4)
imshow(fftshift(H_al))
title("FFT of Error function")
subplot(2,3,5)
imshow(fftshift(G_func))
title("FFT of Distorted image")
subplot(2,3,6)
imshow(fftshift(F_func))
title("FFT of Grayscale Image")


%Metric - PSNR,MSE
psnrval_e = psnr(im_blur,originalImage);
disp("PSNR - BLurred Image to Original Image")
disp(psnrval_e)

psnrval = psnr(restoredImage,originalImage);
disp("PSNR - Restored Image to Original Image")
disp(psnrval)

mseval = immse(restoredImage,originalImage);
disp("Mean Square Error")
disp(mseval)
