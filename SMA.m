%% Simple Moving Average(SMA) Description

% Description: 
% Simple moving average is the unweighted mean of the previous n data points.
% It is popular and widely used as smoothing the sharp trnsition of
% financial security price 

% Function Usage:
% Input: the width of the analysis window & price information variable
% Output: the lag produced by simple moving average algorithm & plot
% showing the simple moving average on candlestick chart

% Example:
% [SMA_price, SMA_L, SMA_lag] = SMA (50, data_recent);
% In this case, the analysis window width is 8 bars

% *************** Local Variables and Explaination ******************* 
% SMA_L
% SMA_W
% SMA_data
% SMA_high
% SMA_low
% SMA_open
% SMA_close
% weighted_avg_tmp
% SMA_weighted_avg
% SMA_lh: SMA legend handler

% Modification Tips:
% 1. get a more accurate weighted price for SMA calculation, now is just using average price (open , close) 

% |----------------- Modification Log ----------------------------|
% |ver 0.1     05/20/2012 Inital Script                           |
% |ver 0.2     07/05/2012 Merged High/Low price plot              |
% |ver 0.21    07/06/2012 Corrected SMA lag in plot               |
% |ver 0.22    07/06/2012 Annotated SMA to existing legend        |
% |ver 0.3     07/14/2012 Added SMA_weighted_avg as return value  |
% |-----------------End of Modification Log ----------------------|

% Author: Michael (Yue) Hu
% Date: May 20, 2012
% (C) Copyright 2012 Unievrsity of British Columbia

%% SMA Algorithm
function [SMA_weighted_avg, SMA_W, SMA_lag] = SMA (window_width, data)

%% *********** Variable declaration and initialization ******************

% Window Width
% display 'This script implements Simple Moving Average(SMA) algorithm';
% N = input ('Please type in the window witdth:');
% if (N <= 0)
%    display 'ERROR! The window width has to be a POSITIVE number!';
% end
% 
% % Open Historical Financial Data
% file_name = input('Please type in the name of the history data sets wish to be processed:','s');
% [num,txt,raw] = xlsread(file_name);

% Total number of the data sets read in
SMA_L = length(data);
SMA_W = window_width;

SMA_data = data; % This could be omitted, for the purpose of protecting original data, keep it for now
SMA_high = data (:,5);
SMA_low = data(:,4);
SMA_open = data (:,2);
SMA_close = data (:,3);

%*********** END of variable initilization and declaration ****************

%% ************** Simple Moving Avergae Calculation *********************

% Weighted price for SMA calculation
weighted_avg = (SMA_open + SMA_close) / 2;

% Calculating SMA for weighted average price hourly

for i = 1 : 1 : (SMA_L - SMA_W)
    weighted_avg_tmp = 0;
    for j = i : 1 : (i + SMA_W - 1)
    weighted_avg_tmp = weighted_avg_tmp + weighted_avg(j);
    end
    SMA_weighted_avg(i) = weighted_avg_tmp/SMA_W;
end

    hold on
    x = (SMA_W+1) : SMA_L;
    SMA_lh = plot (x, SMA_weighted_avg, 'b');
%     [LEGH,OBJH,OUTH, OUTM] = legend;
%     legend ([OUTH;SMA_lh], OUTM{:}, 'Simple Moving Average');
    
    SMA_lag = (SMA_W - 1 ) / 2;











