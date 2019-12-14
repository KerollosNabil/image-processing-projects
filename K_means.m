function K_means(k, imgname)

    RGB = imread(imgname);
    figure
    imshow(RGB)
    [L, Centers] = imsegkmeans(RGB, k);
    B = labeloverlay(RGB, L);
    figure
    imshow(B)
    title('Labeled Image')
    title('Labeled Image')
    wavelength = 2.^(0:5) * 3;
    orientation = 0:45:135; % 0, 45, 90, 135
    g = gabor(wavelength, orientation);
    I = rgb2gray(im2single(RGB));
    gabormag = imgaborfilt(I, g);
    figure
    montage(gabormag, 'Size', [4 6])

    for i = 1:length(g)
        sigma = 0.5 * g(i).Wavelength;
        gabormag(:, :, i) = imgaussfilt(gabormag(:, :, i), 3 * sigma);
    end

    figure
    montage(gabormag, 'Size', [4 6])
    nrows = size(RGB, 1);
    ncols = size(RGB, 2);
    [X, Y] = meshgrid(1:ncols, 1:nrows);
    featureSet = cat(3, I, gabormag, X, Y);
    size(RGB)
    size(featureSet)
    L2 = imsegkmeans(featureSet, k, 'NormalizeInput', true);
    C = labeloverlay(RGB, L2);
    figure
    imshow(C)
    title('Labeled Image with Additional Pixel Information')
end
