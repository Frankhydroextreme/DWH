% Historicalda=imread('I:\CMIP6\Results\Historical\drywetevent_intensities1979-2014.tif');
% R245da=imread('I:\CMIP6\Results\future\SSP2-RCP4.5\drywetevent_intensities2015-2100.tif');
% R585da=imread('I:\CMIP6\Results\future\SSP2-RCP8.5\drywetevent_intensities2015-2100.tif');
% Historical=Historicalda(find(Historicalda>0));
% R245=R245da(find(R245da>0));
% R585=R585da(find(R585da>0));
clear all
clc

for year=2000:5:2015
InPath = fullfile('I:\CMIP6\Results\Historical\drywetevent_counts',num2str(year));
directory = dir(InPath); % 获取文件夹中的文件信息
folderName= directory(1).name; % 获取第一个文件夹的名称
dirNamepath = dir(fullfile(InPath, folderName, '*.tif')); % 获取特定扩展名的文件
filename=([InPath,'/',dirNamepath(1).name]);
[data,R]=geotiffread(filename);
[m,n]=size(data);

sumdata=zeros(m,n);

for k=1:length(dirNamepath)
filename=([InPath,'/',dirNamepath(k).name]);
data=imread(filename);
sumdata=sumdata+data;
end


[Historicalda, R] = geotiffread('I:\CMIP6\Results\Historical\drywetevent_counts1979-2014.tif');
% 获取地理坐标信息
info = geotiffinfo('I:\CMIP6\Results\Historical\drywetevent_counts1979-2014.tif');
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
lat = LatLsatf(positive_values);
lon = LonLsatf(positive_values);

exposurepulation=zeros(m,n);
outputfiles='I:\CMIP6\Results\Historical\drywetevent_counts\2000-2015exposure';
filename=fullfile('I:\CMIP6\历史人口数据集\',['gpw_v4_population_density_adjusted_to_2015_unwpp_country_totals_rev11_' ,num2str(year),'_30_sec','.tif']);
for i=1:length(lat)
%lonpo = ncread(filename, 'lon');
%latpo = ncread(filename, 'lat');
% % 找到经度和纬度最接近目标点的索引
% [~, lon_idx] = min(abs(lonpo - lon(i)));
% [~, lat_idx] = min(abs(latpo - lat(i)));
% 定义提取范围大小
blockSize = 25;
info = geotiffinfo(filename);
xWorldLimits = info.TiePoints.WorldPoints.Y;
yWorldLimits = info.TiePoints.WorldPoints.X;
% 将经纬度转换为图像坐标
%x = round((lon - xWorldLimits(1)) / info.PixelScale(1)) + 1;
%y = round((yWorldLimits(2)-lat) / info.PixelScale(2)) + 1;

x=ceil((max(xWorldLimits)-lat(i))/info.PixelScale(2));
y=ceil((lon(i)-min(yWorldLimits))/info.PixelScale(1));

xStart = x - blockSize;
xEnd = x + blockSize;
yStart = y - blockSize;
yEnd = y + blockSize;

% 定义当前块的PixelRegion参数
pixelRegion = {[xStart, xEnd-1],[yStart, yEnd-1]};

% 读取指定区域的图像数据
population = im2double(imread(filename, 'PixelRegion', pixelRegion));
% % 计算起始索引
% start_lon = lon_idx - radius;
% end_lon =  lon_idx + radius;
% start_lat = lat_idx - radius;
% end_lat =  lat_idx + radius;
% 
% % 读取目标点的数据
% population=ncread(filename,'Band1' ,[start_lon, start_lat], [end_lon - start_lon, end_lat - start_lat]);
population(population<=0)=nan;
expo=eventcount(i).*population;
expoall=nansum(expo,'all');
index=find(positive_values>0);
exposurepulation(index(i))=expoall;

end
geotiffwrite(fullfile(outputfiles,['Hisexposure','_',num2str(year),'.tif']),exposurepulation,R);
end
disp('well done')


