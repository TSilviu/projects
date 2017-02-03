%Open the 'S' images
[is1, maps1]   = imread('S1.gif'); %read in image
[is2, maps2]   = imread('S2.gif'); %read in image
[is3, maps3]   = imread('S3.gif'); %read in image
[is4, maps4]   = imread('S4.gif'); %read in image
[is5, maps5]   = imread('S5.gif'); %read in image
[is6, maps6]   = imread('S6.gif'); %read in image
[is7, maps7]   = imread('S7.gif'); %read in image
[is8, maps8]   = imread('S8.gif'); %read in image
[is9, maps9]   = imread('S9.gif'); %read in image
[is10, maps10] = imread('S10.gif'); %read in image
[is11, maps11] = imread('S11.gif'); %read in image
[is12, maps12] = imread('S12.gif'); %read in image
[is13, maps13] = imread('S13.gif'); %read in image
[is14, maps14] = imread('A1.gif'); %read in image

[iv1, maps1]   = imread('V1.gif'); %read in image
[iv2, maps2]   = imread('V2.gif'); %read in image
[iv3, maps3]   = imread('V3.gif'); %read in image
[iv4, maps4]   = imread('V4.gif'); %read in image
[iv5, maps5]   = imread('V5.gif'); %read in image
[iv6, maps6]   = imread('V6.gif'); %read in image
[iv7, maps7]   = imread('V7.gif'); %read in image
[iv8, maps8]   = imread('V8.gif'); %read in image
[iv9, maps9]   = imread('V9.gif'); %read in image
[iv10, maps10] = imread('V10.gif'); %read in image
[iv11, maps11] = imread('V11.gif'); %read in image
[iv12, maps12] = imread('V12.gif'); %read in image
[iv13, maps13] = imread('V13.gif'); %read in image
[iv14, maps14] = imread('B1.gif'); %read in image

[it1, maps1]   = imread('T1.gif'); %read in image
[it2, maps2]   = imread('T2.gif'); %read in image
[it3, maps3]   = imread('T3.gif'); %read in image
[it4, maps4]   = imread('T4.gif'); %read in image
[it5, maps5]   = imread('T5.gif'); %read in image
[it6, maps6]   = imread('T6.gif'); %read in image
[it7, maps7]   = imread('T7.gif'); %read in image
[it8, maps8]   = imread('T8.gif'); %read in image
[it9, maps9]   = imread('T9.gif'); %read in image
[it10, maps10] = imread('T10.gif'); %read in image
[it11, maps11] = imread('T10.gif'); %read in image
[it12, maps12] = imread('T12.gif'); %read in image
[it13, maps13] = imread('T13.gif'); %read in image

%Display the image - example for two
% subplot(5,3,1), subimage(is1,maps1);
% subplot(5,3,2), subimage(is2,maps2);
% subplot(5,3,3), subimage(is3,maps3);
% subplot(5,3,4), subimage(is4,maps4);
% subplot(5,3,5), subimage(is5,maps5);
% subplot(5,3,6), subimage(is6,maps6);
% subplot(5,3,7), subimage(is7,maps7);
% subplot(5,3,8), subimage(is8,maps8);
% subplot(5,3,9), subimage(is9,maps9);
% subplot(5,3,10), subimage(is10,maps10);


%Do fourier transform, fftshift, magnitude an phase for the letter
zs1 = fft2(double(is1)); % do fourier transform
zs2 = fft2(double(is2)); % do fourier transform
zs3 = fft2(double(is3)); % do fourier transform
zs4 = fft2(double(is4)); % do fourier transform
zs5 = fft2(double(is5)); % do fourier transform
zs6 = fft2(double(is6)); % do fourier transform
zs7 = fft2(double(is7)); % do fourier transform
zs8 = fft2(double(is8)); % do fourier transform
zs9 = fft2(double(is9)); % do fourier transform
zs10 = fft2(double(is10)); % do fourier transform
zs11 = fft2(double(is11)); % do fourier transform
zs12 = fft2(double(is12)); % do fourier transform
zs13 = fft2(double(is13)); % do fourier transform
zs14 = fft2(double(is14));

zv1 = fft2(double(iv1)); % do fourier transform
zv2 = fft2(double(iv2)); % do fourier transform
zv3 = fft2(double(iv3)); % do fourier transform
zv4 = fft2(double(iv4)); % do fourier transform
zv5 = fft2(double(iv5)); % do fourier transform
zv6 = fft2(double(iv6)); % do fourier transform
zv7 = fft2(double(iv7)); % do fourier transform
zv8 = fft2(double(iv8)); % do fourier transform
zv9 = fft2(double(iv9)); % do fourier transform
zv10 = fft2(double(iv10)); % do fourier transform
zv11 = fft2(double(iv11)); % do fourier transform
zv12 = fft2(double(iv12)); % do fourier transform
zv13 = fft2(double(iv13)); % do fourier transform
zv14 = fft2(double(iv14)); % do fourier transform

zt1 = fft2(double(it1)); % do fourier transform
zt2 = fft2(double(it2)); % do fourier transform
zt3 = fft2(double(it3)); % do fourier transform
zt4 = fft2(double(it4)); % do fourier transform
zt5 = fft2(double(it5)); % do fourier transform
zt6 = fft2(double(it6)); % do fourier transform
zt7 = fft2(double(it7)); % do fourier transform
zt8 = fft2(double(it8)); % do fourier transform
zt9 = fft2(double(it9)); % do fourier transform
zt10 = fft2(double(it10)); % do fourier transform
zt11 = fft2(double(it11)); % do fourier transform
zt12 = fft2(double(it12)); % do fourier transform
zt13 = fft2(double(it13)); % do fourier transform

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

qs1 = fftshift(zs1); % puts u=0,v=0 in the centre
qs2 = fftshift(zs2); % puts u=0,v=0 in the centre
qs3 = fftshift(zs3); % puts u=0,v=0 in the centre
qs4 = fftshift(zs4); % puts u=0,v=0 in the centre
qs5 = fftshift(zs5); % puts u=0,v=0 in the centre
qs6 = fftshift(zs6); % puts u=0,v=0 in the centre
qs7 = fftshift(zs7); % puts u=0,v=0 in the centre
qs8 = fftshift(zs8); % puts u=0,v=0 in the centre
qs9 = fftshift(zs9); % puts u=0,v=0 in the centre
qs10 = fftshift(zs10); % puts u=0,v=0 in the centre
qs11 = fftshift(zs11); % puts u=0,v=0 in the centre
qs12 = fftshift(zs12); % puts u=0,v=0 in the centre
qs13 = fftshift(zs13); % puts u=0,v=0 in the centre
qs14 = fftshift(zs14); % puts u=0,v=0 in the centre

qv1 = fftshift(zv1); % puts u=0,v=0 in the centre
qv2 = fftshift(zv2); % puts u=0,v=0 in the centre
qv3 = fftshift(zv3); % puts u=0,v=0 in the centre
qv4 = fftshift(zv4); % puts u=0,v=0 in the centre
qv5 = fftshift(zv5); % puts u=0,v=0 in the centre
qv6 = fftshift(zv6); % puts u=0,v=0 in the centre
qv7 = fftshift(zv7); % puts u=0,v=0 in the centre
qv8 = fftshift(zv8); % puts u=0,v=0 in the centre
qv9 = fftshift(zv9); % puts u=0,v=0 in the centre
qv10 = fftshift(zv10); % puts u=0,v=0 in the centre
qv11 = fftshift(zv11); % puts u=0,v=0 in the centre
qv12 = fftshift(zv12); % puts u=0,v=0 in the centre
qv13 = fftshift(zv13); % puts u=0,v=0 in the centre
qv14 = fftshift(zv14); % puts u=0,v=0 in the centre

qt1 = fftshift(zt1); % puts u=0,v=0 in the centre
qt2 = fftshift(zt2); % puts u=0,v=0 in the centre
qt3 = fftshift(zt3); % puts u=0,v=0 in the centre
qt4 = fftshift(zt4); % puts u=0,v=0 in the centre
qt5 = fftshift(zt5); % puts u=0,v=0 in the centre
qt6 = fftshift(zt6); % puts u=0,v=0 in the centre
qt7 = fftshift(zt7); % puts u=0,v=0 in the centre
qt8 = fftshift(zt8); % puts u=0,v=0 in the centre
qt9 = fftshift(zt9); % puts u=0,v=0 in the centre
qt10 = fftshift(zt10); % puts u=0,v=0 in the centre
qt11 = fftshift(zt11); % puts u=0,v=0 in the centre
qt12 = fftshift(zt12); % puts u=0,v=0 in the centre
qt13 = fftshift(zt13); % puts u=0,v=0 in the centre

Magqs1 = abs(qs1); % magnitude spectrum
Magqs2 = abs(qs2); % magnitude spectrum
Magqs3 = abs(qs3); % magnitude spectrum
Magqs4 = abs(qs4); % magnitude spectrum
Magqs5 = abs(qs5); % magnitude spectrum
Magqs6 = abs(qs6); % magnitude spectrum
Magqs7 = abs(qs7); % magnitude spectrum
Magqs8 = abs(qs8); % magnitude spectrum
Magqs9 = abs(qs9); % magnitude spectrum
Magqs10 = abs(qs10); % magnitude spectrum
Magqs11 = abs(qs11); % magnitude spectrum
Magqs12 = abs(qs12); % magnitude spectrum
Magqs13 = abs(qs13); % magnitude spectrum
Magqs14 = abs(qs14); % magnitude spectrum

Magqv1 = abs(qv1); % magnitude spectrum
Magqv2 = abs(qv2); % magnitude spectrum
Magqv3 = abs(qv3); % magnitude spectrum
Magqv4 = abs(qv4); % magnitude spectrum
Magqv5 = abs(qv5); % magnitude spectrum
Magqv6 = abs(qv6); % magnitude spectrum
Magqv7 = abs(qv7); % magnitude spectrum
Magqv8 = abs(qv8); % magnitude spectrum
Magqv9 = abs(qv9); % magnitude spectrum
Magqv10 = abs(qv10); % magnitude spectrum
Magqv11 = abs(qv11); % magnitude spectrum
Magqv12 = abs(qv12); % magnitude spectrum
Magqv13 = abs(qv13); % magnitude spectrum
Magqv14 = abs(qv14); % magnitude spectrum

Magqt1 = abs(qt1); % magnitude spectrum
Magqt2 = abs(qt2); % magnitude spectrum
Magqt3 = abs(qt3); % magnitude spectrum
Magqt4 = abs(qt4); % magnitude spectrum
Magqt5 = abs(qt5); % magnitude spectrum
Magqt6 = abs(qt6); % magnitude spectrum
Magqt7 = abs(qt7); % magnitude spectrum
Magqt8 = abs(qt8); % magnitude spectrum
Magqt9 = abs(qt9); % magnitude spectrum
Magqt10 = abs(qt10); % magnitude spectrum
Magqt11 = abs(qt11); % magnitude spectrum
Magqt12 = abs(qt12); % magnitude spectrum
Magqt13 = abs(qt13); % magnitude spectrum

Phaseq1 = angle(qs1); % phase spectrum
Phaseq2 = angle(qs2); % phase spectrum

%Display the magnitude
%subplot(1,2,1),
% figure;
% imagesc(Magqs1);
% figure;
%subplot(1,2,2), imagesc(Magq2);

%Display the Fourier space for the letters;
% subplot(5,3,1, 'align'),
% figure;
% figure;
% imagesc(abs(qs1));
% figure;
% imagesc(abs(qv1));
% figure;
% imagesc(abs(qt1));
%  figure;
%  imagesc(log(abs(qt1) + 1));
%  figure;
%   imagesc(log(abs(qv1) + 1));
%   figure;
%   imagesc(log(abs(qs1)  + 1));
%  figure;
% figure;
% imagesc(log(abs(qs14) + 1));
% figure;
% imagesc(log(abs(qv14) + 1));
% figure;
% subplot(5,3,2, 'align'), imagesc(log(abs(qt2) + 1));
% subplot(5,3,3, 'align'), imagesc(log(abs(qt3) + 1));
% subplot(5,3,4, 'align'), imagesc(log(abs(qt4) + 1));
% subplot(5,3,5, 'align'), imagesc(log(abs(qt5) + 1));
% subplot(5,3,6, 'align'), imagesc(log(abs(qt6) + 1));
% subplot(5,3,7, 'align'), imagesc(log(abs(qt7) + 1));
% subplot(5,3,8, 'align'), imagesc(log(abs(qt8) + 1));
% subplot(5,3,9, 'align'), imagesc(log(abs(qt9) + 1));
% subplot(5,3,10, 'align'), imagesc(log(abs(qt10) + 1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usually for viewing purposes:
%imagesc(log(abs(q)+1));
%figure;
%imagesc(Magq);
%figure;
%imagesc(Phaseq);
%colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%w = ifft2(ifftshift(q)); % do inverse fourier transform
%imagesc(w);

 mask1 = zeros(400, 640);
 for i = 1:400
     for j = 1:640
        if (i >= 113) && (i <= 189) && (j >= 170) && (j <= 242 )
            mask1(i,j) = 1;
        end
     end
 end

 mask2 = zeros(400, 640);
 for i = 1:400
     for j = 1:640
        if (i >= 195) && (i <= 222) && (j >= 0) && (j <=201 )
            mask2(i,j) = 1;
        end
     end
 end

 %Get the means after applying the masks for 'S'
 mean_row = mean(dot(Magqs1, mask1));
 mask1_mean1_s  = mean(mean_row);

 mean_row = mean(dot(Magqs2, mask1));
 mask1_mean2_s  = mean(mean_row);

 mean_row = mean(dot(Magqs3, mask1));
 mask1_mean3_s  = mean(mean_row);

 mean_row = mean(dot(Magqs4, mask1));
 mask1_mean4_s  = mean(mean_row);

 mean_row = mean(dot(Magqs5, mask1));
 mask1_mean5_s  = mean_row;

 mean_row = mean(dot(Magqs6, mask1));
 mask1_mean6_s  = mean(mean_row);

 mean_row = mean(dot(Magqs7, mask1));
 mask1_mean7_s  = mean(mean_row);

 mean_row = mean(dot(Magqs8, mask1));
 mask1_mean8_s  = mean(mean_row);

 mean_row = mean(dot(Magqs9, mask1));
 mask1_mean9_s  = mean(mean_row);

 mean_row = mean(dot(Magqs10, mask1));
 mask1_mean10_s  = mean(mean_row);

 mean_row = mean(dot(Magqs11, mask1));
 mask1_mean11_s  = mean(mean_row);

  mean_row = mean(dot(Magqs12, mask1));
 mask1_mean12_s  = mean(mean_row);

  mean_row = mean(dot(Magqs13, mask1));
 mask1_mean13_s  = mean(mean_row);

  mean_row = mean(dot(Magqs14, mask1));
 mask1_mean14_s  = mean(mean_row);


 mean_row = mean(dot(Magqs1, mask2));
 mask2_mean1_s  = mean(mean_row);

 mean_row = mean(dot(Magqs2, mask2));
 mask2_mean2_s  = mean(mean_row);

 mean_row = mean(dot(Magqs3, mask2));
 mask2_mean3_s  = mean(mean_row);

 mean_row = mean(dot(Magqs4, mask2));
 mask2_mean4_s  = mean(mean_row);

 mean_row = mean(dot(Magqs5, mask2));
 mask2_mean5_s  = mean_row;

 mean_row = mean(dot(Magqs6, mask2));
 mask2_mean6_s  = mean(mean_row);

 mean_row = mean(dot(Magqs7, mask2));
 mask2_mean7_s  = mean(mean_row);

 mean_row = mean(dot(Magqs8, mask2));
 mask2_mean8_s  = mean(mean_row);

 mean_row = mean(dot(Magqs9, mask2));
 mask2_mean9_s  = mean(mean_row);

 mean_row = mean(dot(Magqs10, mask2));
 mask2_mean10_s  = mean(mean_row);

 mean_row = mean(dot(Magqs11, mask2));
 mask2_mean11_s  = mean(mean_row);

 mean_row = mean(dot(Magqs12, mask2));
 mask2_mean12_s  = mean(mean_row);

  mean_row = mean(dot(Magqs13, mask2));
 mask2_mean13_s  = mean(mean_row);

 mean_row = mean(dot(Magqs14, mask2));
 mask2_mean14_s  = mean(mean_row);



 %Get the means after applying the masks for 'V'
 mean_row = mean(dot(Magqv1, mask1));
 mask1_mean1_v  = mean(mean_row);

 mean_row = mean(dot(Magqv2, mask1));
 mask1_mean2_v  = mean(mean_row);

 mean_row = mean(dot(Magqv3, mask1));
 mask1_mean3_v  = mean(mean_row);

 mean_row = mean(dot(Magqv4, mask1));
 mask1_mean4_v  = mean(mean_row);

 mean_row = mean(dot(Magqv5, mask1));
 mask1_mean5_v  = mean_row;

 mean_row = mean(dot(Magqv6, mask1));
 mask1_mean6_v  = mean(mean_row);

 mean_row = mean(dot(Magqv7, mask1));
 mask1_mean7_v  = mean(mean_row);

 mean_row = mean(dot(Magqv8, mask1));
 mask1_mean8_v  = mean(mean_row);

 mean_row = mean(dot(Magqv9, mask1));
 mask1_mean9_v  = mean(mean_row);

 mean_row = mean(dot(Magqv10, mask1));
 mask1_mean10_v  = mean(mean_row);

 mean_row = mean(dot(Magqv11, mask1));
 mask1_mean11_v  = mean(mean_row);

  mean_row = mean(dot(Magqv12, mask1));
 mask1_mean12_v  = mean(mean_row);

  mean_row = mean(dot(Magqv13, mask1));
 mask1_mean13_v  = mean(mean_row);

  mean_row = mean(dot(Magqv14, mask1));
 mask1_mean14_v  = mean(mean_row);



 mean_row = mean(dot(Magqv1, mask2));
 mask2_mean1_v  = mean(mean_row);

 mean_row = mean(dot(Magqv2, mask2));
 mask2_mean2_v  = mean(mean_row);

 mean_row = mean(dot(Magqv3, mask2));
 mask2_mean3_v  = mean(mean_row);

 mean_row = mean(dot(Magqv4, mask2));
 mask2_mean4_v  = mean(mean_row);

 mean_row = mean(dot(Magqv5, mask2));
 mask2_mean5_v  = mean_row;

 mean_row = mean(dot(Magqv6, mask2));
 mask2_mean6_v  = mean(mean_row);

 mean_row = mean(dot(Magqv7, mask2));
 mask2_mean7_v  = mean(mean_row);

 mean_row = mean(dot(Magqv8, mask2));
 mask2_mean8_v  = mean(mean_row);

 mean_row = mean(dot(Magqv9, mask2));
 mask2_mean9_v  = mean(mean_row);

 mean_row = mean(dot(Magqv10, mask2));
 mask2_mean10_v  = mean(mean_row);

 mean_row = mean(dot(Magqv11, mask2));
 mask2_mean11_v  = mean(mean_row);

  mean_row = mean(dot(Magqv12, mask2));
 mask2_mean12_v  = mean(mean_row);

  mean_row = mean(dot(Magqv13, mask2));
 mask2_mean13_v  = mean(mean_row);

  mean_row = mean(dot(Magqv14, mask2));
 mask2_mean14_v  = mean(mean_row);


 %Get the means after applying the masks for 'T'
 mean_row = mean(dot(Magqt1, mask1));
 mask1_mean1_t  = mean(mean_row);

 mean_row = mean(dot(Magqt2, mask1));
 mask1_mean2_t  = mean(mean_row);

 mean_row = mean(dot(Magqt3, mask1));
 mask1_mean3_t  = mean(mean_row);

 mean_row = mean(dot(Magqt4, mask1));
 mask1_mean4_t  = mean(mean_row);

 mean_row = mean(dot(Magqt5, mask1));
 mask1_mean5_t  = mean_row;

 mean_row = mean(dot(Magqt6, mask1));
 mask1_mean6_t  = mean(mean_row);

 mean_row = mean(dot(Magqt7, mask1));
 mask1_mean7_t  = mean(mean_row);

 mean_row = mean(dot(Magqt8, mask1));
 mask1_mean8_t  = mean(mean_row);

 mean_row = mean(dot(Magqt9, mask1));
 mask1_mean9_t  = mean(mean_row);

 mean_row = mean(dot(Magqt10, mask1));
 mask1_mean10_t  = mean(mean_row);

 mean_row = mean(dot(Magqt11, mask1));
 mask1_mean11_t  = mean(mean_row);

 mean_row = mean(dot(Magqt12, mask1));
 mask1_mean12_t  = mean(mean_row);

 mean_row = mean(dot(Magqt13, mask1));
 mask1_mean13_t  = mean(mean_row);



 mean_row = mean(dot(Magqt1, mask2));
 mask2_mean1_t  = mean(mean_row);

 mean_row = mean(dot(Magqt2, mask2));
 mask2_mean2_t  = mean(mean_row);

 mean_row = mean(dot(Magqt3, mask2));
 mask2_mean3_t  = mean(mean_row);

 mean_row = mean(dot(Magqt4, mask2));
 mask2_mean4_t  = mean(mean_row);

 mean_row = mean(dot(Magqt5, mask2));
 mask2_mean5_t  = mean_row;

 mean_row = mean(dot(Magqt6, mask2));
 mask2_mean6_t  = mean(mean_row);

 mean_row = mean(dot(Magqt7, mask2));
 mask2_mean7_t  = mean(mean_row);

 mean_row = mean(dot(Magqt8, mask2));
 mask2_mean8_t  = mean(mean_row);

 mean_row = mean(dot(Magqt9, mask2));
 mask2_mean9_t  = mean(mean_row);

 mean_row = mean(dot(Magqt10, mask2));
 mask2_mean10_t  = mean(mean_row);

 mean_row = mean(dot(Magqt11, mask2));
 mask2_mean11_t  = mean(mean_row);

 mean_row = mean(dot(Magqt12, mask2));
 mask2_mean12_t  = mean(mean_row);

 mean_row = mean(dot(Magqt13, mask2));
 mask2_mean13_t  = mean(mean_row);

%  mask2_mean1_s  = dot(Magqs1 ,mask2);
%  mask2_mean2_s  = dot(Magqs2 ,mask2);
%  mask2_mean3_s  = dot(Magqs3 ,mask2);
%  mask2_mean4_s  = dot(Magqs4 ,mask2);
%  mask2_mean5_s  = dot(Magqs5 ,mask2);
%  mask2_mean6_s  = dot(Magqs6 ,mask2);
%  mask2_mean7_s  = dot(Magqs7 ,mask2);
%  mask2_mean8_s  = dot(Magqs8 ,mask2);
%  mask2_mean9_s  = dot(Magqs9 ,mask2);
%  mask2_mean10_s = dot(Magqs10 ,mask2);

 mask_applied_s = zeros(2,10);

 mask_applied_s(1,1)  = mask1_mean1_s;
 mask_applied_s(1,2)  = mask1_mean2_s;
 mask_applied_s(1,3)  = mask1_mean3_s;
 mask_applied_s(1,4)  = mask1_mean4_s;
 mask_applied_s(1,5)  = mask1_mean5_s;
 mask_applied_s(1,6)  = mask1_mean6_s;
 mask_applied_s(1,7)  = mask1_mean7_s;
 mask_applied_s(1,8)  = mask1_mean8_s;
 mask_applied_s(1,9)  = mask1_mean9_s;
 mask_applied_s(1,10) = mask1_mean10_s;
 mask_applied_s(2,1)  = mask2_mean1_s;
 mask_applied_s(2,2)  = mask2_mean2_s;
 mask_applied_s(2,3)  = mask2_mean3_s;
 mask_applied_s(2,4)  = mask2_mean4_s;
 mask_applied_s(2,5)  = mask2_mean5_s;
 mask_applied_s(2,6)  = mask2_mean6_s;
 mask_applied_s(2,7)  = mask2_mean7_s;
 mask_applied_s(2,8)  = mask2_mean8_s;
 mask_applied_s(2,9)  = mask2_mean9_s;
 mask_applied_s(2,10) = mask2_mean10_s;
% mask_applied_s(2,11) = mask2_mean11_s;
%  mask_applied_s(2,12) = mask2_mean12_s;
%   mask_applied_s(2,13) = mask2_mean13_s;


 mask_applied_v = zeros(2,10);

 mask_applied_v(1,1)  = mask1_mean1_v;
 mask_applied_v(1,2)  = mask1_mean2_v;
 mask_applied_v(1,3)  = mask1_mean3_v;
 mask_applied_v(1,4)  = mask1_mean4_v;
 mask_applied_v(1,5)  = mask1_mean5_v;
 mask_applied_v(1,6)  = mask1_mean6_v;
 mask_applied_v(1,7)  = mask1_mean7_v;
 mask_applied_v(1,8)  = mask1_mean8_v;
 mask_applied_v(1,9)  = mask1_mean9_v;
 mask_applied_v(1,10) = mask1_mean10_v;
 mask_applied_v(2,1)  = mask2_mean1_v;
 mask_applied_v(2,2)  = mask2_mean2_v;
 mask_applied_v(2,3)  = mask2_mean3_v;
 mask_applied_v(2,4)  = mask2_mean4_v;
 mask_applied_v(2,5)  = mask2_mean5_v;
 mask_applied_v(2,6)  = mask2_mean6_v;
 mask_applied_v(2,7)  = mask2_mean7_v;
 mask_applied_v(2,8)  = mask2_mean8_v;
 mask_applied_v(2,9)  = mask2_mean9_v;
 mask_applied_v(2,10) = mask2_mean10_v;
 % mask_applied_v(2,11) = mask2_mean11_v;
 % mask_applied_v(2,12) = mask2_mean12_v;
 % mask_applied_v(2,13) = mask2_mean13_v;

 mask_applied_t = zeros(2,10);

 mask_applied_t(1,1)  = mask1_mean1_t;
 mask_applied_t(1,2)  = mask1_mean2_t;
 mask_applied_t(1,3)  = mask1_mean3_t;
 mask_applied_t(1,4)  = mask1_mean4_t;
 mask_applied_t(1,5)  = mask1_mean5_t;
 mask_applied_t(1,6)  = mask1_mean6_t;
 mask_applied_t(1,7)  = mask1_mean7_t;
 mask_applied_t(1,8)  = mask1_mean8_t;
 mask_applied_t(1,9)  = mask1_mean9_t;
 mask_applied_t(1,10) = mask1_mean10_t;
 mask_applied_t(2,1)  = mask2_mean1_t;
 mask_applied_t(2,2)  = mask2_mean2_t;
 mask_applied_t(2,3)  = mask2_mean3_t;
 mask_applied_t(2,4)  = mask2_mean4_t;
 mask_applied_t(2,5)  = mask2_mean5_t;
 mask_applied_t(2,6)  = mask2_mean6_t;
 mask_applied_t(2,7)  = mask2_mean7_t;
 mask_applied_t(2,8)  = mask2_mean8_t;
 mask_applied_t(2,9)  = mask2_mean9_t;
 mask_applied_t(2,10) = mask2_mean10_t;
%  mask_applied_t(2,11) = mask2_mean11_t;
%mask_applied_t(2,2) = mask2_mean12_t;
%mask_applied_t(2,13) = mask2_mean13_t;

%  for i = 1:10
%   plot(mask_applied_s(1,i),mask_applied_s(2,i),'r.','MarkerSize',12);%S
%   hold on;
%   plot(mask_applied_v(1,i),mask_applied_v(2,i),'b.','MarkerSize',12);%V
%   hold on;
%   plot(mask_applied_t(1,i),mask_applied_t(2,i),'g.','MarkerSize',12);%T
% end;
training1 = transpose(mask_applied_s);
training2 = transpose(mask_applied_v);
training3 = transpose(mask_applied_t);

c1 = mean(training1);
c2 = mean(training2);
c3 = mean(training3);

aux1 = vertcat(c1,c2);
centroids = vertcat(aux1,c3);

%  plot(centroids(:,1),centroids(:,2),'kx','MarkerSize',13,'LineWidth',2);
%  hold on;
%  gscatter(training(:,1),training(:,2),group,'rbg','+x');
%  hold on;
%  legend('Centroids', 'Training S', 'Training V', 'Training T');
%  hold on;

c1 = [197.7595, 269.2433, 82.9152];
c2 = [179.3633, 99.6806, 260.9967];

%voronoi(c1,c2);

aux = vertcat(training1,training2);
training = vertcat(aux, training3);

xmin = 50;
xmax = 350;

ymin = 50;
ymax = 350;

r1 = xmin + rand(100000,1)*(xmax-xmin);
r2 = ymin + rand(100000,1)*(ymax-ymin);

 sample(1,1) = mask1_mean14_s;
 sample(1,2) = mask2_mean14_s;

  sample(2,1) = mask1_mean14_v;
  sample(2,2) = mask2_mean14_v;

%   data(1,1) = [sample(1,1)];
%   data(1,2) = [sample(1,2)];
%
%   x = [centroids(1,1), centroids(1,2)];
%   y = [centroids(2,1), centroids(2,2)];
%   z = [centroids(3,1), centroids(3,2)];
%
%   dist1 = pdist2(x,data,'euclidean');
%   dist2 = pdist2(y,data,'euclidean');
%   dist3 = pdist2(z,data,'euclidean');
%
%   minimum1 = min(dist1,dist2);
%   minimum = min(minimum1, dist3);
%
%   if (minimum == dist1)
%       plot(data(1,1),data(1,2), 'ro');
%       hold on;
%   end
%
%   if (minimum == dist2)
%      plot(data(1,1),data(1,2), 'bo');
%       hold on;
%   end
%
%   if (minimum == dist3)
%       plot(data(1,1),data(1,2), 'go');
%       hold on;
%   end
%
%   data(1,1) = [sample(2,1)];
%   data(1,2) = [sample(2,2)];
%
%   x = [centroids(1,1), centroids(1,2)];
%   y = [centroids(2,1), centroids(2,2)];
%   z = [centroids(3,1), centroids(3,2)];
%
%   dist1 = pdist2(x,data,'euclidean');
%   dist2 = pdist2(y,data,'euclidean');
%   dist3 = pdist2(z,data,'euclidean');
%
%   minimum1 = min(dist1,dist2);
%   minimum = min(minimum1, dist3);
%
%   if (minimum == dist1)
%       plot(data(1,1),data(1,2), 'ro');
%       hold on;
%   end
%
%   if (minimum == dist2)
%       plot(data(1,1),data(1,2), 'bo');
%       hold on;
%   end
%
%   if (minimum == dist3)
%       plot(data(1,1),data(1,2), 'go');
%       hold on;
%   end

 %sample(3,1) = mask1_mean13_s;
 %sample(3,2) = mask2_mean13_s;

 %sample(3,1) = mask1_mean14_t;
 %sample(3,2) = mask2_mean14_t;

 % sample(3,1) = mask1_mean12_v;
 % sample(3,2) = mask2_mean12_v;

%  sample(4,1) = mask1_mean13_v;
%  sample(4,2) = mask2_mean13_v;
%
%  data(1,1) = [sample(3,1)];
%  data(1,2) = [sample(3,2)];
%
%   x = [centroids(1,1), centroids(1,2)];
%   y = [centroids(2,1), centroids(2,2)];
%   z = [centroids(3,1), centroids(3,2)];
%
%   dist1 = pdist2(x,data,'euclidean');
%   dist2 = pdist2(y,data,'euclidean');
%   dist3 = pdist2(z,data,'euclidean');
%
%   minimum1 = min(dist1,dist2);
%   minimum = min(minimum1, dist3);
%
%   if (minimum == dist1)
%       plot(data(1,1),data(1,2), 'ro');
%       hold on;
%   end
%
%   if (minimum == dist2)
%       plot(data(1,1),data(1,2), 'bo');
%       hold on;
%   end
%
%   if (minimum == dist3)
%       plot(data(1,1),data(1,2), 'go');
%       hold on;
%   end
%
%   data(1,1) = [sample(4,1)];
%   data(1,2) = [sample(4,2)];
%
%   x = [centroids(1,1), centroids(1,2)];
%   y = [centroids(2,1), centroids(2,2)];
%   z = [centroids(3,1), centroids(3,2)];
%
%   dist1 = pdist2(x,data,'euclidean');
%   dist2 = pdist2(y,data,'euclidean');
%   dist3 = pdist2(z,data,'euclidean');
%
%   minimum1 = min(dist1,dist2);
%   minimum = min(minimum1, dist3);
%
%   if (minimum == dist1)
%       plot(data(1,1),data(1,2), 'ro');
%       hold on;
%   end
%
%   if (minimum == dist2)
%       plot(data(1,1),data(1,2), 'bo');
%       hold on;
%   end
%
%   if (minimum == dist3)
%       plot(data(1,1),data(1,2), 'go');
%       hold on;
%   end
%
%  sample(5,1) = mask1_mean11_t;
%  sample(5,2) = mask2_mean11_t;
%
%  %sample(6,1) = mask1_mean12_t;
% % sample(6,2) = mask2_mean12_t;
%
%  sample(6,1) = mask1_mean13_t;
%  sample(6,2) = mask2_mean13_t;
%
%  data(1,1) = [sample(5,1)];
%   data(1,2) = [sample(5,2)];
%
%   x = [centroids(1,1), centroids(1,2)];
%   y = [centroids(2,1), centroids(2,2)];
%   z = [centroids(3,1), centroids(3,2)];
%
%   dist1 = pdist2(x,data,'euclidean');
%   dist2 = pdist2(y,data,'euclidean');
%   dist3 = pdist2(z,data,'euclidean');
%
%   minimum1 = min(dist1,dist2);
%   minimum = min(minimum1, dist3);
%
%   if (minimum == dist1)
%       plot(data(1,1),data(1,2), 'ro');
%       hold on;
%   end
%
%   if (minimum == dist2)
%       plot(data(1,1),data(1,2), 'bo');
%       hold on;
%   end
%
%   if (minimum == dist3)
%       plot(data(1,1),data(1,2), 'go');
%       hold on;
%   end
%
%   data(1,1) = [sample(6,1)];
%   data(1,2) = [sample(6,2)];
%
%   x = [centroids(1,1), centroids(1,2)];
%   y = [centroids(2,1), centroids(2,2)];
%   z = [centroids(3,1), centroids(3,2)];
%
%   dist1 = pdist2(x,data,'euclidean');
%   dist2 = pdist2(y,data,'euclidean');
%   dist3 = pdist2(z,data,'euclidean');
%
%   minimum1 = min(dist1,dist2);
%   minimum = min(minimum1, dist3);
%
%   if (minimum == dist1)
%       plot(data(1,1),data(1,2), 'ro');
%       hold on;
%   end
%
%   if (minimum == dist2)
%      plot(data(1,1),data(1,2), 'bo');
%       hold on;
%   end
%
%   if (minimum == dist3)
%       plot(data(1,1),data(1,2), 'go');
%       hold on;
%   end

% for i = 4:33
%     sample(i,1) = 0;
%     sample(i,2) = 0;
% end


for i = 1:100000
    sample(i,1) = r1(i);
    sample(i,2) = r2(i);
end

group = [1;1;1;1;1;1;1;1;1;1;2;2;2;2;2;2;2;2;2;2;3;3;3;3;3;3;3;3;3;3]

class = knnclassify(sample, training, group, 20);

gscatter(training(:,1),training(:,2),group,'rbg','+x');
hold on;
% % gscatter(training(11,1),training(11,2),group,'rgb','ox');
% % hold on;
% % gscatter(sample(:,1),sample(:,2),class,'mc');
% % hold on;
 plot(sample(class == 1,1), sample(class == 1,2), 'ro');
 hold on;
 plot(sample(class == 2,1), sample(class == 2,2), 'bo');
 hold on;
 plot(sample(class == 3,1), sample(class == 3,2), 'go');
 hold on;
  %legend('Training S', 'Training V', 'Training T', 'Test S', 'Test V', 'Test T');
