clc;
clear all;
close all;
%%
im=imread('sulfur_IC_1x6.jpg');
%im=imread('grains_of_rice.png');
BW = imbinarize(im);

out01=BW(:); %columnize
sulfur_1x6=double(out01);
%rice=double(out01);
%%
%hist(sulfur_0x6,2)