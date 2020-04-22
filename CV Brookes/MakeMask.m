function [BW,maskedRGBImage] = MakeMask(RGB)
%------------------------------------------------------


% Convert RGB image to chosen color space
imageRGB = rgb2lab(RGB);

% Create mask based on chosen histogram thresholds

channel1Min = 19.173;
channel1Max = 91.542;


channel2Min = 0.666;
channel2Max = 20.123;


channel3Min = 11.4;
channel3Max = 33.03;


sliderBW = (imageRGB(:,:,1) >= channel1Min ) & (imageRGB(:,:,1) <= channel1Max) & ...
    (imageRGB(:,:,2) >= channel2Min ) & (imageRGB(:,:,2) <= channel2Max) & ...
    (imageRGB(:,:,3) >= channel3Min ) & (imageRGB(:,:,3) <= channel3Max);
BW = sliderBW;

% Invert mask
BW = ~BW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
