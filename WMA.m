%% Weight Moving Average(WMA) Description

% Description: 
% By assigning more weight to the closest price and less weight to the
% farest price, the weighted moving average solves the problem of not bing 
% able to properly predict buy or sell signals of the SMA's crossover
% action

% Function Usage:
% Input: the width of the analysis window & price information variable
% Output: the lag produced by weighted moving average algorithm & plot
% showing the weighted moving average on candlestick chart

% Example:
% [WMA_lag] = WMA (8, data);
% In this case, the analysis window width is 8 bars

% *************** Local Variables and Explaination ******************* 
% WMA_L
% WMA_W
% WMA_data
% WMA_high
% WMA_low
% WMA_open
% WMA_close
% weighted_avg
% weighted_avg_tmp
% weight
% weight_sum
% WMA_weighted_avg
% WMA_lh: WMA legend handler (To annotate WMA to existing legend)


% Modification Tips:
% 1. get a more accurate weighted price for WMA calculation, now is just using average price (open , close) 

% |----------------- Modification Log ----------------------------|
% |ver 0.1     05/21/2012 Inital Script                           |
% |ver 0.2     07/05/2012 Merge High/Low price plot               |
% |ver 0.21    07/06/2012 Annotate WMA plot to existing legend    |
% |-----------------End of Modification Log ----------------------|

% Author: Michael (Yue) Hu
% Date: May 21, 2012
% (C) Copyright 2012 Unievrsity of British Columbia

%% WMA Algorithm
function [WMA_W, WMA_lag] = WMA (window_width, data)

%% *********** Variable declaration and initialization *****************

WMA_L = length(data);
WMA_W = window_width;

WMA_data = data; % This could be omitted, for the purpose of protecting original data, keep it for now
WMA_high = data (:,5);
WMA_low = data(:,4);
WMA_open = data (:,2);
WMA_close = data (:,3);

%*********** END of variable initilization and declaration ****************

%% Weighted Moving Average (WMA) Calculation

% Weighted price for SMA calculation
weighted_avg = (WMA_open + WMA_close) / 2;

for i = 1 : 1 : (WMA_L-WMA_W)
    
    weighted_avg_tmp = 0;
    weight = 1;
    weight_sum = 0;
    
    for j = i : 1 : (i + WMA_W - 1)
    weighted_avg_tmp = weighted_avg_tmp + weighted_avg(j) * weight;
    weight_sum = weight_sum + weight;
    weight = weight + 1;
    end

    WMA_weighted_avg(i) = weighted_avg_tmp/weight_sum;
end

    x = (WMA_W+1) :WMA_L;
    hold on
    WMA_lh = plot (x, WMA_weighted_avg, ':ok', 'Markersize', 2);
    [LEGH,OBJH,OUTH, OUTM] = legend;
    legend ([OUTH;WMA_lh], OUTM{:}, 'Weighted Moving Average');
    
    
    WMA_lag = (WMA_W - 1) / 3;
    










