videoPlayer = vision.VideoPlayer;

inputvideo=vision.VideoFileReader('shuttle_out.avi');

vid1=vision.VideoPlayer;
while ~isDone(inputvideo)
    frame1=step(inputvideo);
    step(vid1,frame1);
    pause(0.005);
end

imwrite(frame1,'referenceimage.jpg','jpg');
release(inputvideo);
release(vid1);
refrenceimage=imread('referenceimage.jpg');

vid2=vision.VideoFileReader('shuttle_out.avi');
%%
for i=2:20
    clc
    frame= step(vid2);
    frame2=((im2double(frame))-(im2double(refrenceimage)));
    imshow(frame2)
    frame1=im2bw(frame2,0.2)
    imshow(frame1);
    [labelimage]=bwlabel(frame1);
    stats=regionprops(labelimage,'basic')
    BB=stats.BoundingBox;
    X(i)=BB(1);
    Y(i)=BB(2);
    Dist=((X(i)-X(i-1))^2+(Y(i)-Y(i-1))^2)^(1/2);% distance formula in fps
    Z(i)=Dist;
if(Dist>10 &&Dist<20)
        display('average Speed')
elseif(Dist<10)
        display('Slow Speed')
else
        display('Fast Speed')
end
    S=strel('disk',2)
    frame3=imclose(frame1,S);
    step(vid1,frame1);
    pause(0.05);
end

M=median(Z);
Speed_of_ball=(M)*(21/2)% speed of the ball
release(vid1)

xyloObj = VideoReader('shuttle_out.avi');
info = get(xyloObj);

duration = xyloObj.Duration
