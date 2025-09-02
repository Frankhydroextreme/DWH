clc
clear all
close all
data =xlsread('E:\中国区域复合极端事件概率\Figure and codes\urbancontribution.xlsx', 'Sheet2','A2:E101');

year=data(:,1);
ssp245=data(:,2);
ssp245mean=data(:,4);
ssp585=data(:,3);
ssp585mean=data(:,5);
x=1:1:length(ssp245mean);

subplot(2,2,1)
plot (ssp245mean(1:14)-detrend(ssp245mean(1:14)),'linewidth',2,'Color',[133 204 222]./255,'linestyle','--')
hold on
plot (ssp245mean(15:end)-detrend(ssp245mean(15:end)),'linewidth',2,'Color',[0 186 199]./255,'linestyle','--')
hold on

bar(ssp245,'FaceColor',[0 143 213]./255)
%plot(x,ssp245,'k-o','MarkerSize',5, 'linewidth',2,'Color',[0 143 213]./255)
hold on
plot(x,ssp245mean,'k-o','MarkerSize',5, 'linewidth',2,'Color',[252 79 48]./255)

hold on

%绘制置信区间

y = ssp245mean;
a=1.96*std(y)/length(y)^0.5;
xconf = [x x(end:-1:1)] ;%构造正反向的x值，作为置信区间的横坐标值
yc = [y+a y(end:-1:1)-a];%构造y方向的上下范围，作为置信区间的纵坐标值
yconf=[yc(:,1)',yc(:,2)'];
xconf1= spcrv([xconf(1) xconf xconf(end)],2);
yconf1=spcrv([yconf(1) yconf yconf(end)],2);

p = fill(xconf1,yconf1,'b','FaceAlpha',0.3);%定义填充区间
p.FaceColor = [252 79 48]./255;%定义区间的填充颜色      
p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
hold off

% 对数据进行多项式拟合
x1=1:14;
p1 = polyfit(x1, ssp245mean(1:14), 1); % 这里假设拟合为一次多项式（直线）
% 计算拟合直线的 y 值
% 添加拟合方程式到图形
equation1 = sprintf('y = %.2fx + %.2f  p<0.01', p1(1), p1(2));
%text(10, 200, equation1, 'FontSize', 20,'FontName', 'Times New Roman');

% 对数据进行多项式拟合
x2=15:100;
p2 = polyfit(x2, ssp245mean(15:end), 1); % 这里假设拟合为一次多项式（直线）

% 添加拟合方程式到图形
equation2 = sprintf('y = %.2fx + %.2f  p<0.01', p2(1), p2(2));
%text(10, 300, equation2, 'FontSize', 20,'FontName', 'Times New Roman');

h = legend('Historical: y = -2.71x + 119.27  p<0.01 ', 'SSP245: y = 0.02x + 57.14  p<0.01 ','Urban DHW count ','Five-year moving window average ', 'FontSize', 20, 'FontName', 'Times New Roman');

%axis([0,1440,0,12])  %确定x轴与y轴框图大小
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');

yea=2000:10:2100;
xlabels = cellstr(num2str(yea'));
set(gca,'XTick',[0:10:100],'XTickLabel',xlabels) 
% 去掉右和上边框
box off;
text(90,1300,'(a)','FontSize',26,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2); 
ylim([0, 1600]);
xlabel('Year')
ylabel('Urban DHW frequency')
hold off
set(gca, 'FontName','Times New Roman', 'FontSize', 22)


subplot(2,2,2)
plot (ssp585mean(1:14)-detrend(ssp585mean(1:14)),'linewidth',2,'Color',[133 204 222]./255,'linestyle','--')
hold on
plot (ssp585mean(15:end)-detrend(ssp585mean(15:end)),'linewidth',2,'Color',[0 186 199]./255,'linestyle','--')
hold on

bar(ssp585,'FaceColor',[0 143 213]./255)
%plot(x,ssp245,'k-o','MarkerSize',5, 'linewidth',2,'Color',[0 143 213]./255)
hold on
plot(x,ssp585mean,'k-o','MarkerSize',5, 'linewidth',2,'Color',[252 79 48]./255)
hold on

%绘制置信区间
y = ssp585mean;
a=1.96*std(y)/length(y)^0.5;
xconf = [x x(end:-1:1)] ;%构造正反向的x值，作为置信区间的横坐标值
yc = [y+a y(end:-1:1)-a];%构造y方向的上下范围，作为置信区间的纵坐标值
yconf=[yc(:,1)',yc(:,2)'];
xconf1= spcrv([xconf(1) xconf xconf(end)],2);
yconf1=spcrv([yconf(1) yconf yconf(end)],2);

p = fill(xconf1,yconf1,'b','FaceAlpha',0.3);%定义填充区间
p.FaceColor = [252 79 48]./255;%定义区间的填充颜色      
p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
hold off

% 对数据进行多项式拟合
x1=1:14;
p1 = polyfit(x1, ssp585mean(1:14), 1); % 这里假设拟合为一次多项式（直线）
% 计算拟合直线的 y 值
% 添加拟合方程式到图形
equation1 = sprintf('y = %.2fx + %.2f  p<0.01', p1(1), p1(2));
%text(10, 200, equation1, 'FontSize', 20,'FontName', 'Times New Roman');

% 对数据进行多项式拟合
x2=15:100;
p2 = polyfit(x2, ssp585mean(15:end), 1); % 这里假设拟合为一次多项式（直线）

% 添加拟合方程式到图形
equation2 = sprintf('y = %.2fx + %.2f  p<0.01', p2(1), p2(2));
%text(10, 300, equation2, 'FontSize', 20,'FontName', 'Times New Roman');

h = legend('', 'SSP585: y = 0.07x + 82.46  p<0.01 ','','', 'FontSize', 20, 'FontName', 'Times New Roman');

%axis([0,1440,0,12])  %确定x轴与y轴框图大小
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');


yea=2000:10:2100;
xlabels = cellstr(num2str(yea'));
set(gca,'XTick',[0:10:100],'XTickLabel',xlabels) 
% 去掉右和上边框
box off;
text(90,2400,'(b)','FontSize',26,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2); 
ylim([0, 2600]);
xlabel('Year')
ylabel('Urban DHW frequency')
hold off
set(gca, 'FontName','Times New Roman', 'FontSize', 22)

subplot(2,2,3)
x = 1:3;
dat = [51.1 28.2 80.1]';
errhigh = [16.57 13.09 19.89];%误差条上边界
errlow  = [16.57 13.09 19.89];%误差条下边界​
bar(x,dat,'FaceColor',[0 186 199]./255)%绘制条形图​
hold on%保持图片内容不变​
er = errorbar(x,dat,errlow,errhigh);%绘制误差条    
er.Color = [0 0 0];%设置误差条颜色：黑色                            
er.LineStyle = 'none';%设置线形​
hold off
box off;
text(4,90,'(c)','FontSize',26,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',2); 
set(gca,'XTick',[1:1:3],'XTickLabel',{'Historical','SSP245','SSP585'})
ylim([0, 120]);
ylabel('Urban effect (%)')
set(gca, 'FontName','Times New Roman', 'FontSize', 22)

%fig = gcf; % 获取当前图形的句柄
%exportgraphics(fig, 'E:\中国区域复合极端事件概率\Figure and codes\datacontibutions\myimage.png', 'Resolution', 300); % 将图形保存为PNG格式，并设置分辨率为300dpi

% clear all
% % 
% data =xlsread('E:\中国区域复合极端事件概率\Figure and codes\urbancontribution.xlsx', 'Sheet1','F2:F102');
% 
% his=data(15:end,1);
% X=squeeze(his);
% 
% X=double(X);
% n=length(X);
% ndash = n*(n-1)/2;
% sl = zeros(ndash,1);            
% p = 1;
% for mm = 1:n-1
%     for nn = mm+1:n
%         sl(p) = (X(nn) -X(mm)) / (nn-mm) ;
%         p = p + 1;
%           end
%         end
%   
% 
% % Generate some sample data
% data =sl;
% 
% % Compute the mean and standard deviation of the data
% mu = mean(data);
% sigma = std(data);
% 
% % Compute the histogram and bin edges
% [n, edges] = histcounts(data);
% 
% % Compute the bin centers
% centers = (edges(1:end-1) + edges(2:end)) / 2;
% 
% % Compute the errors as the standard deviation and average error
% errors = sigma * ones(size(centers));
% avg_error = abs(mu - centers);
