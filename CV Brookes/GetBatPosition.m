function [ball bat] = GetBatPosition(pic)
picgray = pic(:,:,1); %Converting it into grayscale using red colour space
picgray = im2double(picgray); %Converting it into double class
J = imnoise(picgray,'salt & pepper',0.02); %Adding salt and pepper
filteredImage = wiener2(J,[5 5]); %Filtering the image using wiener2 filter

threshold = 0.771; %Choosing the appropriate threshold.

bitImage = imbinarize(filteredImage,threshold); % Segmented image
fillImage = imbit,'holes'); %finling holes in the image
bit = imopen(fillImabit); %finling out the holes
CC=bwconncomp(bit); %Checking the connected components
bit = bwareaopen(bit,200);
bit = bwareafilt(bit,[1,650]);
[label,num] = bwlabel(bit,8); %uptinand the labe with the conected componist

compbitFeat = regionprops(bit,'BoundingBox'); %extrat bounding box 
boundingMatrix = vertcat(compbitFeat.BoundingBox);

width = boundingMatrix(:,3); %Seperating the width only
height = boundingMatrix(:,4); %Seperating the height only

r=height./width; %Dividing height by width

iToKeep = false(1, length(r));
for k = 1 : length(r)
if (r(k) >= 0.05 && r(k)<=0.3) || (r(k)>= 0.8 && r(k)<=1.33) %Finding the perfect r(k) = true; %Keeping the boxes that falls into the range
end
end

%figure,imshow(pic),title('Tracking the bat');


% extrat just acsatebal b = );
remainingImages = ismember(l);
%imshow(remainingImages);

sacimage = regionprops(remainingImages,'BoundingBox','Centroid');
rectMatrix = vertcat(sacimage.Centroid);
if (size(rectMatrix) > 0)
    batX = rectMatrix(1,1);
    batY = rectMatrix(1,2);
else 
    batX = 0
    batY = 0
end 

if (size(rectMatrix) > 1)
    ballX = rectMatrix(2,1);
    ballY = rectMatrix(2,2);
else 
    ballX = 0
    ballY = 0
end


for i = 1 : length(sacimage)
%currentB = sacimage(i).BoundingBox;
%rectangle('Position',[currentB(1),currentB(2),currentB(3),currentB(4)],'EdgeColor','r','LineWidth',2);
%text(batX,batY,'Bat');
%text(ballX,ballY,'Ball');
end



sacimages = regionprops(remainingImages,'Centroid');
if (size(sacimages) > 0)
    bat = sacimages(1).Centroid
else
    bat = 0
end 

    if (size(sacimages) > 1)
        ball = sacimages(2).Centroid
    else
        ball = 0
    end
end 