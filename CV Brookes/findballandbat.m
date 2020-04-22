image_folder = 'TennisSet1'; 
filenames = dir(fullfile(image_folder, '*.ppm'));  
total_images = numel(filenames);
%%
lx = 151.4160;
ly = 149.7528;
spendx = [];
spendy = [];
for i2 = 1 : total_images
  f= fullfile(image_folder, filenames(i2).name);

  %processmyimage(imread(f));
 [sx,sy] = doSomeprocess(imread(f));
 sppx = abs(sx - lx)
 sppy = abs(sy - ly)
 lx = sx;
 ly = sy;
 spendx = [spendx sppx];
 spendy = [spendy sppy];

end
figure
plot(spendy)
figure
plot(spendx)
mean(spendy)
mean(spendx)

function [pos1,pos2] = doSomeprocess(Image)
    BW = MakeMask(Image);
    bw= bwareaopen(BW,70);
    figure(4)
    labels = bwlabel(bw);
    Pedal=(labels==2);
    Pingpong=(labels==3);
   
    
    st1 = regionprops(Pedal,'BoundingBox');
    st2 = regionprops(Pingpong,'BoundingBox');
    
    pos1 = regionprops(Pedal, 'Centroid').Centroid;
    pos2 = regionprops(Pedal, 'Centroid').Centroid;
    figure,imshow(Image);                      
    for k = 1 : length(st1)
        thisBB = st1(k).BoundingBox;
        rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
        'EdgeColor','r','LineWidth',2 )
    end
    
    for k = 1 : length(st2)
        thisBB = st2(k).BoundingBox;
        rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
        'EdgeColor','b','LineWidth',2 )
    end
end 