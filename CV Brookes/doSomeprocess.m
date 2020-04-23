function [pos1,pos2] = doSomeprocess(Image)
    BW = MakeMask(Image);
    bw= bwareaopen(BW,60);
    figure(4)
    labels = bwlabel(bw);
    Pedal=(labels==2);
    Pingpong=(labels==3);
   
    
    st1 = regionprops(Pedal,'BoundingBox');
    st2 = regionprops(Pingpong,'BoundingBox');
    
    pos1 = regionprops(Pedal, 'Centroid').Centroid;
    pos2 = regionprops(Pingpong, 'Centroid').Centroid;
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