for pictures = 0:20
ppmFileName = strcat('TennisSet1/stennis.', num2str(pictures), '.ppm');
pic = imread(ppmFileName);
picgray = pic(:,:,1); %Converting it into grayscale using red colour space
picgray = im2double(picgray); %Converting it into double class
J = imnoise(picgray,'salt & pepper',0.02); %Adding salt and pepper
filteredImage = medfilt2(J); %Filtering the image using median filter
threshold = 0.771; %Choosing the appropriate threshold.
binaryImage = imbinarize(filteredImage,threshold);
fillImage = imfill(binaryImage,'holes'); %Filling up the holes of the image to smooth it out
Binary = imopen(fillImage , binaryImage); %Filling out the holes
CC=bwconncomp(Binary); %Checking the connected components
cleanBinaryImage = bwareaopen(Binary,200);
cleanBinaryImage = bwareafilt(cleanBinaryImage,[1,650]);
[label,num] = bwlabel(cleanBinaryImage,8); %Updating the label with the connected components

compBinaryFeat = regionprops(cleanBinaryImage,'BoundingBox'); %Using regionprops to extract the bounding box feature
boundingMatrix = vertcat(compBinaryFeat.BoundingBox);

allWidth = boundingMatrix(:,3); %Seperating the width only
allHeight = boundingMatrix(:,4); %Seperating the height only

ratio=allHeight./allWidth; %Dividing height by width

indexesToKeep = false(1, length(ratio));
for k = 1 : length(ratio)
if (ratio(k) >= 0.05 && ratio(k)<=0.3) || (ratio(k)>= 0.8 && ratio(k)<=1.33) %Finding the perfect range
indexesToKeep(k) = true; %Keeping the boxes that falls into the range
end
end

figure,imshow(pic),title('Tracking the ball and the bat');
pause(0.5);

% Extract just acceptable blobs
indexesToKeep = find(indexesToKeep);
remainingImages = ismember(label,indexesToKeep); %Seperating the bat and the ball from the binary image
%imshow(remainingImages);

realPic = regionprops(remainingImages,'BoundingBox','Centroid');
rectMatrix = vertcat(realPic.Centroid);
batX = rectMatrix(1,1);
batY = rectMatrix(1,2);
ballX = rectMatrix(2,1);
ballY = rectMatrix(2,2);
for i = 1 : length(realPic)
currentB = realPic(i).BoundingBox;
rectangle('Position',[currentB(1),currentB(2),currentB(3),currentB(4)],'EdgeColor','r','LineWidth',2);
text(batX,batY,'Bat');
text(ballX,ballY,'Ball');
end

%Finding the centroid of the ball and the bat
realPics = regionprops(remainingImages,'Centroid');
currentCentroidBat = realPics(1).Centroid; %Current centroid for the bati
currentCentroidBall = realPics(2).Centroid; %Current centroud for the ball
%Calculating the velocity of the bat and the ball using centroid
if (pictures>=1)
vel_bat = sqrt(sum((currentCentroidBat - oldCentroidBat).^2))/2;
vel_ball = sqrt(sum((currentCentroidBall - oldCentroidBall).^2))/2;
else
vel_ball = 0;
vel_bat = 0;
end
%Finding the velocity
oldCentroidBall = currentCentroidBall;
oldCentroidBat = currentCentroidBat;
disp("Current velocity of the bat in pixel per frame is:");
disp(vel_bat);
disp("Current velocity of the ball in pixel per frame is:");
disp(vel_ball);
end