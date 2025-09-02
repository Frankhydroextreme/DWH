clear all
clc
close all

Historicalda=imread('H:\CMIP6\Results\exposure\His\Hisexposure.tif');
R245da=imread('H:\CMIP6\Results\exposure\ssp245\exposure245.tif');
R585da=imread('H:\CMIP6\Results\exposure\ssp585\exposure585.tif');
Historical=Historicalda(find(Historicalda>0));
R245=R245da(find(R245da>0));
R585=R585da(find(R585da>0));

hismean=mean(Historical,'all');
R245mean=mean(R245,'all');
R585mean=mean(R585,'all');

hissum=sum(sum(Historical,'all'));
R245sum=sum(sum(R245,'all'));
R585sum=sum(sum(R585,'all'));




InPath1 ='H:\CMIP6\Results\Time\SSP245counts';
directory1 = dir(InPath1); % 获取文件夹中的文件信息
folderName1= directory1(1).name; % 获取第一个文件夹的名称
dirNamepath1 = dir(fullfile(InPath1, folderName1, '*.tif')); % 获取特定扩展名的文件
filename1=([InPath1,'/',dirNamepath1(1).name]);

InPath2 ='H:\CMIP6\Results\Time\SSP585counts';
directory2 = dir(InPath2); % 获取文件夹中的文件信息
folderName2= directory2(1).name; % 获取第一个文件夹的名称
dirNamepath2 = dir(fullfile(InPath2, folderName2, '*.tif')); % 获取特定扩展名的文件
filename2=([InPath2,'/',dirNamepath2(1).name]);


InPath3 ='H:\CMIP6\Results\Time\SSP245duration';
directory3 = dir(InPath3); % 获取文件夹中的文件信息
folderName3= directory3(1).name; % 获取第一个文件夹的名称
dirNamepath3 = dir(fullfile(InPath3, folderName3, '*.tif')); % 获取特定扩展名的文件
filename3=([InPath3,'/',dirNamepath3(1).name]);

InPath4 ='H:\CMIP6\Results\Time\SSP585duration';
directory4 = dir(InPath4); % 获取文件夹中的文件信息
folderName4= directory4(1).name; % 获取第一个文件夹的名称
dirNamepath4 = dir(fullfile(InPath4, folderName4, '*.tif')); % 获取特定扩展名的文件
filename4=([InPath4,'/',dirNamepath4(1).name]);


InPath5 ='H:\CMIP6\Results\Time\SSP245intensities';
directory5= dir(InPath5); % 获取文件夹中的文件信息
folderName5= directory5(1).name; % 获取第一个文件夹的名称
dirNamepath5 = dir(fullfile(InPath5, folderName5, '*.tif')); % 获取特定扩展名的文件
filename5=([InPath5,'/',dirNamepath5(1).name]);

InPath6 ='H:\CMIP6\Results\Time\SSP585intensities';
directory6 = dir(InPath6); % 获取文件夹中的文件信息
folderName6= directory6(1).name; % 获取第一个文件夹的名称
dirNamepath6 = dir(fullfile(InPath6, folderName6, '*.tif')); % 获取特定扩展名的文件
filename6=([InPath6,'/',dirNamepath6(1).name]);

%[m,n]=size(data);

ssp245counts=[];
ssp585counts=[];

ssp245duration=[];
ssp585duration=[];

ssp245intensities=[];
ssp585intensities=[];

for k=1:length(dirNamepath1)
filename1=([InPath1,'/',dirNamepath1(k).name]);
da1=imread(filename1);
data1=da1(find(da1>0));
meandata1=nanmean(data1,'all');

filename2=([InPath2,'/',dirNamepath2(k).name]);
da2=imread(filename2);
data2=da2(find(da2>0));
meandata2=nanmean(data2,'all');

ssp245counts=[ssp245counts;meandata1];
ssp585counts=[ssp585counts;meandata2];

filename3=([InPath3,'/',dirNamepath3(k).name]);
da3=imread(filename3);
data3=da3(find(da3>0));
meandata3=nanmean(data3,'all');

filename4=([InPath4,'/',dirNamepath4(k).name]);
da4=imread(filename4);
data4=da4(find(da4>0));
meandata4=nanmean(data4,'all');

ssp245duration=[ssp245duration;meandata3];
ssp585duration=[ssp585duration;meandata4];

filename5=([InPath5,'/',dirNamepath5(k).name]);
da5=imread(filename5);
data5=da5(find(da5>0));
meandata5=nanmean(data5,'all');

filename6=([InPath6,'/',dirNamepath6(k).name]);
da6=imread(filename6);
data6=da6(find(da6>0));
meandata6=nanmean(data6,'all');

ssp245intensities=[ssp245intensities;meandata5];
ssp585intensities=[ssp585intensities;meandata6];


end

ssp245counts=fillmissing(ssp245counts,'movmean',3);
ssp585counts=fillmissing(ssp585counts,'movmean',3);

ssp245duration=fillmissing(ssp245duration,'movmean',3);
ssp585duration=fillmissing(ssp585duration,'movmean',3);

ssp245intensities=fillmissing(ssp245intensities,'movmean',3);
ssp585intensities=fillmissing(ssp585intensities,'movmean',3);
x=2015:2100;
x1=1979:2014;


%x=37:122;
%x1=1:36;

subplot(2,2,1)

plot(x1,ssp245counts(1:36), 'o-','LineWidth',2,'MarkerSize', 3,'Color',[240,189,130]./255)
hold on
plot(x,ssp245counts(37:end), 'o-','LineWidth',2,'MarkerSize', 3,'Color', [12, 165, 154] ./ 255)
hold on
plot(x,ssp585counts(37:end), 'o-','LineWidth',2, 'MarkerSize', 3,'Color',[151,220,71]./255)



%  zValue=1.96;
%  n=length(ssp245counts(1:36));
%  fitDelta=(nanstd(ssp245counts(1:36))/n)^0.5;
%  upperConfInt = (ssp245counts(1:36) + zValue .* fitDelta)';upperConfInt(isnan(upperConfInt))=0;
%  lowerConfInt = (ssp245counts(1:36) - zValue .* fitDelta)';lowerConfInt(isnan(lowerConfInt))=0;
% 
% hold on
% fill([x1 fliplr(x1)], [upperConfInt fliplr(lowerConfInt)], 'g', 'EdgeColor', 'none', 'FaceAlpha', 0.55);



hismean=nanmean(ssp245counts(1:36));hiscv=nanstd(ssp245counts(1:36))/hismean;
ssp245mean=nanmean(ssp245counts(37:end));ssp245cv=nanstd(ssp245counts(37:end))/ssp245mean;
ssp585mean=nanmean(ssp585counts(37:end));ssp585cv=nanstd(ssp585counts(37:end))/ssp585mean;

% % 计算置信区间
% n=length(ssp585counts);
% fitDelta=(nanstd(ssp585counts)/n)^0.5;
% upperConfInt = (ssp585counts + zValue .* fitDelta)';upperConfInt(isnan(upperConfInt))=0;
% lowerConfInt = (ssp585counts - zValue .* fitDelta)';lowerConfInt(isnan(lowerConfInt))=0;
% 
% hold on
% fill([x fliplr(x)], [upperConfInt fliplr(lowerConfInt)], 'r', 'EdgeColor', 'none', 'FaceAlpha', 0.55);



hold off; % 取消保持图形
ax = gca;
xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
ylabel('DHW frequency', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
h = legend('Historical: mean=1.51 cv=0.172', 'SSP245: mean=1.18 cv=0.171', 'SSP585: mean=1.14 cv=0.167', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'LineWidth', 2);
% hold on
% plot (ssp245counts(1:36)-detrend(ssp245counts(1:36)),'linewidth',2,'Color',[240,189,130]./255,'linestyle','--')
% hold on
% plot (ssp245counts(37:end)-detrend(ssp245counts(37:end)),'linewidth',2,'Color',[12, 165, 154] ./ 255,'linestyle','--')
% hold on
% plot (ssp585counts(37:end)-detrend(ssp585counts(37:end)),'linewidth',2,'Color',[151,220,71]./255,'linestyle','--')

text(1962, 2.3, '(a)', 'FontSize', 24, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');

% 去掉右和上边框
box off;

% 设置标注朝外
set(gca, 'TickDir', 'out');



subplot(2,2,2)

plot(x1,ssp245duration(1:36), 'o-','LineWidth',2,'MarkerSize', 3,'Color',[240,189,130]./255)
hold on
plot(x,ssp245duration(37:end), 'o-','LineWidth',2,'MarkerSize', 3, 'Color',[12, 165, 154] ./ 255)
hold on
plot(x,ssp585duration(37:end), 'o-','LineWidth',2, 'MarkerSize', 3,'Color',[151,220,71]./255)
hold off; % 取消保持图形
ax = gca;
xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
ylabel('DHW duration', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
h = legend('Historical: mean=6.49  cv=0.180', 'SSP245: mean=5.05  cv=0.187', 'SSP585: mean=4.87 cv=0.185', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'LineWidth', 2);

% hold on
% plot (ssp245duration(1:36)-detrend(ssp245duration(1:36)),'linewidth',2,'Color',[240,189,130]./255,'linestyle','--')
% hold on
% plot (ssp245duration(37:end)-detrend(ssp245duration(37:end)),'linewidth',2,'Color',[12, 165, 154] ./ 255,'linestyle','--')
% hold on
% plot (ssp585duration(37:end)-detrend(ssp585duration(37:end)),'linewidth',2,'Color',[151,220,71]./255,'linestyle','--')

text(1962, 8.5, '(b)', 'FontSize', 24, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');

% 去掉右和上边框
box off;

% 设置标注朝外
set(gca, 'TickDir', 'out');

% ylabel('DHP duration','FontSize',20,'fontname','Times New Roman');
% xlabel('Year','FontSize',20,'fontname','Times New Roman');
% set(gca,'FontSize',18,'fontname','Times New Roman');
% h=legend('SSP245: mean=162.83 mm cv=0.597', 'SSP585: mean=154.62 mm cv=0.573','FontSize',16,'fontname','Times New Roman');
% set(gca,'LineWidth',1.5); 
% text(1,420,'(a)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')
% % 设置图例位置
% legend('Location', 'Best');
% set(h,'Box','off');


subplot(2,2,3)
plot(x1,ssp245intensities(1:36), 'o-','LineWidth',2,'MarkerSize', 3,'Color',[240,189,130]./255)
hold on 

plot(x,ssp245intensities(37:end), 'o-','LineWidth',2,'MarkerSize', 3,'Color', [12, 165, 154] ./ 255)
hold on
plot(x,ssp585intensities(37:end), 'o-','LineWidth',2, 'MarkerSize', 3,'Color',[151,220,71]./255)

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


hold off; % 取消保持图形
ax = gca;
xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
ylabel('DHW intensity', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
h = legend('Historical: mean=0.05  cv=1.666', 'SSP245: mean=0.35  cv=3.446', 'SSP585: mean=0.57 cv=3.567', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'LineWidth', 2);

% hold on
% plot (ssp245intensities(1:36)-detrend(ssp245intensities(1:36)),'linewidth',2,'Color',[240,189,130]./255,'linestyle','--')
% hold on
% plot (ssp245intensities(37:end)-detrend(ssp245intensities(37:end)),'linewidth',2,'Color',[12, 165, 154] ./ 255,'linestyle','--')
% hold on
% plot (ssp585intensities(37:end)-detrend(ssp585intensities(37:end)),'linewidth',2,'Color',[151,220,71]./255,'linestyle','--')


text(1962, 14, '(c)', 'FontSize', 24, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');

% 去掉右和上边框
box off;

% 设置标注朝外
set(gca, 'TickDir', 'out');


subplot(2,2,4)

%Data={ssp245counts,ssp585counts,ssp245duration,ssp585duration,ssp245intensities,ssp585intensities};
Data1={ssp245counts(1:36),ssp245counts(37:end),ssp585counts(37:end)};
Data2={ssp245duration(1:36),ssp245duration(37:end),ssp585duration(37:end)};
Data3={ssp245intensities(1:36),ssp245intensities(37:end),ssp585intensities(37:end)};

% Data1={ssp245counts(37:end),ssp245duration(37:end),ssp245intensities(37:end)};
% Data2={ssp585counts(37:end),ssp585duration(37:end),ssp585intensities(37:end)};
% Data3={ssp245counts(1:36),ssp245duration(1:36),ssp245intensities(1:36)};

JP1=joyPlot(Data1,'ColorMode','Order','ColorList',[25,163,185]./255,'MedLine','off','Scatter','off');%12,165,154
JP1=JP1.draw();

JP2=joyPlot(Data2,'ColorMode','Order','ColorList',[151,220,71]./255,'MedLine','off','Scatter','off');
JP2=JP2.draw();

JP3=joyPlot(Data3,'ColorMode','Order','ColorList',[240,189,130]./255,'MedLine','off','Scatter','off');
JP3=JP3.draw();

legendHdl1=JP1.getLegendHdl();
legendHdl2=JP2.getLegendHdl();
legendHdl3=JP3.getLegendHdl();

h=legend([legendHdl2(1),legendHdl1(1),legendHdl3(1)],{'Frequency', 'Duration', 'Intensity'},'FontSize',20,'fontname','Times New Roman');
set(h,'Box','off');


%JP=joyPlot(Data,'ColorMode','Order','Scatter','on');
% JP=joyPlot(Data,'ColorMode','Order');
% JP=JP.draw();
% 
% legendHdl=JP.getLegendHdl();
% legend([legendHdl(1),legendHdl(2),legendHdl(3),legendHdl(4),legendHdl(5),legendHdl(6)],{'A','B','C','D','E','F'})
% 
 ax=gca;
 xlabel('Distribution of DHW characteristics','FontSize',20,'fontname','Times New Roman');
 yticklabels({'Historical','SSP245','SSP585'});
 ax.XLabel.FontSize=20;
 ax.YLabel.FontSize=20;
 set(gca,'FontName','Times New Roman', 'FontSize', 20);
 set(gca,'LineWidth',2); 
text(0.5, 5, '(d)', 'FontSize', 22, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
disp('done')





% 
% Historicalda=imread('H:\CMIP6\Results\Historical\drywetevent_intensities1979-2014.tif');
% R245da=imread('H:\CMIP6\Results\future\SSP2-RCP4.5\drywetevent_intensities2015-2100.tif');
% R585da=imread('H:\CMIP6\Results\future\SSP2-RCP8.5\drywetevent_intensities2015-2100.tif');
% Historical=Historicalda(find(Historicalda>0));
% R245=R245da(find(R245da>0));
% R585=R585da(find(R585da>0));
% 
% hismean=mean(Historical,'all');
% R245mean=mean(R245,'all');
% R585mean=mean(R585,'all');
% 
% hissum=sum(sum(Historical,'all'));
% R245sum=sum(sum(R245,'all'));
% R585sum=sum(sum(R585,'all'));
% 
% max_length = max([length(Historical), length(R245), length(R585)]);
% Historical = [Historical; nan(max_length - length(Historical), 1)];
% R245 = [R245; nan(max_length - length(R245), 1)];
% R585 = [R585; nan(max_length - length(R585), 1)];
% data=[Historical,R245,R585];
% 
% 
% % subplot(1,2,1)
% hb = boxplot(data,...              
%                     'Color','k',...                                   %箱体边框及异常点颜色
%                     'symbol','.',...                                  %异常点形状
%                     'Notch','on',...                                  %异常点形状
%                     'OutlierSize',4,...                               %是否是凹口的形式展现箱线图，默认非凹口
%                     'labels',{'Historical','SSP245','SSP585'});
% set(hb,'LineWidth',1.5)                                               %箱型图线宽
% 
%  CF = colorplus([83,65,42]);
% h = findobj(gca,'Tag','Box');
% for j = 1:min(size(data))
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
% hYLabel = ylabel('Exposure','FontName','Times New Roman');
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
% %set(gca,'LineWidth',1.5); 
% %text(1,0.9,'(a)','FontSize',22,'fontname','Times New Roman','FontWeight','bold','FontWeight','bold')
% 
% %subplot(1,2,2)
% x1=data(:,1);
% x2=data(:,2);
% x3=data(:,3);
% 
% % [D_U1, PD_U1]= allfitdist(x1);
% % [D_U2, PD_U2]= allfitdist(x2);
% % [D_U3, PD_U3]= allfitdist(x3);
%  % [D_U1, PD_U1]= allfitdist(data(:,i),'DISCRETE','PDF');这是针对离散性分布
% % Check if inverse is also OK
% % EP1 = cdf(PD_U1{1},x1); 
% % EP2 = cdf(PD_U2{1},x2); 
% % EP3 = cdf(PD_U3{1},x3); 
% 
% % 1. 计算数据的均值和标准差
% 
% 
% 
% [f1, xi1] = ksdensity(x1);
% [f2, xi2] = ksdensity(x2);
% [f3, xi3] = ksdensity(x3);
% % density_x1 = ksdensity(x1);
% % density_x1(density_x1 < 0) = 0;
% % 
% % density_x2 = ksdensity(x2);
% % density_x2(density_x2 < 0) = 0;
% % 
% % density_x3 = ksdensity(x3);
% % density_x3(density_x3 < 0) = 0;
% plot(xi1, f1, 'LineWidth', 2.0,'Color', CF(1, :));
% hold on
% plot(xi2, f2, 'LineWidth', 2.0,'Color', CF(2, :));
% hold on
% plot(xi3, f3, 'LineWidth', 2.0,'Color', CF(3, :));
% 
% 
% 
% 
% %  histogram(x1,'FaceColor','Green')
% %  hold on
% %  histogram(x2,'FaceColor','yellow')
% %  hold on
% %  histogram(x3,'FaceColor','blue')
% 
% %plot(linspace(min(x1), max(x1), numel(density_x1)), density_x1, 'LineWidth', 2.0,'Color', CF(5, :));
% %hold on
% %plot(linspace(min(x2), max(x2), numel(density_x2)), density_x2, 'LineWidth', 2.0,'Color', CF(4, :));
% %hold on
% %plot(linspace(min(x3), max(x3), numel(density_x3)), density_x3, 'LineWidth', 2.0,'Color', CF(3, :));
% %hold on
% 
% xlabel('Intensity','FontName','Times New Roman');
% ylabel('Probability density','FontName','Times New Roman');
% h=legend({'Historical','SSP245','SSP585'},'FontSize',20,'FontName','Times New Roman','location','northwest');   %右上角标注
% set(h,'Box','off');
% set(gca, 'FontName','Times New Roman', 'FontSize', 22)
% ylim([0, 0.5]);
% text(0.5,0.6,'(b)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')
% set(gca, 'Box', 'off', 'FontName', 'Times New Roman', 'FontSize', 22);
% set(gca,'LineWidth',1.5);