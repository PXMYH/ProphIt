%% Accumulation/Distribution Description

% Description: 
% Developed by Marc Chaikin, the Accumulation Distribution Line is a 
% volume-based indicator designed to measure the cumulative flow of money 
% into and out of a security.
% This indicator can be used to affirm a security's underlying trend
% or anticipate reversals when the indicator diverges from the security price. 

% Function Usage:
% Three steps to Calculate ADL (Accumulation Distribution Line):
% Step 1: Money Flow Multiplier = [(Close-Low)-(High-Close)] / (High-Low) 
% Step 2: Money Flow Volume = Money Flow Multiplier * Volume for the Period
% Step 3: ADL = Previous ADL + Current Period's Money Flow Volume

% Input: Price Information Variable
% Output: Money Flow Multiplier
% Example:
% [MFM] = A_D (data);

% *************** Local Variables and Explaination ******************* 
% A_D_L
% A_D_data
% A_D_high
% A_D_low
% A_D_open
% A_D_close
% A_D_volume
% A_D_lh: A_D legend handler

% Modification Tips:
% 1. Figure out another way to plot A/D line and candlestick in the same
% graph. (Without using 1. plotyy (since it requires two set of Xs, Ys 
% which would sabotage the gola of object oriented programming); 
% 2. plot the candlestick chart and A/D Line in Control script)

% |----------------- Modification Log ----------------------------|
% |ver 0.1     07/06/2012 Inital Script                           |
% |ver 0.2     07/14/2012 Added A_D_L as a return variable        |
% |-----------------End of Modification Log ----------------------|

% Author: Michael (Yue) Hu
% Date: July 6, 2012
% (C) Copyright 2012 Unievrsity of British Columbia

%% A/D Algorithm

function [A_D_L, MFM] = A_D (data, A_D_date)

%% *********************** Price Info Preparation ************************
A_D_L_L = length(data);

A_D_data = data; % This could be omitted, for the purpose of protecting original data, keep it for now
A_D_high = data (:,5);
A_D_low = data(:,4);
A_D_open = data (:,2);
A_D_close = data (:,3);
A_D_volume = data (:, 1);

%% *********************** A/D Line Calculation **************************

A_D_L(1) = (((A_D_close(1) - A_D_low(1)) - (A_D_high(1) - A_D_close(1))) / (A_D_high(1) - A_D_low(1))) * A_D_volume(1);
for i = 2 : 1 : A_D_L_L 
% Step 1: Money Flow Multiplier Calculation
MFM(i) = ((A_D_close(i) - A_D_low(i)) - (A_D_high(i) - A_D_close(i))) / (A_D_high(i) - A_D_low(i));

% Step 2: Money Flow Multiplier * Volume
A_D_L(i) = MFM(i) * A_D_volume(i);

% Step 3: ADL = Previous ADL + Current Period's Money Flow Volume
A_D_L(i) = A_D_L(i) + A_D_L(i-1);
end

%% ************ Plot A/D line on the price graph *************************
hold on
ax1 = gca;
set(ax1,'XColor','k','YColor','k')
ax2 = axes('Position',get(ax1,'Position'),'XAxisLocation','top', ...
    'YAxisLocation','right','Color','none', 'XColor','k','YColor','k', ...
    'FontName', 'Lucida Calligraphy', 'FontSize', 10);
set(get(gca,'YLabel'),'String','Adjusted $ Flow', 'FontSize', 15, ...
                      'FontName', 'Lucida Calligraphy', 'FontWeight', 'Bold')
% line(1:A_D_L_L, A_D_L, 'Color','m','Parent',ax2);
line(A_D_date, A_D_L,'Color','m','Parent',ax2);

%datetick ('x', 'mmm/dd/yy');

h = legend ('A/D Line');
set (h, 'Color', 'none', 'EdgeColor', 'w', 'Location', 'NorthWest', ...
    'FontName', 'Lucida Calligraphy', 'FontSize', 10);





