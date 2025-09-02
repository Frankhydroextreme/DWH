
clear all
clc

timeurbanarea=[];
dhwcounts=[];
timenonurbanarea=[];

%liuyu = shaperead;

for year=2015:2100


%fullfile('H:\CMIP6\Results\Historical\drywetevent_counts',num2str(year));
%filename=fullfile('H:\CMIP6\Results\Historical\drywetevent_counts\2000-2015daily\',['drywetevent_counts_' ,num2str(year),'.tif']);
filename=fullfile('H:\CMIP6\Results\future\SSP2-RCP8.5\drywetevent_counts\',['drywetevent_counts_' ,num2str(year),'.tif']);
% for k=1:length(dirNamepath)
% filename=([InPath,'/',dirNamepath(k).name]);
data=imread(filename);
sumdata=data;
[m,n]=size(data);

[Historicalda, R] = geotiffread('H:\CMIP6\Results\Historical\drywetevent_counts1979-2014.tif');
% 获取地理坐标信息
info = geotiffinfo('H:\CMIP6\Results\Historical\drywetevent_counts1979-2014.tif');
Ls=size(Historicalda);
lat1 = [info.CornerCoords.Lat(1) info.CornerCoords.Lat(2); info.CornerCoords.Lat(4) info.CornerCoords.Lat(3)];
lon1 = [info.CornerCoords.Lon(1) info.CornerCoords.Lon(2); info.CornerCoords.Lon(4) info.CornerCoords.Lon(3)];
[Xi,Yi] = meshgrid(1:2,1:2);
[XI,YI] = meshgrid(1:1/(Ls(2)-1):2,1:1/(Ls(1)-1):2);
LatLsatf = interp2(Xi,Yi,lat1,XI,YI);
LonLsatf = interp2(Xi,Yi,lon1,XI,YI);
% 获取大于0的像素

positive_values = sumdata > 0;
eventcount=sumdata(positive_values);
zeros_values = sumdata== 0;

lat1 = LatLsatf(positive_values);
lon1 = LonLsatf(positive_values);

lat2 = LatLsatf(zeros_values);
lon2 = LonLsatf(zeros_values);


urbanarea=zeros(m,n);
nonurbanarea=zeros(m,n);
if year<=2020
    yea=2020;
elseif year > 2020 && year <= 2030
    yea=2030;
elseif year > 2030 && year <= 2040
    yea=2040;
elseif year > 2040 && year <= 2050
    yea=2050;
elseif year > 2050 && year <= 2060
    yea=2060;   
elseif year > 2060 && year <= 2070
    yea=2070;  
elseif year > 2070 && year <= 2080
    yea=2080;  
elseif year > 2080 && year <= 2090
    yea=2090;   
else
    yea=2100;
end

if isempty(lat1) && isempty(lon1)
    positive = NaN; % 如果 lat1 和 lon1 都为空，则 positive 设置为 NaN
else

%filename1=fullfile('H:\CMIP6\landcovertypes\histric\landcover1000m\hkl1000\',['MODIS_LANDCOVER' ,num2str(year),'.tif']);
filename1=fullfile('H:\CMIP6\landcovertypes\future\Global-urban-product_SSPs_2015_2100\SSP5re\',['global_SSP5_' ,num2str(yea),'.tif']);


for i=1:length(lat1)
%lonpo = ncread(filename, 'lon');
%latpo = ncread(filename, 'lat');
% % 找到经度和纬度最接近目标点的索引
% [~, lon_idx] = min(abs(lonpo - lon(i)));
% [~, lat_idx] = min(abs(latpo - lat(i)));
% 定义提取范围大小
blockSize = 13;
info = geotiffinfo(filename1);
xWorldLimits = info.TiePoints.WorldPoints.Y;
yWorldLimits = info.TiePoints.WorldPoints.X;
% 将经纬度转换为图像坐标
%x = round((lon - xWorldLimits(1)) / info.PixelScale(1)) + 1;
%y = round((yWorldLimits(2)-lat) / info.PixelScale(2)) + 1;

x=ceil((max(xWorldLimits)-lat1(i))/info.PixelScale(2));
y=ceil((lon1(i)-min(yWorldLimits))/info.PixelScale(1));

xStart = x - blockSize;
xEnd = x + blockSize;
yStart = y - blockSize;
yEnd = y + blockSize;

% 定义当前块的PixelRegion参数
pixelRegion = {[xStart, xEnd-1],[yStart, yEnd-1]};

% 读取指定区域的图像数据
urban = imread(filename1, 'PixelRegion', pixelRegion);

index1=find(urban==2);
urban1=length(index1)*1;

index2=find(urban1~=2);
nourban=length(index2)*1;

%历史数据是modis
% index1=find(urban==13);
% urban1=length(index1)*1;
% 
% index2=find(urban~=13);
% nourban=length(index2)*1;

% % 计算起始索引
% start_lon = lon_idx - radius;
% end_lon =  lon_idx + radius;
% start_lat = lat_idx - radius;
% end_lat =  lat_idx + radius;
% 
% % 读取目标点的数据
% population=ncread(filename,'Band1' ,[start_lon, start_lat], [end_lon - start_lon, end_lat - start_lat]);
% population(population<=0)=nan;
% expo=eventcount(i).*population;
% expoall=nansum(expo,'all');

index=find(positive_values>0);
positive=length(index);
%expoall=nansum(expo,'all');
urbanarea(index(i))=urban1;
nonurbanarea(index(i))=nourban;

end
    
end

timeurban=nansum(nansum(urbanarea));
timeurbanarea=[timeurbanarea;timeurban];

timenonurban=nansum(nansum(nonurbanarea));
timenonurbanarea=[timenonurbanarea;timenonurban];

dhwcounts=[dhwcounts;positive];

%geotiffwrite(fullfile(outputfiles,['urbanareaexposure','_',num2str(year),'.tif']),urbanarea,R);
%end

% 使用 sprintf 将文本和变量值组合成字符串
message = sprintf('%s has been ''well done''', num2str(year));

% 使用 disp 显示组合后的字符串
disp(message);

end






% %未来的面积统计
% timeurbanarea=[];
% positivecounts=[];
% for year=2020:10:2100
% InPath = fullfile('H:\CMIP6\Results\future\SSP2-RCP4.5\drywetevent_counts',num2str(year));
% directory = dir(InPath); % 获取文件夹中的文件信息
% folderName= directory(1).name; % 获取第一个文件夹的名称
% dirNamepath = dir(fullfile(InPath, folderName, '*.tif')); % 获取特定扩展名的文件
% filename=([InPath,'/',dirNamepath(1).name]);
% [data,R]=geotiffread(filename);
% [m,n]=size(data);
% 
% sumdata=zeros(m,n);
% 
% for k=1:length(dirNamepath)
% filename=([InPath,'/',dirNamepath(k).name]);
% data=imread(filename);
% sumdata=sumdata+data;
% end
% 
% 
% [Historicalda, R] = geotiffread('H:\CMIP6\Results\Historical\drywetevent_counts1979-2014.tif');
% % 获取地理坐标信息
% info = geotiffinfo('H:\CMIP6\Results\Historical\drywetevent_counts1979-2014.tif');
% Ls=size(Historicalda);
% lat1 = [info.CornerCoords.Lat(1) info.CornerCoords.Lat(2); info.CornerCoords.Lat(4) info.CornerCoords.Lat(3)];
% lon1 = [info.CornerCoords.Lon(1) info.CornerCoords.Lon(2); info.CornerCoords.Lon(4) info.CornerCoords.Lon(3)];
% [Xi,Yi] = meshgrid(1:2,1:2);
% [XI,YI] = meshgrid(1:1/(Ls(2)-1):2,1:1/(Ls(1)-1):2);
% LatLsatf = interp2(Xi,Yi,lat1,XI,YI);
% LonLsatf = interp2(Xi,Yi,lon1,XI,YI);
% % 获取大于0的像素
% 
% positive_values = sumdata > 0;
% eventcount=sumdata(positive_values);
% lat1 = LatLsatf(positive_values);
% lon1 = LonLsatf(positive_values);
% 
% exposurepulation=zeros(m,n);
% outputfiles='H:\CMIP6\Results\urbanarea\ssp585';
% filename=fullfile('H:\CMIP6\土地利用数据集\未来\Global-urban-product_SSPs_2015_2100\SSP2re\',['global_SSP2_' ,num2str(year),'.tif']);
% 
% for i=1:length(lat1)
% %lonpo = ncread(filename, 'lon');
% %latpo = ncread(filename, 'lat');
% % % 找到经度和纬度最接近目标点的索引
% % [~, lon_idx] = min(abs(lonpo - lon(i)));
% % [~, lat_idx] = min(abs(latpo - lat(i)));
% % 定义提取范围大小
% blockSize = 12;
% info = geotiffinfo(filename);
% xWorldLimits = info.TiePoints.WorldPoints.Y;
% yWorldLimits = info.TiePoints.WorldPoints.X;
% % 将经纬度转换为图像坐标
% %x = round((lon - xWorldLimits(1)) / info.PixelScale(1)) + 1;
% %y = round((yWorldLimits(2)-lat) / info.PixelScale(2)) + 1;
% 
% x=ceil((max(xWorldLimits)-lat1(i))/info.PixelScale(2));
% y=ceil((lon1(i)-min(yWorldLimits))/info.PixelScale(1));
% 
% xStart = x - blockSize;
% xEnd = x + blockSize;
% yStart = y - blockSize;
% yEnd = y + blockSize;
% 
% % 定义当前块的PixelRegion参数
% pixelRegion = {[xStart, xEnd-1],[yStart, yEnd-1]};
% 
% % 读取指定区域的图像数据
% urban = imread(filename, 'PixelRegion', pixelRegion);
% % % 计算起始索引
% start_lon = lon_idx - radius;
% end_lon =  lon_idx + radius;
% start_lat = lat_idx - radius;
% end_lat =  lat_idx + radius;
% % 
% % % 读取目标点的数据
% population=ncread(filename,'Band1' ,[start_lon, start_lat], [end_lon - start_lon, end_lat - start_lat]);
% % population(population<=0)=nan;
% % expo=eventcount(i).*population;
% % expoall=nansum(expo,'all');
% urindex=find(urban==2);
% urban=length(urindex)*1;
% 
% index=find(positive_values>0);
% positive=length(index);
% exposurepulation(index(i))=urban;
% 
% end
% timeurban=nansum(nansum(exposurepulation));
% timeurbanarea=[timeurbanarea;timeurban];
% positivecounts=[positivecounts;positive];
% %geotiffwrite(fullfile(outputfiles,['exposure585','_',num2str(year),'.tif']),exposurepulation,R);
% end
% disp('well done')


