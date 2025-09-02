clc, clear, close all


% Generate some sample data
data = randn(100, 1);

% Compute the mean and standard deviation of the data
mu = mean(data);
sigma = std(data);

% Compute the histogram and bin edges
[n, edges] = histcounts(data);

% Compute the bin centers
centers = (edges(1:end-1) + edges(2:end)) / 2;

% Compute the errors as the standard deviation and average error
errors = sigma * ones(size(centers));
avg_error = abs(mu - centers);
avg_error_line = plot([mu mu], [0 max(n)], 'r--');
hold on;

% Create a bar chart with error bars
bar(centers, n);
hold on;
errorbar(centers, n, errors, 'k', 'LineStyle', 'none');
hold on;
% Add a legend and axis labels
legend( 'Average Error','Data', 'Error Bars');
xlabel('Value');
ylabel('Frequency');
set(gca,'fontname','Times new roman','FontSize', 14);  % Set fontname