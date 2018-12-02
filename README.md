# Wiener-Filter-Matlab
Implementation of Wiener Filter in Matlab

1. Open Wiener.m in Matlab.

2. There are two sections in this code. One for training and one for testing.

3. The training section iterates through the first 30 images of the dataset and trains on the value of K(u,v) which is the ratio of the PSD of Noise to PSD of original image.

4. In the testing section we are adding Gaussian Noise and Blur to a given good image and restoring it with the wiener filter. Pass the path of the good image in the code and run the section.

5. The output is a figure which contains the original grayscale image, distorted image, restored image, FFT of the point spread functions, FFT of the distorted image, FFT of the original image.

6. The metric used to measure the quality of the filter is the PSNR difference between the Blurred-Original and Restored-original. The higher the difference the better the wiener filter.
