clear all
clc
% InPath1 = 'I:\CMIP6\Results\copularesults\Historical\tif\';
% directory1 = dir(InPath1); % 获取文件夹中的文件信息
% folderName1 = directory1(1).name; % 获取第一个文件夹的名称
% dirNamepath1 = dir(fullfile(InPath1, folderName1, '*.tif')); % 获取特定扩展名的文件
% 
% [~,R]=geotiffread('I:\CMIP6\Results\copularesults\future245\tif\dryhotwet245.TIF');
% for k=1:length(dirNamepath1)
% filename1=([InPath1,'/',dirNamepath1(k).name]);
% data=importdata(filename1);
% data=data*100;
% %data=flipud(data);
% geotiffwrite(['I:\CMIP6\Results\copularesults\Historical\PMF\' dirNamepath1(k).name '.tif'],data,R);
% %geotiffwrite(['I:\585counts.tif'],data,R);
% end
% 
% 
% 


% InPath1 = 'I:\Dryandwet\Globaldrywetindex\第三次计算\第一次\gpm\1';
% InPath2 = 'I:\Dryandwet\Globaldrywetindex\第三次计算\第一次\gpm\2';
% InPath3= 'I:\Dryandwet\Globaldrywetindex\第三次计算\第一次\gpm\3';
% InPath4 = 'I:\Dryandwet\Globaldrywetindex\第三次计算\第一次\gpm\4';
% %InPath5 = 'I:\Dryandwet\Globaldrywetindex\第三次计算\第一次\5';
% 
% 
% directory1 = dir(InPath1); % 获取文件夹中的文件信息
% folderName1 = directory1(1).name; % 获取第一个文件夹的名称
% dirNamepath1 = dir(fullfile(InPath1, folderName1, '*.mat')); % 获取特定扩展名的文件
% dirNamepath2= dir(fullfile(InPath2, folderName1, '*.mat')); % 获取特定扩展名的文件
% dirNamepath3 = dir(fullfile(InPath3, folderName1, '*.mat')); % 获取特定扩展名的文件
% dirNamepath4= dir(fullfile(InPath4, folderName1, '*.mat')); % 获取特定扩展名的文件
%dirNamepath5 = dir(fullfile(InPath5, folderName1, '*.mat')); % 获取特定扩展名的文件
% 
% 
% [~,R]=geotiffread('I:\ARI90\GPMARI_90.tif');
% for k=1:length(dirNamepath1)
% filename1=([InPath1,'/',dirNamepath1(k).name]);
% filename2=([InPath2,'/',dirNamepath2(k).name]);
% filename3=([InPath3,'/',dirNamepath3(k).name]);
% filename4=([InPath4,'/',dirNamepath4(k).name]);
% %filename5=([InPath5,'/',dirNamepath5(k).name]);
% 
% data1=importdata(filename1);data1(isnan(data1))=0;
% data1(1001:end,:)=0;
% data2=importdata(filename2);data2(isnan(data2))=0; data2(1000,:)=0;
% data3=importdata(filename3);data3(isnan(data3))=0; data3(1000,:)=0;
% data4=importdata(filename4);data4(isnan(data4))=0; data4(1000,:)=0;
% %data5=importdata(filename5);data5(isnan(data5))=0; data5(1100,:)=0;
% 
% data=data1+data2+data3+data4;
% lat = -90:0.1:90; 
% lon =-180:0.1:180;
% %data=data';
% data=flipud(data);
% R = georasterref('RasterSize', size(data),'Latlim', [double(min(lat)) double(max(lat))], 'Lonlim', [double(min(lon)) double(max(lon))]); 
% 
% geotiffwrite(['I:\Dryandwet\Globaldrywetindex\第三次计算\第一次\gpm\' dirNamepath1(k).name '.tif'],data,R);
% %geotiffwrite(['I:\585counts.tif'],data,R);
% end

figure(1)
Historicalda=imread('H:\CMIP6\Results\Historical\drywet_duration1979-2014.tif');
R245da=imread('H:\CMIP6\Results\future\SSP2-RCP4.5\drywet_duration2015-2100.tif');
R585da=imread('H:\CMIP6\Results\future\SSP2-RCP8.5\drywet_duration2015-2100.tif');
% 

% Historicalda=imread('I:\CMIP6\Results\copularesults\Historical\tif\hisdryhotwetclip.tif')*100;
% R245da=imread('I:\CMIP6\Results\copularesults\future245\tif\dryhotwet245clip.tif')*100;
% R585da=imread('I:\CMIP6\Results\copularesults\future585\tif\dryhotwet585clip.tif')*100;
% 
% hisindex=find(Historicalda<10&Historicalda>0);
% R245index=find(R245da<10&R245da>0);
% R585index=find(R585da<10&R585da>0);
% 
% Historical=Historicalda(:);Historical(Historical<10)=[];
% R245=R245da(:);R245(R245<10)=[];
% R585=R585da(:);R585(R585<10)=[];

Historical=Historicalda(:);Historical(Historical==0)=[];
R245=R245da(:);R245(R245==0)=[];
R585=R585da(:);R585(R585==0)=[];
log_Historical = log(Historical);
log_R245 = log(R245);
log_R585 = log(R585);
% nanmean(Historical)
% nanmean(R245)
% nanmean(R585)

% Historicalda=imread('I:\CMIP6\Results\copularesults\Historical\tif\hisdryhotwetclip.tif');
% R245da=imread('I:\CMIP6\Results\copularesults\future245\tif\dryhotwet245clip.tif');
% R585da=imread('I:\CMIP6\Results\copularesults\future585\tif\dryhotwet585clip.tif');
% Historical=Historicalda(find(Historicalda>0.1));
% R245=R245da(find(Historicalda>0.1));
% R585=R585da(find(Historicalda>0.1));

CF = colorplus([83,65,42]);
[f1, xi1] = ksdensity(log_Historical);
[f2, xi2] = ksdensity(log_R245);
[f3, xi3] = ksdensity(log_R585);
% density_x1 = ksdensity(x1);
% density_x1(density_x1 < 0) = 0;
% 
% density_x2 = ksdensity(x2);
% density_x2(density_x2 < 0) = 0;
% 
% density_x3 = ksdensity(x3);
% density_x3(density_x3 < 0) = 0;
plot(xi1, f1, 'LineWidth', 2.0,'Color', CF(1, :));
hold on
plot(xi2, f2, 'LineWidth', 2.0,'Color', CF(2, :));
hold on
plot(xi3, f3, 'LineWidth', 2.0,'Color', CF(3, :));

xlabel('对数时间(天)','FontName','SimHei');
ylabel('概率密度','FontName','SimHei');
h=legend({'历史的','SSP245','SSP585'},'FontSize',20,'FontName','SimHei','location','best');   %右上角标注
set(h,'Box','off');
set(gca, 'FontName','SimHei', 'FontSize', 22)
%ylim([0, 0.5]);
%text(0.5,0.6,'(b)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
set(gca, 'Box', 'off', 'FontName', 'SimHei', 'FontSize', 22);
set(gca,'LineWidth',1.5);
print('E:\专利\20240607\【问题清单】一种检测短历时高强度快速干热转湿极端天气技术\2','-dtiff','-painters','-r800')

 figure(2)
% % 假设 Historical、R245 和 R585 是不等长的变量
% max_length = max([length(Historical), length(R245), length(R585)]);
% Historical = [Historical; nan(max_length - length(Historical), 1)];
% R245 = [R245; nan(max_length - length(R245), 1)];
% R585 = [R585; nan(max_length - length(R585), 1)];
% 
% 
% Data=[Historical,R245,R585];
% %Data={Historical,R245,R585};
% %boxplot(Data)
% 
% hb = boxplot(Data,...              
%                     'Color','k',...                                   %箱体边框及异常点颜色
%                     'symbol','.',...                                  %异常点形状
%                     'Notch','on',...                                  %异常点形状
%                     'OutlierSize',4,...                               %是否是凹口的形式展现箱线图，默认非凹口
%                     'labels',{'Historical','SSP245','SSP585'});
% set(hb,'LineWidth',1.5)                                               %箱型图线宽
% 
%  CF = colorplus([83,65,42]);
% h = findobj(gca,'Tag','Box');
% for j = 1:min(size(Data))
%     patch(get(h(j),'XData'),get(h(j),'YData'),CF(j,:),'FaceAlpha',.5);%赋颜色填充箱型图内部
% end
% % 坐标轴美化
% set(gca, 'Box', 'on', ...                                        % 边框
%          'LineWidth', 1,...                                      % 线宽
%          'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
%          'TickDir', 'in', 'TickLength', [.015 .015], ...         % 刻度
%          'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
%          'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % 坐标轴颜色
% 
% % 背景颜色
% hYLabel = ylabel('PMF','FontName','Times New Roman');
% %hXLabel = xlabel('Types of cascading geohazards','FontName','Times New Roman');
% %xlabel('Intensity','FontName','Times New Roman');
% 
% %ylim([0 1]);
% %set(gca,'YTick',[0:0.2:1]);
% set(gca,'FontName','Times New Roman')
% set([hYLabel], 'FontName','Times New Roman')
% set(gca, 'FontSize', 22)
% set([hYLabel], 'FontSize', 22)
% set(gcf,'Color',[1 1 1])
% set(gca,'LineWidth',1.5); 
% %text(1,0.9,'(a)','FontSize',22,'fontname','Times New Roman','FontWeight','bold','FontWeight','bold')




% Data1={ssp245counts(37:end),ssp245duration(37:end),ssp245intensities(37:end)};
% Data2={ssp585counts(37:end),ssp585duration(37:end),ssp585intensities(37:end)};
% Data3={ssp245counts(1:36),ssp245duration(1:36),ssp245intensities(1:36)};

% JP1=joyPlot(Data1,'ColorMode','Order','ColorList',[25,163,185]./255,'MedLine','off','Scatter','OFF');%12,165,154
% JP1=JP1.draw();
% 
% JP2=joyPlot(Data2,'ColorMode','Order','ColorList',[151,220,71]./255,'MedLine','off','Scatter','off');
% JP2=JP2.draw();
% 
% JP3=joyPlot(Data3,'ColorMode','Order','ColorList',[240,189,130]./255,'MedLine','off','Scatter','off');
% JP3=JP3.draw();
% 
% legendHdl1=JP1.getLegendHdl();
% legendHdl2=JP2.getLegendHdl();
% legendHdl3=JP3.getLegendHdl();

%h=legend([legendHdl2(1),legendHdl1(1),legendHdl3(1)],{'SSP585','SSP245','Historical'},'FontSize',18,'fontname','Times New Roman');
%set(h,'Box','off');


% JP=joyPlot(Data,'ColorMode','Order','Scatter','on');
%  JP=joyPlot(Data,'ColorMode','Order');
%  JP=JP.draw();
% % 
%  legendHdl=JP.getLegendHdl();
%  legend([legendHdl(1),legendHdl(2),legendHdl(3)],{'A','B','C'})
% % 
%  ax=gca;
%  xlabel('Distribution of DHP characteristics','FontSize',20,'fontname','Times New Roman');
%  yticklabels({'Frequency', 'Duration', 'Intensity'});
%  ax.XLabel.FontSize=20;
%  ax.YLabel.FontSize=20;
%  set(gca,'FontName','Times New Roman', 'FontSize', 18);
%  set(gca,'LineWidth',1.5); 
% text(0.5, 5, '(d)', 'FontSize', 20, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% disp('done')


% 
% x=2015:2100;
% x1=1979:2014;
% x2=1979:2100;
% 
% subplot(2,2,1)
% 
% plot(x1,ssp245counts(1:36), 'o-','LineWidth',1.5,'MarkerSize', 3,'Color',[240,189,130]./255)
% hold on
% plot(x,ssp245counts(37:end), 'o-','LineWidth',1.5,'MarkerSize', 3,'Color', [12, 165, 154] ./ 255)
% 
% %  zValue=1.96;
% %  n=length(ssp245counts);
% %  fitDelta=(nanstd(ssp245counts)/n)^0.5;
% %  upperConfInt = (ssp245counts + zValue .* fitDelta)';upperConfInt(isnan(upperConfInt))=0;
% %  lowerConfInt = (ssp245counts - zValue .* fitDelta)';lowerConfInt(isnan(lowerConfInt))=0;
% % 
% % hold on
% % fill([x fliplr(x)], [upperConfInt fliplr(lowerConfInt)], 'g', 'EdgeColor', 'none', 'FaceAlpha', 0.55);
% 
% hold on
% plot(x,ssp585counts(37:end), 'o-','LineWidth',1.5, 'MarkerSize', 3,'Color',[151,220,71]./255)
% 
% hismean=nanmean(ssp245counts(1:36));hiscv=nanstd(ssp245counts(1:36))/hismean;
% ssp245mean=nanmean(ssp245counts(37:end));ssp245cv=nanstd(ssp245counts(37:end))/ssp245mean;
% ssp585mean=nanmean(ssp585counts(37:end));ssp585cv=nanstd(ssp585counts(37:end))/ssp585mean;
% 
% % % 计算置信区间
% % n=length(ssp585counts);
% % fitDelta=(nanstd(ssp585counts)/n)^0.5;
% % upperConfInt = (ssp585counts + zValue .* fitDelta)';upperConfInt(isnan(upperConfInt))=0;
% % lowerConfInt = (ssp585counts - zValue .* fitDelta)';lowerConfInt(isnan(lowerConfInt))=0;
% % 
% % hold on
% % fill([x fliplr(x)], [upperConfInt fliplr(lowerConfInt)], 'r', 'EdgeColor', 'none', 'FaceAlpha', 0.55);
% 
% 
% 
% hold off; % 取消保持图形
% ax = gca;
% xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
% ylabel('DHP frequency', 'FontSize', 20, 'FontName', 'Times New Roman');
% set(gca, 'FontSize', 18, 'FontName', 'Times New Roman');
% h = legend('Historical: mean=1.51 cv=0.172', 'SSP245: mean=1.18 cv=0.171', 'SSP585: mean=1.14 cv=0.167', 'FontSize', 18, 'FontName', 'Times New Roman');
% set(gca, 'LineWidth', 1.5);
% text(1962, 2.3, '(a)', 'FontSize', 20, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% % 设置图例位置
% legend('Location', 'Best');
% set(h, 'Box', 'off');
% 
% % 去掉右和上边框
% box off;
% 
% % 设置标注朝外
% set(gca, 'TickDir', 'out');
% 
% 
% 
% subplot(2,2,2)
% 
% plot(x1,ssp245duration(1:36), 'o-','LineWidth',1.5,'MarkerSize', 3,'Color',[240,189,130]./255)
% hold on
% plot(x,ssp245duration(37:end), 'o-','LineWidth',1.5,'MarkerSize', 3, 'Color',[12, 165, 154] ./ 255)
% hold on
% plot(x,ssp585duration(37:end), 'o-','LineWidth',1.5, 'MarkerSize', 3,'Color',[151,220,71]./255)
% hold off; % 取消保持图形
% ax = gca;
% xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
% ylabel('DHP duration', 'FontSize', 20, 'FontName', 'Times New Roman');
% set(gca, 'FontSize', 18, 'FontName', 'Times New Roman');
% h = legend('Historical: mean=6.49  cv=0.180', 'SSP245: mean=5.05  cv=0.187', 'SSP585: mean=4.87 cv=0.185', 'FontSize', 18, 'FontName', 'Times New Roman');
% set(gca, 'LineWidth', 1.5);
% text(1962, 8.5, '(b)', 'FontSize', 20, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% % 设置图例位置
% legend('Location', 'Best');
% set(h, 'Box', 'off');
% 
% % 去掉右和上边框
% box off;
% 
% % 设置标注朝外
% set(gca, 'TickDir', 'out');


% ylabel('DHP duration','FontSize',20,'fontname','Times New Roman');
% xlabel('Year','FontSize',20,'fontname','Times New Roman');
% set(gca,'FontSize',18,'fontname','Times New Roman');
% h=legend('SSP245: mean=162.83 mm cv=0.597', 'SSP585: mean=154.62 mm cv=0.573','FontSize',16,'fontname','Times New Roman');
% set(gca,'LineWidth',1.5); 
% text(1,420,'(a)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')
% % 设置图例位置
% legend('Location', 'Best');
% set(h,'Box','off');



% subplot(2,2,3)
% plot(x1,ssp245intensities(1:36), 'o-','LineWidth',1.5,'MarkerSize', 3,'Color',[240,189,130]./255)
% hold on 
% 
% plot(x,ssp245intensities(37:end), 'o-','LineWidth',1.5,'MarkerSize', 3,'Color', [12, 165, 154] ./ 255)
% hold on
% plot(x,ssp585intensities(37:end), 'o-','LineWidth',1.5, 'MarkerSize', 3,'Color',[151,220,71]./255)

% 
% hold on
% % 计算线性趋势
% % 找到不包含 NaN 值的索引
% validIndices = ~isnan(ssp245intensities);
% 
% % 基于有效的索引来更新 x2 和 ssp245intensities
% x2 = x2(validIndices);
% ssp245intensities = ssp245intensities(validIndices);
% coefficients = polyfit(x2, ssp245intensities, 1);
% trend = polyval(coefficients, x2);
% 
% % 绘制线性趋势线
% plot(x2, trend, 'r', 'LineWidth', 1.5);


% hold off; % 取消保持图形
% ax = gca;
% xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
% ylabel('DHP intensity', 'FontSize', 20, 'FontName', 'Times New Roman');
% set(gca, 'FontSize', 18, 'FontName', 'Times New Roman');
% h = legend('Historical: mean=0.05  cv=1.666', 'SSP245: mean=0.35  cv=3.446', 'SSP585: mean=0.57 cv=3.567', 'FontSize', 18, 'FontName', 'Times New Roman');
% set(gca, 'LineWidth', 1.5);
% text(1962, 14, '(c)', 'FontSize', 20, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% % 设置图例位置
% legend('Location', 'Best');
% set(h, 'Box', 'off');
% 
% % 去掉右和上边框
% box off;
% 
% % 设置标注朝外
% set(gca, 'TickDir', 'out');





figure(2)


Historicalda=imread('H:\CMIP6\Results\Historical\drywetevent_intensities1979-2014.tif');
R245da=imread('H:\CMIP6\Results\future\SSP2-RCP4.5\drywetevent_intensities2015-2100.tif');
R585da=imread('H:\CMIP6\Results\future\SSP2-RCP8.5\drywetevent_intensities2015-2100.tif');
Historical=Historicalda(find(Historicalda>0));
R245=R245da(find(R245da>0));
R585=R585da(find(R585da>0));

hismean=mean(Historical,'all');
R245mean=mean(R245,'all');
R585mean=mean(R585,'all');

hissum=sum(sum(Historical,'all'));
R245sum=sum(sum(R245,'all'));
R585sum=sum(sum(R585,'all'));

max_length = max([length(Historical), length(R245), length(R585)]);
Historical = [Historical; nan(max_length - length(Historical), 1)];
R245 = [R245; nan(max_length - length(R245), 1)];
R585 = [R585; nan(max_length - length(R585), 1)];
data=[Historical,R245,R585];


% subplot(1,2,1)

%subplot(1,2,2)
x1=data(:,1);
x2=data(:,2);
x3=data(:,3);

% [D_U1, PD_U1]= allfitdist(x1);
% [D_U2, PD_U2]= allfitdist(x2);
% [D_U3, PD_U3]= allfitdist(x3);
 % [D_U1, PD_U1]= allfitdist(data(:,i),'DISCRETE','PDF');这是针对离散性分布
% Check if inverse is also OK
% EP1 = cdf(PD_U1{1},x1); 
% EP2 = cdf(PD_U2{1},x2); 
% EP3 = cdf(PD_U3{1},x3); 

% 1. 计算数据的均值和标准差



[f1, xi1] = ksdensity(x1);
[f2, xi2] = ksdensity(x2);
[f3, xi3] = ksdensity(x3);
% density_x1 = ksdensity(x1);
% density_x1(density_x1 < 0) = 0;
% 
% density_x2 = ksdensity(x2);
% density_x2(density_x2 < 0) = 0;
% 
% density_x3 = ksdensity(x3);
% density_x3(density_x3 < 0) = 0;
plot(xi1, f1, 'LineWidth', 2.0,'Color', CF(1, :));
hold on
plot(xi2, f2, 'LineWidth', 2.0,'Color', CF(2, :));
hold on
plot(xi3, f3, 'LineWidth', 2.0,'Color', CF(3, :));


%  histogram(x1,'FaceColor','Green')
%  hold on
%  histogram(x2,'FaceColor','yellow')
%  hold on
%  histogram(x3,'FaceColor','blue')

%plot(linspace(min(x1), max(x1), numel(density_x1)), density_x1, 'LineWidth', 2.0,'Color', CF(5, :));
%hold on
%plot(linspace(min(x2), max(x2), numel(density_x2)), density_x2, 'LineWidth', 2.0,'Color', CF(4, :));
%hold on
%plot(linspace(min(x3), max(x3), numel(density_x3)), density_x3, 'LineWidth', 2.0,'Color', CF(3, :));
%hold on

