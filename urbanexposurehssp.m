% Historicalda=imread('I:\CMIP6\Results\Historical\drywetevent_intensities1979-2014.tif');
% R245da=imread('I:\CMIP6\Results\future\SSP2-RCP4.5\drywetevent_intensities2015-2100.tif');
% R585da=imread('I:\CMIP6\Results\future\SSP2-RCP8.5\drywetevent_intensities2015-2100.tif');
% Historical=Historicalda(find(Historicalda>0));
% R245=R245da(find(R245da>0));
% R585=R585da(find(R585da>0));
clear all
clc
data=[19	19
268	268
30	30
1232	1232
952	952
272	272
319	319
317	317
183	183
207	207
703	703
186	186
329	329
386	386
372	1938
2275	1360
2709	242
682	1305
270	9660
3032	3300
6485	1089
1232	1577
347	1827
];
x1=2001:2014;
x2=2020:10:2100;
x=[x1,x2];

plot(x,data(:, 2), 'o-','LineWidth',2,'MarkerSize', 3,'Color', [12, 165, 154] ./ 255)
hold on
plot(x,data(:, 1), 'o-','LineWidth',2,'MarkerSize', 3,'Color',[240,189,130]./255)
hold on

plot(x1,data(1:14, 1), 'o-','LineWidth',2,'MarkerSize', 3,'Color',[35,104,166]./255)
set(gca, 'FontSize', 22, 'FontName', 'Times New Roman');
xlabel('年份', 'FontSize', 20, 'FontName', 'SimHei');
ylabel('城市暴露面积 (km^2)', 'FontSize', 20, 'FontName', 'SimHei');
%
h = legend(  'SSP585: mean=2477.56 ','SSP245: mean=1933.78 ','历史的: mean=358.92 ', 'FontSize', 21, 'FontName', 'SimHei');
set(gca, 'LineWidth', 1.5);
%text(2000, 2.3, '(e)', 'FontSize', 24, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');

% 去掉右和上边框
box off;



timeurbanarea=[];
positivecounts=[];
for year=2020:10:2100
InPath = fullfile('I:\CMIP6\Results\future\SSP2-RCP4.5\drywetevent_counts',num2str(year));
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
outputfiles='I:\CMIP6\Results\urbanarea\ssp585';
filename=fullfile('I:\CMIP6\土地利用数据集\未来\Global-urban-product_SSPs_2015_2100\SSP2re\',['global_SSP2_' ,num2str(year),'.tif']);

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
urban = imread(filename, 'PixelRegion', pixelRegion);
% % 计算起始索引
start_lon = lon_idx - radius;
end_lon =  lon_idx + radius;
start_lat = lat_idx - radius;
end_lat =  lat_idx + radius;
% 
% % 读取目标点的数据
population=ncread(filename,'Band1' ,[start_lon, start_lat], [end_lon - start_lon, end_lat - start_lat]);
% population(population<=0)=nan;
% expo=eventcount(i).*population;
% expoall=nansum(expo,'all');
urindex=find(urban==2);
urban=length(urindex)*1;

index=find(positive_values>0);
positive=length(index);
exposurepulation(index(i))=urban;

end
timeurban=nansum(nansum(exposurepulation));
timeurbanarea=[timeurbanarea;timeurban];
positivecounts=[positivecounts;positive];
%geotiffwrite(fullfile(outputfiles,['exposure585','_',num2str(year),'.tif']),exposurepulation,R);
end
disp('well done')


