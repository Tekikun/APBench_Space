set(groot,'defaultAxesFontSize',18);
set(groot,'defaultTextInterpreter','latex'); %trying to set the default
set(groot,'defaultAxesFontSize',17);
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultLineLineWidth',2);
set(groot,'DefaultAxesXGrid','on')
set(groot,'DefaultAxesYGrid','on')

% Define the data
Model = {
    'Claude 3.5 Sonnet'; %June 20, 2024
    'GPT-4'; % 2024-04-09
    'GPT-4 no QA attach'; % 2024-04-09
    'GPT-4o'; %2024-08-06
    'o1-mini'; % 2024-09-12
    'o1-preview'; %2024-09-12
    'Qwen2.5-Math 1.5B'; %2024-09-19
    'Qwen2.5-Math 7B';% 2024-08-08
    'Qwen2.5-Math 72B 4-bit'; % 2024-09-19
    'AstroLlama'; % 2023-09-12
    'Llama 2 7B'; %July 18, 2023
    'Llama 3.1 7B'; %July 23, 2024
    'Llama 3.1 70B 4bit'; %July 23, 2024
    'Llama 3.2 1B'; %September 25, 2024
    'Llama 3.2 3B'; %September 25, 2024
    'Reflection Llama 3.1 70B'; %July 23, 2024
    'Reflection Llama 3.1 70B 4bit'; %July 23, 2024.
    'Ollama Reflection' %July 23, 2024.
    'Claude 3.7 Sonnet'; %2025-02-24
    'Grok 3 Mini (high)'; %2025-02-17
    'Grok 3 Mini (low)'; %2025-02-17
    'o4-mini'; %2025-04-16
    'R1 32B'; %2025-01-20
    'AstroLlaMa 2'; %2024-11-16
    'AstroSage'; %2024-11-16
};

% Define the release dates
Dates = [
    datetime(2024, 6, 20);  % Claude 3.5 Sonnet
    datetime(2024, 4, 9);   % GPT-4
    datetime(2024, 4, 9);   % GPT-4 no QA attach
    datetime(2024, 8, 6);   % GPT-4o
    datetime(2024, 9, 12);  % o1-mini
    datetime(2024, 9, 12);  % o1-preview
    datetime(2025, 2, 24);  % Claude 3.7 Sonnet
    datetime(2025, 2, 17);  % Grok 3 Mini (high)
    datetime(2025, 2, 17);  % Grok 3 Mini (low)
    datetime(2025, 4, 16);  % o4-mini
    datetime(2024, 9, 19);  % Qwen2.5-Math 1.5B
    datetime(2024, 8, 8);   % Qwen2.5-Math 7B
    datetime(2024, 9, 19);  % Qwen2.5-Math 72B 4-bit
    datetime(2023, 9, 12);  % AstroLlama
    datetime(2023, 7, 18);  % Llama 2 7B
    datetime(2024, 7, 23);  % Llama 3.1 7B
    datetime(2024, 7, 23);  % Llama 3.1 70B 4bit
    datetime(2024, 9, 25);  % Llama 3.2 1B
    datetime(2024, 9, 25);  % Llama 3.2 3B
    datetime(2024, 7, 23);  % Reflection Llama 3.1 70B
    datetime(2024, 7, 23);  % Reflection Llama 3.1 70B 4bit
    datetime(2024, 7, 23);   % Ollama Reflection
    datetime(2025, 1, 20);  % R1 32B
    datetime(2024, 11,16);  % AstroLlaMa 2
    datetime(2024, 11,16);  % AstroSage
];

Small = [
    0.640; 0.520; 0.520; 0.480; 0.600; 0.640; 0.520; 0.480; 0.720; 0.680; ...
    0.200; 0.360; ...
    0.600; 0.080; 0.200; 0.200; 0.280; 0.080; 0.080; 0.400; 0.286; 0.280;...
    0.120; 0.120; 0.200
];

Medium = [
    0.556; 0.485; 0.503; 0.485; 0.589; 0.633; 0.539; 0.592; 0.633; 0.704;...
    0.213; 0.325; ...
    0.479; 0.010; 0.101; 0.172; 0.296; 0.118; 0.142; 0.331; 0.302; 0.237; ...
    0.112; 0.414; 0.201
];

Large = [
    0.575; 0.492; 0.498; 0.548; 0.594; 0.666; 0.632; 0.685; 0.696; 0.729; ...
    0.221; 0.331; ...
    0.522; 0.010; 0.124; 0.184; 0.321; 0.084; 0.154; 0.324; 0.298; 0.221; ...
    0.157; 0.047; 0.161
];


% Create the table
T = table(Model, Dates, Small, Medium, Large);
T(strcmp(T.Model, 'GPT-4 no QA attach'), :) = [];
T_closed = T(1:9,:);
T_open = T(10:end,:);

% Display the table
disp(T);

% Figure
fig1 = figure(1);hold on;
set(fig1,'units','inches','position',[0,2,16,6]);

closed_source_color = [84 151 204]/255; % Light blue
closed_source_data = [37 87 184]/255; % dark blue
open_weight_color = [250 188 180]/255;  % Light red
open_weight_data = [237 125 38]/255; % dark red

% closed Data plot
x_datelabel_c = T_closed.Dates;
acc_small_c = T_closed.Small*100; % 
acc_medium_c = T_closed.Medium*100; %
acc_large_c = T_closed.Large*100; % 
acc_average_c = mean([acc_small_c,acc_medium_c,acc_large_c],2);
acc_max_c = max([acc_small_c,acc_medium_c,acc_large_c],[],2);

models_closed = T_closed.Model;
bar_closed = arrayfun(@(x) sprintf('%.1f%', x), acc_large_c, 'UniformOutput', false);

c{1} = scatter(x_datelabel_c, acc_small_c, 's','filled');
clear c{1}
% text(x_datelabel_c+5, acc_large_c, bar_closed)
% text(x_datelabel_c, acc_large_c+2, models_closed)
% limit
% xlim([datetime(2023, 7, 1),datetime(2024, 10, 1)]);
% xlim([datetime(2023, 7, 1),datetime(2025, 5, 15)]);
xlim([datetime(2023, 7, 1),datetime(2025, 10, 15)]);
% make datetime ticks every 3 months
xt_date = datetime(2023,7:3:34,1);  % months 7,10,13(=Jan24)
ax = gca;
ax.XTick = xt_date;

% closed data fitting
c_idx_x = days(x_datelabel_c - datetime(2024,1,1));
c_idx_y = acc_large_c;
% Linear Fit (1st-degree polynomial)
p = polyfit(c_idx_x, c_idx_y, 1); % Fit a line (degree 1)
% Generate fitted values
x_fit = linspace(91, 333, 100); % Generate x-points for line
% y_fit_c = polyval(p, x_fit); % Compute corresponding y-points using the fit
 
% TimeLine 1
p_fit_c = @(x) 38.26289 +  0.11145 * x
y_fit_c = p_fit_c(x_fit)
yline_value = 85;
% patch
x_patch = [x_fit, fliplr(x_fit)] + datetime(2024, 1, 1); % X-coordinates (combine forward and backward)
y_patch = [y_fit_c, fliplr(repmat(yline_value, size(y_fit_c)))]; % Y-coordinates (line + constant yline)
% Add patch to plot
patch('XData', x_patch, 'YData', y_patch, 'FaceColor', closed_source_color,...
    'FaceAlpha', 0.3, 'EdgeColor', 'none');
plot(x_fit+datetime(2024,1,1), y_fit_c, '-.', 'LineWidth', 3,...
    'Color',closed_source_color); % Fitted line
% Timeline 2
x_fit2 = linspace(91, 720, 200); % Generate x-points for line
p_fit_c2 = @(x) 46.44629 +  0.05292 * x
y_fit_c2 = p_fit_c2(x_fit2)
% patch
x_patch2 = [x_fit2, fliplr(x_fit2)] + datetime(2024, 1, 1); % X-coordinates (combine forward and backward)
y_patch2 = [y_fit_c2, fliplr(repmat(yline_value, size(y_fit_c2)))]; % Y-coordinates (line + constant yline)
% Add patch to plot
patch('XData', x_patch2, 'YData', y_patch2, 'FaceColor', closed_source_color,...
    'FaceAlpha', 0.2, 'EdgeColor', 'none');
plot(x_fit2+datetime(2024,1,1), y_fit_c2, '--', 'LineWidth', 4,...
    'Color',closed_source_color); % Fitted line

c{1} = scatter(x_datelabel_c, acc_small_c, 's','filled');
c{2} = scatter(x_datelabel_c, acc_medium_c, '^', 'filled');
c{3} = scatter(x_datelabel_c, acc_large_c, 'o', 'filled');
for i = 1:3
    c{i}.SizeData = 100;
    c{i}.MarkerEdgeColor = 'k';
    c{i}.LineWidth = 1.5;
    c{i}.MarkerFaceColor = closed_source_data;
end

% open Data plot
x_datelabel_o = T_open.Dates;
acc_small_o = T_open.Small*100; % 
acc_medium_o = T_open.Medium*100; %
acc_large_o = T_open.Large*100; % 
acc_average_o = mean([acc_small_o,acc_medium_o,acc_large_o],2);
acc_max_o = max([acc_small_o,acc_medium_o,acc_large_o],[],2);

models_open = T_open.Model;
bar_open = arrayfun(@(x) sprintf('%.1f%', x), acc_large_o, 'UniformOutput', false);

% open data fitting
o_idx_x = days(x_datelabel_o([5,10,3]) - datetime(2024,1,1));
o_idx_y = [acc_large_o(5),acc_large_o(10),acc_large_o(3)];
% best fit exponential
% Timeline 1
p_fit = @(x) 1.8416 * exp(0.0118 * x) + 12.1414;
x_fit = linspace(-200, 333, 100); % Generate x-points for line
y_fit_o = p_fit(x_fit);
plot(x_fit+datetime(2024,1,1), y_fit_o, '-.', 'LineWidth', 3,...
    'Color',open_weight_color); % Fitted line
% fit no qwen
y_fit_o_noqwen = @(x) 14.4506 * exp(0.0018 * x);
% patch
x_patch = [x_fit, fliplr(x_fit)] + datetime(2024, 1, 1); % X-coordinates (combine forward and backward)
y_patch = [y_fit_o, 0*y_fit_o]; % Y-coordinates (line + constant yline)
% Add patch to plot
patch('XData', x_patch, 'YData', y_patch, 'FaceColor', open_weight_color, ...
    'FaceAlpha', 0.3, 'EdgeColor', 'none');
% Timeline 2
p_fit2 = @(x) 25.5366 * exp(0.0020 * x) -12.0434;
x_fit2 = linspace(-200, 720, 200); % Generate x-points for line
y_fit_o2 = p_fit2(x_fit2);
plot(x_fit2+datetime(2024,1,1), y_fit_o2, '--', 'LineWidth', 4,...
    'Color',open_weight_color); % Fitted line
% patch
x_patch2 = [x_fit2, fliplr(x_fit2)] + datetime(2024, 1, 1); % X-coordinates (combine forward and backward)
y_patch2 = [y_fit_o2, 0*y_fit_o2]; % Y-coordinates (line + constant yline)
% Add patch to plot
patch('XData', x_patch2, 'YData', y_patch2, 'FaceColor', open_weight_color, ...
    'FaceAlpha', 0.2, 'EdgeColor', 'none');


% open weight data
o{1} = scatter(x_datelabel_o, acc_small_o, 's', 'filled');
o{2} = scatter(x_datelabel_o, acc_medium_o, '^', 'filled');
o{3} = scatter(x_datelabel_o, acc_large_o, 'o', 'filled');

for i = 1:3
    o{i}.SizeData = 100;
    o{i}.MarkerEdgeColor = 'k';
    o{i}.LineWidth = 1.5;
    o{i}.MarkerFaceColor = open_weight_data;
end
% text(x_datelabel_o-5, acc_large_o+2, models_open,'HorizontalAlignment','left')
% text(x_datelabel_o-16, acc_large_o, bar_open,'FontSize',16)

% yline
y60 = yline(60,'LineStyle','-','LineWidth',2,'color','r');
y60.Alpha = 0.5;
y80 = yline(80,'LineStyle','-','LineWidth',2,'color','b');
y80.Alpha = 0.5;
set(get(ax,'YAxis'),'Visible','on');
% xlin
x_date1=xline(datetime(2024,1,1)+335,'LineStyle','-','LineWidth',2,'color','k');
x_date2=xline(datetime(2024,1,1)+486,'LineStyle','-','LineWidth',2,'color','k');

e{1} = plot(nan, nan,'s','MarkerSize',13,...
    'MarkerEdgeColor','k','LineWidth',1.5);
e{2} = plot(nan, nan, '^','MarkerSize',13,...
    'MarkerEdgeColor','k','LineWidth',1.5);
e{3} = plot(nan, nan, 'o','MarkerSize',13,...
    'MarkerEdgeColor','k','LineWidth',1.5);
ylim([-inf,85]);
%
hLegend=legend([e{1},e{2},e{3}],{'APBench-$\alpha$','APBench-$\beta$','APBench-$\gamma$'},'Orientation','horizontal',...
    'Location','northoutside','FontSize',18,'Box','off');
hLegend.Position(1) = 0.13;
hLegend.Position(2) = 0.92;