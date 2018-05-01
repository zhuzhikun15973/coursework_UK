

This is the coursework for Computer Vision completed by Zhikun Zhu with student ID: 29356822.
The original images are saved in 'data' folder  and the hybrid images are saved in 'data_hybrid' folder.

There are 9 '.m' files here. Those who have names like 'Fig_x' are the MATLAB code used to generate figures displayed in the report as well as test the algorithms. 

The 'gaussianKernel.m' is the algorithm used generate random sized Gaussian templates, which could detect the number of input variables. So you can use 1 or 2 or 3 variables to generate templates. The specific usage is illustrated in the report.

The 'hybridImg.m' is the algorithm used to hybrid images. It is compatible for different size input like the first image's size is '340*500*1'(mono) and the second image's size is '300*600*3'(colour). The algorithm will pad the small sized image with zeros to have the same size with the other one.

The 'normine.m' functions is used to normalize the histogram of input figures.

The 'stepShrink.m' function is used to scale the input image exponentially and save the intermediate images and original image in one array as output.

Finally, the 'tempConv.m' is used to perform template convolution. It will pad the input image with zeros in order to do convolution. After the convolution, the output image will only remain the original region and get rid of the padded part.

Please contact me with 'zz1u17@soton.ac.uk' if you have any questions or need additional materials for the coursework.