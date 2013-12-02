%% Fibonacci Retracement Function Description

% Description: 
% Fibonacci Retracement is a widely used indicator in determining the 
% support and resistance price range. There are six support/resistance 
% levels: 0.0%, 23.6%, 38.2%, 50.0%, 61.8%, and 100.0%

% Function Usage: 
% Input: analysis start time, analysis end time, price date vector variable, and
% total price information vector variable
% Output: Six support/resistance level & a price candlestick plot showing the six levels

% Example:
% [L0, L1, L2, L3, L4, L5] = Fibo (1,100,d_tmp,data)
% 
% *************** Local Variables and Explaination ******************* 
% * plot_offset_hori/plot_offset_vert: micro position adjustment in the Fibonacci
% Retracement Level Label in the final plot
% * d_start_pos/d_end_pos: the start/end data points corresponding the specified
% analysis time points
% * fibo_data/fibo_high/fibo_low/fibo_open/fibo_close
% * fibo_max/fibo_min
% * flag: trend flag
% * fibo_range
% * anal_peri
% * lvl_0/lvl_1/lvl_2/lvl_3/lvl_4/lvl_5
% * lvl_0_y/lvl_1_y/lvl_2_y/lvl_3_y/lvl_4_y/lvl_5_y

% Modification Tips:
% 1. change d_tmp to real date vector (d_tmp is just numbers, no real meaning)
% 2. simplify the input parameters: get rid of d_tmp and date(global variable??)

% |----------------- Modification Log ----------------------------|
% |ver 0.1     07/05/2012 Inital Script                           |
% |                                                               |
% |-----------------End of Modification Log ----------------------|


% Author: Michael (Yue) Hu
% Date: July 3, 2012
% (C) Copyright 2012 Unievrsity of British Columbia

%% Fibonacci Retracement Algorithm 

function [lvl_0, lvl_1, lvl_2, lvl_3, lvl_4, lvl_5] = Fibo (t_start, t_end,d_tmp, data)

%% Format 

% Plot position shift (change the value below to adjust the Fibonacci label position)
plot_offset_hori = 0;
plot_offset_vert = 0.0003; % 3 pips

% Clear screen & change display format
clc
format long

%% Price Information Preparation

% Retrieve price information in the specified time range
d_start_pos = find (d_tmp == t_start,1, 'first');
d_end_pos = find (d_tmp == t_end, 1, 'first');

fibo_data = data(d_start_pos:d_end_pos, :);
fibo_high = fibo_data (:, 5);
fibo_low = fibo_data (:, 4);
fibo_open = fibo_data (:, 2);
fibo_close = fibo_data (:, 3);

% analysis period 
anal_peri = t_end - t_start + 1;

% Plot the Query Price Movement & add bull/bear color info
figure ('name', 'Fibonacci Retracement')
candle(fibo_high, fibo_low, fibo_close, fibo_open, 'k');
ch = get(gca, 'children');
set (ch(1), 'Facecolor', 'r');
set (ch(2), 'Facecolor', 'g');

% Find the local max price and local min price with the range specified
% find local maximum price in high price category
[fibo_max, pos_max] = max (fibo_high);
% find local minimum price in low price category
[fibo_min, pos_min] = min (fibo_low);

% Price Trend Determination
if (fibo_open(1) > fibo_close(end))
    flag = 0; % Down Trend
else
    flag = 1; % Up Trend
end

%% Fibonacci Levels Calculation

% Determine the precise locations of each six levels
fibo_range = fibo_max - fibo_min;

switch flag
    case 0                                      % Down Trend
        lvl_0 = fibo_min;                      % 0.0%
        lvl_5 = fibo_max;                      % 100.0%
        lvl_1 = 0.236 * fibo_range + lvl_0;     % 23.6%
        lvl_2 = 0.382 * fibo_range + lvl_0;     % 38.2%
        lvl_3 = 0.500 * fibo_range + lvl_0;     % 50.0%
        lvl_4 = 0.618 * fibo_range + lvl_0;     % 61.8%
    case 1                                      % Up Trend
        lvl_0 = fibo_max;                      % 100.0%
        lvl_5 = fibo_min;                      % 0%
        lvl_4 = (1-0.236) * fibo_range + lvl_5; % 23.6%
        lvl_3 = (1-0.382) * fibo_range + lvl_5; % 38.2%
        lvl_2 = (1-0.500) * fibo_range + lvl_5; % 50.0%
        lvl_1 = (1-0.618) * fibo_range + lvl_5; % 61.8%
end


%% Fibonacci Retracement Levels Plot
hold on
for i = 1 : 1 : anal_peri
    lvl_0_y(i) = lvl_0;
    lvl_1_y(i) = lvl_1;
    lvl_2_y(i) = lvl_2;
    lvl_3_y(i) = lvl_3;
    lvl_4_y(i) = lvl_4;
    lvl_5_y(i) = lvl_5;
end

switch flag
    case 0                                      % Down Trend
        plot (lvl_0_y, 'm')
        text (t_start+plot_offset_hori, lvl_0+plot_offset_vert, '0.0%', 'FontSize', 8)
        hold on
        plot (lvl_1_y, 'm')
        text (t_start+plot_offset_hori, lvl_1+plot_offset_vert, '23.6%', 'FontSize', 8)
        hold on
        plot (lvl_2_y, 'm')
        text (t_start+plot_offset_hori, lvl_2+plot_offset_vert, '38.2%', 'FontSize', 8)
        hold on
        plot (lvl_3_y, 'm')
        text (t_start+plot_offset_hori, lvl_3+plot_offset_vert, '50.0%', 'FontSize', 8)
        hold on
        plot (lvl_4_y, 'm')
        text (t_start+plot_offset_hori, lvl_4+plot_offset_vert, '61.8%', 'FontSize', 8)
        hold on
        plot (lvl_5_y, 'm') 
        text (t_start+plot_offset_hori, lvl_5+plot_offset_vert, '100.0%', 'FontSize', 8)
        
        xlabel 'Date'
        ylabel 'Price'
        title 'Fibonacci Retracement'
        
        
    case 1                                      % Up Trend
        plot (lvl_0_y, 'm')
        text (t_start+plot_offset_hori, lvl_0+plot_offset_vert, '100.0%', 'FontSize', 8)
        hold on
        plot (lvl_1_y, 'm')
        text (t_start+plot_offset_hori, lvl_1+plot_offset_vert, '61.8%', 'FontSize', 8)
        hold on
        plot (lvl_2_y, 'm')
        text (t_start+plot_offset_hori, lvl_2+plot_offset_vert, '50.0%', 'FontSize', 8)
        hold on
        plot (lvl_3_y, 'm')
        text (t_start+plot_offset_hori, lvl_3+plot_offset_vert, '38.2%', 'FontSize', 8)
        hold on
        plot (lvl_4_y, 'm')
        text (t_start+plot_offset_hori, lvl_4+plot_offset_vert, '23.6%', 'FontSize', 8)
        hold on
        plot (lvl_5_y, 'm') 
        text (t_start+plot_offset_hori, lvl_5+plot_offset_vert, '0.0%', 'FontSize', 8)
        
        xlabel 'Date'
        ylabel 'Price'
        title 'Fibonacci Retracement'
end













