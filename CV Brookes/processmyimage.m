
function processmyimage(Image)

% RGB to grayscale.
    grayImage = rgb2gray(Image);
%  To duble precision.
    dubleimage = im2double(grayImage);
    figure(1)
    imshow(dubleimage)

%% (b) Applies an appropriate noise filter - explain the reasons for your choice in your report.
    figure(2)
    wiener = wiener2(dubleimage,[5 5]); 
    title('Portion of the Image with Noise Removed by Wiener Filter');
    imshow(wiener)
%% (c) Uses an appropriate threshold to convert the image to binary - explain your choice in your report.
    bit = im2bw(wiener,graythresh(wiener));
    figure(3);
    imshow(bit)
    % a BETTER SOLUTION!
    figure(14);
    imhist(wiener)
    BW = MakeMask(Image);
    bw= bwareaopen(BW,300);

    figure(4)
    imshow(bw)

%% Labels the objects present in the binary image – illustrate and motivate the methodology used in the report


    labels = bwlabel(bw);

    er = regionprops(labels, 'Centroid');

    mystats = regionprops('table',labels,'Centroid',...
    'MajorAxisLength','MinorAxisLength', 'Orientation','Area')



    figure(5)
    imshow(labels)


%% (e) For each of the resulting objects determines their properties, such as size, orientation, elongation etc. (compare what discussed in Week 6). Select only those properties that you think are useful to discriminate the different objects of interest (in particular the ball and the bat). List those properties in a table in your report.
    hold on
    for k = 1:numel(er)
    cl = er(k).Centroid;
    text(cl(1), cl(2), sprintf('%d', k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle');
    end
    hold off


    hold off
%% Based on the properties listed in the table explain how you would uniquely identify each object, and particularly the two objects of interest, the ball and the bat
    Pedal=(labels==2);
    Pingpong=(labels==3);
    figure(7)
    imshow(Pingpong)
    Pingpongstats = regionprops('table',Pingpong,'Centroid',...
       'MajorAxisLength','MinorAxisLength', 'Orientation','Area')
    figure(8)
    imshow(Pedal)
    PedalStats = regionprops('table',Pedal,'Centroid',...
    'MajorAxisLength','MinorAxisLength', 'Orientation','Area')


end


