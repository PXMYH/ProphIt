%% Main Control Console Description
% Description: 

% Function Usage:
% Input:
% Output

% Example:

% *************** Local Variables and Explaination ******************* 


% Modification Tips:

% |----------------- Modification Log ----------------------------|
% |ver 0.1     07/05/2012 Inital Script                           |
% |ver 0.2     07/08/2012 Added S/L & T/P function                |
% |ver 0.21    07/09/2012 Finalized Date Display on X axis        |
% |ver 0.3     07/16/2012 Added Prediction Algorithm              |
% |-----------------End of Modification Log ----------------------|

% Author: Michael (Yue) Hu
% Date: May 20, 2012
% (C) Copyright 2012 Unievrsity of British Columbia

%% Main Control Console Algorithm

clc
clear
close all

% disp('Contents of workspace before loading file:')
% whos
% 
% disp('Contents of DSP.mat:')
% whos -file DSp.mat
% 
load DSP.mat
 
high_price = data (:,5);
low_price = data(:,4);
open_price = data (:,2);
close_price = data (:,3);

% Date Format Covertion
% 1. First convert to standard dd/mmm/yyyy format
date_std = datestr(date);
date_Con = strcat (date_std, {' '}, time);
date_Con_num = datenum(date_Con);

% load ProphIt.mat
% disp('Contents of workspace after loading file:')
% whos

%% ******************* Candlestick Chart Processing ***********************
figure ('name', 'Forex Historical Hourly Data for EUR/USD', 'NumberTitle', 'off')
set(gca,'Units','centimeters','pos',[2,0.833,33,16]) % Set candlestick chart position
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure. 

% Transform Date format for candlestick chart plotting
% date_num = datenum(date);
% candle (high_price,low_price,close_price,open_price,'b', date_num, 2);
% figure
 candle (high_price,low_price,close_price,open_price,'b');
% candle (high_price,low_price,close_price,open_price,'b', date_Con_num);

% Legend Processing
lh = legend ('CandleStick', 'Bull','Bear');
set (lh, 'EdgeColor','w', 'FontWeight', 'Bold', 'FontSize', 10, ...
         'FontName', 'Lucida Calligraphy');

% Bull/Bear Candle Processing
ch = get(gca, 'children');
set (ch(1), 'Facecolor', 'r', 'EdgeColor', 'r');
set (ch(2), 'Facecolor', 'g', 'EdgeColor', 'g');
% set (ch(3), 'Color', 'b');

% Tick and Date Display Format
set(gca, 'XMinorTick', 'on');
datetick ('x', 'mmm/dd/yy');
xticklabel_rotate([],20);
set(gca, 'FontName', 'Lucida Calligraphy');
xlabel ('Date', 'Units', 'centimeters','VerticalAlignment', 'bottom', ...
        'FontWeight', 'Bold', 'FontSize', 16, 'FontName', 'Lucida Calligraphy');
ylabel ('Price', 'Units', 'centimeters','VerticalAlignment', 'bottom', ...
        'FontWeight', 'Bold', 'FontSize', 16, 'FontName', 'Lucida Calligraphy');
title ('Forex Historical Hourly Data for EUR/USD','Units', 'centimeters', ...
       'VerticalAlignment', 'bottom', 'FontWeight', 'Bold', ...
       'FontSize', 16, 'FontName', 'Lucida Calligraphy', ...
       'Units', 'centimeters', 'pos', [15, 16]);
grid on;

%% **************** Resistance / Support / Trend line *********************
% [r1, r2] = Support_Resistance (data);

%% ******************* Simple Moving Average (SMA) ************************
% FIR Filter
%   [SMA_L, SMA_lag] = SMA (200, data);

%% ******************* Weighted Moving Average (WMA) **********************
% FIR Filter
%   [WMA_L, WMA_lag] = WMA (8, data);

%% ******************* Exponential Moving Average (EMA) *******************
% IIR Filter
%   [EMA_W, EMA_lag] = EMA (8, data);

%% ******************* Combined Moving Average ****************************
% [MA_L,lag] = MA (8, data, 'simple');


%% ************* Accumulation/ Distribution (A/D) *************************
%    [MFM] = A_D (data, date_Con_num);

%% ******************* Fibonacci Retracement ******************************

%    for i = 1 : 1 : length (date)
%        d_tmp (i) = i;
%    end
%    
%    [L0, L1, L2, L3, L4, L5] = Fibo (1,2400,d_tmp,data);

%% ****************** Relative Strength Index (RSI) ***********************
%  [normal,oversold,overbaught,cold,hot]= RSI(data);

%% ************* Moving Average Convergence/Divergence (MACD) *************
%  [buy_signal,sell_signal] = MACD(data);

%% **************** Stop Loss / Take Profit (S/L & T/P) *******************
% [StopLoss, TakeProfit] = SL_TP (1.04568, 1, 'mannual');




%% ************************** Trading Algorithm ***************************

% Step 1: MA with analysis window width set to 200 to determine trend
% Step 2: Verify the trend with A/D line result 
% Step 3: Using RSI determine the bull/bear zone to decide whether enter
%         market
% Step 4: MACD cross point to determine entry price
% Step 5: Resistence/ Support to determine rough resistance support level
% Step 6: Fibonacci to determine exact price range
% Step 7: Return relatively accurate support/resistance price level

% Narrow down the date range (i.e. Analyze recent data)
% date_recent = (); % use real date here
days = 10;
start = length (data) - 24*1*days;
% date_recent = date(start:end);
high_recent = high_price (start: end);
low_recent = low_price (start : end);
open_recent = open_price (start : end);
close_recent = close_price (start : end);
volume = ones(24*1*days+1,1);
data_recent = [volume open_recent close_recent low_recent high_recent];

figure ('name', 'Hourly Price Info for Last 10 days')
subplot (311)
candle (high_recent,low_recent,close_recent,open_recent,'b');

% Price Trend Determination
disp 'Trend determined by SMA'
[SMA_price, SMA_L, SMA_lag] = SMA (50, data_recent);
if (SMA_price(end) - SMA_price(end-1) >  0)
    disp 'Up Trend'
    trend_sig = 1;  % Up Trend
else
    disp 'Down  Trend'
    trend_sig = 0;  % Down  Trend
end

% Trend Verification
disp 'Trend determined by A/D'
date_recent = 1 : length(data_recent);
[A_D_val, MFM] = A_D (data_recent, date_recent);
A_D_smooth = smoothts (A_D_val, 'b', 50);
hold on 
plot (A_D_smooth, 'g')

if (A_D_smooth(end) - A_D_smooth(end-1) >  0)
    disp 'Up Trend'
    trend_sig_veri = 1;  % Up Trend
else
    disp 'Down  Trend'
    trend_sig_veri = 0;  % Down  Trend
end

if (trend_sig == trend_sig_veri)
    agree = 1;
    disp 'Decision Verified, Moving on ...'
else
    agree = 0;
    disp 'Error, two indicators contradict with each other, human discretion is needed!!'
    % catch () % return an error message and exit the program
end

% Bull/Bear Zone determination
hold on
subplot (312)
[normal,oversold,overbaught,cold,hot]= RSI(data_recent);

if (trend_sig == 0 && oversold == 1) % Buying Signal
    buy = 1;
    sell = 0;
    disp 'The dicision is to Buy'
elseif (trend_sig == 1 && overbought == 1) % Selling Signal
    buy = 0;
    sell = 1;
    disp 'The dicision is to Sell'
else
    display 'Do Not Enter the Market Now !!!'
end

% Entry Price Determination
subplot (313)
hold on
[buy_signal,sell_signal] = MACD(data_recent);
% Waiting for YErzhan to return the buy/sell price information
% for now assume buy_price = 1.0344

dec_price = 1.2533;
fprintf ('The entry price is %f\n', dec_price)

% Use 300 points before the buy/sell price to determine the price
% retracement range
% [L0, L1, L2, L3, L4, L5] = Fibo (1,now - 300,d_tmp,data);

% Finally, set the TP/SL price
[StopLoss, TakeProfit] = SL_TP (dec_price, 1, 'auto');
fprintf ('StopLoss price is: %f\n', StopLoss)
fprintf ('TakeProfit price is: %f\n', TakeProfit)

