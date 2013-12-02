%% Exponential Moving Average (EMA) Description

% Description:
% Exponential moving averages (EMA) is a type of infinite impulse response
% filter (IIR) that applies weighting factors which decrease exponentially.
% It give more weight to the most recent periods. The weighting for each
% older datum point decreases exponentially, never reaching zero.
% Formula: EMA = alpha * Current Price + (1 - alpha) * EMA[1]

% Function Usage:
% Input: the width of the analysis window & price information variable
% Output: the lag produced by simple moving average algorithm & plot
% showing the exponentially weighted moving average on candlestick chart

% Example:
% [EMA_lag] = EMA (8, data);
% In this case, the analysis window width is 8 bars

% *************** Local Variables and Explaination ******************* 
% EMA_L
% EMA_W
% EMA_data
% EMA_high
% EMA_low
% EMA_open
% EMA_close
% weighted_avg
% alpha
% EMA_weighted_avg
% EMA_lh: EMA legend handler (to annotate the EMA plot to existing legend)

% Modification Tips:
% 1. get a more accurate weighted price for EMA calculation, now is just using average price (open , close) 
% 2. legend attachment

% |----------------- Modification Log ----------------------------|
% |ver 0.1     06/07/2012 Inital Script                           |
% |                                                               |
% |-----------------End of Modification Log ----------------------|

% Author: Michael (Yue) Hu
% Date: July 6, 2012
% (C) Copyright 2012 Unievrsity of British Columbia

%% EMA Algorithm
function [EMA_W, EMA_lag] = EMA (window_width, data)

%% *********** Variable declaration and initialization ******************

EMA_L = length(data);
EMA_W = window_width;

EMA_data = data; % This could be omitted, for the purpose of protecting original data, keep it for now
EMA_high = data (:,5);
EMA_low = data(:,4);
EMA_open = data (:,2);
EMA_close = data (:,3);

%*********** END of variable initilization and declaration ****************

%% ************** Exponential Moving Avergae Calculation *********************

% Weighted price for EMA calculation
weighted_avg = (EMA_open + EMA_close) / 2;

% Alpha calculation
alpha = 2 / (EMA_W + 1);

% Calculating EMA for weighted average price hourly

EMA_weighted_avg(1) = weighted_avg(1);
for i = 2 : 1 : (EMA_L - EMA_W)
    EMA_weighted_avg(i) = alpha * weighted_avg(i) + (1 - alpha) * EMA_weighted_avg(i-1);
end

    hold on
% The plot has EMA_W lag
    x = (EMA_W+1) : EMA_L; 
    EMA_lh = plot (x, EMA_weighted_avg, 'y');
    [LEGH,OBJH,OUTH, OUTM] = legend;
    legend ([OUTH;EMA_lh], OUTM{:}, 'Exponential Weighted Moving Average');
    
    EMA_lag = 1/alpha -1;











