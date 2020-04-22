
imageNames = dir(fullfile('TennisSet1','*.ppm'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile('shuttle_out.avi'));
outputVideo.FrameRate = 30;
open(outputVideo)

for ii = 1:length(imageNames)
   img = imread(fullfile('TennisSet1',imageNames{ii}));
   writeVideo(outputVideo,img)
end

close(outputVideo)

shuttleAvi = VideoReader(fullfile('shuttle_out.avi'));

ii = 1;
while hasFrame(shuttleAvi)
   mov(ii) = im2frame(readFrame(shuttleAvi));
   ii = ii+1;
end

figure 
imshow(mov(1).cdata, 'Border', 'tight')

movie(mov,1,shuttleAvi.FrameRate)

videoFileReader = vision.VideoFileReader('shuttle_out.avi');
S = info(videoFileReader);
frameRate = S.VideoFrameRate; % frame/second
scale = 1/240; % m/pixel
videoPlayer = vision.VideoPlayer('Position',[100 100 600 400]);
oldPoints = [];
while ~isDone(videoFileReader)
    videoFrame = step(videoFileReader);
    G = rgb2gray(videoFrame);
    BW = G > 0.7;
    
    BW2 = bwareaopen(BW,30);
    BW3 = imfill(BW2, 'holes');
    stats = regionprops('table',BW3,'Centroid');
    points = table2array(stats);
    if ~isempty(oldPoints)
        % Calculate velocity (pixels/frame)
        vel_pix = sqrt(sum((points-oldPoints).^2,2));
        vel = vel_pix * frameRate * scale; % pixels/frame * frame/seconds * meter/pixels
    else
        vel_pix = 0;
        vel = 0;
    end
      % Visualize the velocity
      videoFrameOut = insertObjectAnnotation(videoFrame, 'circle', ...
          [points 10*ones(size(points,1),1)], ...
          cellstr(num2str(vel,'%2.2f')));
      step(videoPlayer, videoFrameOut);
      oldPoints = points;
%       points=points(1:length(oldPoints),:);
  end
  release(videoFileReader);
  release(videoPlayer);
