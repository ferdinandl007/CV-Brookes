set = 1;




 image_folder = 'TennisSet1'; 


filenames = dir(fullfile(image_folder, '*.ppm'));  
total_images = numel(filenames);
%%
lx = 151.4160;
ly = 149.7528;
spendx = [];
spendy = [];

prev_posPedal = [0 0];
prev_posPingpong = [0 0];

count = 0;

zoom_factor = [0.5 0.8]


for i2 = 1 : total_images
  f= fullfile(image_folder, filenames(i2).name);
  count = count + 1
  %processmyimage(imread(f));
%  [sx,sy] = doSomeprocess(imread(f));
 
 [posPingpong posPedal] = GetBatPosition(imread(f))
 
 posdPedal = posPedal - prev_posPedal./24;
 posdPingpong = posPingpong - prev_posPingpong./24;
 
%  sPedal = sqrt(posdPedal(0)^2 - posdPedal(1)^2);
%  sPingpong = sqrt(posdPingping(0)^2 - posdPingping(1)^2);
 
 sPedal = 0;
 sPingpong = 0;
 
 if (set == 0)
    sPedal = norm(posdPedal) * 0.22;
    sPingpong = norm(posdPingpong) * 0.22;
    if (count > 8)
        sPedal = sPedal * ((count - 8) * zoom_factor);
        sPingpong = sPingpong;
    end 
 else 
    sPedal = norm(posdPedal) * 0.22;
    sPingpong = norm(posdPingpong) * 0.22;
 end 
 
 spendx = [spendx sPedal];
 spendy = [spendy sPingpong];
 
 prev_posPingpong = posPingpong;
 prev_posPedal = posPedal;
 

end
figure
title("sPingpong")
plot(spendy)
figure
title("sPedal")
plot(spendx)
Pedalspeedmean = mean(spendx)
Pingpongballspeedmean = mean(spendy)

