%% SupportandResistance Description

% Description: This code plots 2 sets of lines. The first set of lines is
% the support and resistance trendline, which is basically similar to the
% line of best fit used in standard data plots, except it is deviated
% upwards and downwards based on the average price. 
%
% The second set of lines corresponds to different sections of the
% candlestick chart. It represents the local support and resistance levels,
% and unlike the trendlines it is flat only. It will only appear when there
% are two or more local maximums or minimums (meaning there are two peaks
% and inverse peaks) to show a stable level of support and resistance.

% Function Usage: To plot the support and resistance levels.
% Input: Price Data
% Output: Two trendlines, local support and resistance levels (up to 6
% pairs of lines).

% Example: ?


% *************** Local Variables and Explanation ******************* 
% p1, p2, p3, p4, p5, p6 => Pivot lines for each section of the chart

% r11, r21, r31, r41, r51, r61 => First resistance level for each section
% of the chart, with r2_ and r3_ being the second and third levels

% s__ => support levels, same as resistance levels

% trend_support and trend_resistance => trend lines for support and
% resistance, indicating the general trend

% Modification Tips:
% e.g
% The candlestick plotting data follows the following order: OPEN, CLOSE, % MIN, MAX, i.e. opening price, closing price, high price, low price

% |----------------- Modification Log ----------------------------|
% |ver 0.1     07/09/2012 Inital Script                           |
% |ver 0.2     07/10/2012 Implementing tick automation, attempting to fix candlestick problem after introducing new dates              |
% |               |
% |     |
% |-----------------End of Modification Log ----------------------|

% Author: Gary Tse, 12013074
% Date: July 9, 2012
% (C) Copyright 2012 University of British Columbia


% % Load the price levels
% clear; clc;
% load('data.mat')
% load('textdata.mat')
% format longG %Preserves the exponent and decimals in the serial date number arrays while being in double format
% 
% % Fixes date issue, 7/10/2012
% date = textdata(2:5987,1);
% time = textdata(2:5987,2);
% 
% date_std = datestr(date);
% date_Con = strcat (date_std, {' '}, time);
% date_Con_num = datenum(date_Con);
% candle (data(:,5),data(:,4),data(:,3),data(:,2)); 
% %datetick ('x', 'mmm/dd/yy');

function [] = Supoort_Resistance (data)
hold on;


% Set number of ticks on x-axis to number of points in xData
%startDate = datenum(date_Con_num(1));
%endDate = datenum(date_Con_num(length(date_Con_num)));
%xData = linspace(startDate,endDate, length(date_Con_num));
% 
% set(gca,'XTick', date_Con_num);
% datetickzoom('x', 'keepticks', 'keeplimits')
% axis 'auto'


%1) Calculate the average open - closing price
avgOpen = mean(data(:,2));
avgClose = mean(data(:,3));

%3) Plot a trendline based on the average_difference added 
%Algorithm hints taken from http://faculty.cs.niu.edu/~hutchins/csci230/best-fit.htm
x=1:length(data(:,2));

%Get sum of all x values and the sum of all x values squared
%Get sum of all y values and the sum of all y values squared
sumX = sum(x);
sumX2 = sum(x.^2);
sumY=0;
sumY2=0;
sumXY=0;
for i=1:5986
    avgPrice = (data(i,2)+data(i,3))/2;
    sumY = sumY+avgPrice;
end
for i=1:5986
    avgPrice = (data(i,2)+data(i,3))/2;
    sumY2 = sumY2+avgPrice^2;
end
%Get sum of all x multiplied by y values
for i=1:5986
    sumXY = sumXY+( i * (data(i,2)+data(i,3))/2);
end

XMean = sumX/5986;
YMean = sumY/5986;
slope = (sumXY - sumX * YMean) / (sumX2 - sumX * XMean);
YInt = YMean - slope * XMean;
trend_support = plot(x,slope*x + (YInt + (avgOpen - YInt)/2),'black'); %Support in red
trend_resistance = plot(x,slope*x + (YInt - (avgClose - YInt)/2),'black'); %Resistance in green
% Make the trendlines easier to spot 
set(trend_support, 'LineWidth', 2)
set(trend_resistance, 'LineWidth', 2)

% Plot THREE pairs of local support and resistance levels in SIX sections of the chart 
% The following is based on the most widely used "industry" method of calculating
% the pivot points, as well as support and resistance.

% The formulas are as follows:
% Pivot = (Open + High + Low + Close)/4

% P = Pivot
% L = Low Price (average of the section)
% H = High Price (average of the section)

% First, designate the price data variables for each section
sectionLength = round(length(data(:,1))/6)-1;

% Opening prices are on the 5th column of 'data.mat', and are based on the
% first price of the section
o1 = data(1,5);
o2 = data(sectionLength,5);
o3 = data(sectionLength*3,5);
o4 = data(sectionLength*4,5);
o5 = data(sectionLength*5,5);
o6 = data(sectionLength*6,5);

% Closing prices are on the 4th column of 'data.mat', and are based on the
% last price of the section
c1 = data(sectionLength,4);
c2 = data(sectionLength*2,4);
c3 = data(sectionLength*3,4);
c4 = data(sectionLength*4,4);
c5 = data(sectionLength*5,4);
c6 = data(length(data(:,4)),4);

% Low prices are on the 3rd column of 'data.mat', and are based on the
% minimum of price of the section's low prices
l1 = min(data(1:sectionLength,3));
l2 = min(data(sectionLength:sectionLength*2,3));
l3 = min(data(sectionLength*2:sectionLength*3,3));
l4 = min(data(sectionLength*3:sectionLength*4,3));
l5 = min(data(sectionLength*4:sectionLength*5,3));
l6 = min(data(sectionLength*5:length(data(:,3)),3));

% High prices are on the 2nd column of 'data.mat', and are based on the
% maximum of price of the section's high prices
h1 = max(data(1:sectionLength,2));
h2 = max(data(sectionLength:sectionLength*2,2));
h3 = max(data(sectionLength*2:sectionLength*3,2));
h4 = max(data(sectionLength*3:sectionLength*4,2));
h5 = max(data(sectionLength*4:sectionLength*5,2));
h6 = max(data(sectionLength*5:length(data(:,2)),2));

% Section 1
p1 = (o1+h1+l1+c1)/4;
line([1;sectionLength],[p1(1);p1(1)],'Color','y')
r11 = 2*p1-l1;
line([1;sectionLength],[r11(1);r11(1)],'Color','g')
s11 = 2*p1-h1;
line([1;sectionLength],[s11(1);s11(1)],'Color','r')
r12 = p1+(h1-l1);
line([1;sectionLength],[r12(1);r12(1)],'Color','g')
s12 = p1-(h1-l1);
line([1;sectionLength],[s12(1);s12(1)],'Color','r')
r13 = h1+2*(p1-l1);
line([1;sectionLength],[r13(1);r13(1)],'Color','g')
s13 = l1-2*(h1-p1);
line([1;sectionLength],[s13(1);s13(1)],'Color','r')

% Section 2
p2 = (o2+h2+l2+c2)/4;
line([sectionLength;sectionLength*2],[p2(1);p2(1)],'Color','y')
r21 = 2*p2-l2;
line([sectionLength;sectionLength*2],[r21(1);r21(1)],'Color','g')
s21 = 2*p2-h2;
line([sectionLength;sectionLength*2],[s21(1);s21(1)],'Color','r')
r22 = p2+(h2-l2);
line([sectionLength;sectionLength*2],[r22(1);r22(1)],'Color','g')
s22 = p2-(h2-l2);
line([sectionLength;sectionLength*2],[s22(1);s22(1)],'Color','r')
r23 = h2+2*(p2-l2);
line([sectionLength;sectionLength*2],[r23(1);r23(1)],'Color','g')
s23 = l2-2*(h2-p2);
line([sectionLength;sectionLength*2],[s23(1);s23(1)],'Color','r')

% Section 3
p3 = (o3+h3+l3+c1)/4;
line([sectionLength*2;sectionLength*3],[p3(1);p3(1)],'Color','y')
r31 = 2*p3-l3;
line([sectionLength*2;sectionLength*3],[r31(1);r31(1)],'Color','g')
s31 = 2*p3-h3;
line([sectionLength*2;sectionLength*3],[s31(1);s31(1)],'Color','r')
r32 = p3+(h3-l3);
line([sectionLength*2;sectionLength*3],[r32(1);r32(1)],'Color','g')
s32 = p3-(h3-l3);
line([sectionLength*2;sectionLength*3],[s32(1);s32(1)],'Color','r')
r33 = h3+2*(p3-l3);
line([sectionLength*2;sectionLength*3],[r33(1);r33(1)],'Color','g')
s33 = l3-2*(h3-p3);
line([sectionLength*2;sectionLength*3],[s33(1);s33(1)],'Color','r')

% Section 4
p4 = (o4+h4+l4+c1)/4;
line([sectionLength*3;sectionLength*4],[p4(1);p4(1)],'Color','y')
r41 = 2*p4-l4;
line([sectionLength*3;sectionLength*4],[r41(1);r41(1)],'Color','g')
s41 = 2*p4-h4;
line([sectionLength*3;sectionLength*4],[s41(1);s41(1)],'Color','r')
r42 = p4+(h4-l4);
line([sectionLength*3;sectionLength*4],[r42(1);r42(1)],'Color','g')
s42 = p4-(h4-l4);
line([sectionLength*3;sectionLength*4],[s42(1);s42(1)],'Color','r')
r43 = h4+2*(p4-l4);
line([sectionLength*3;sectionLength*4],[r43(1);r43(1)],'Color','g')
s43 = l4-2*(h4-p4);
line([sectionLength*3;sectionLength*4],[s43(1);s43(1)],'Color','r')

% Section 5
p5 = (o5+h5+l5+c1)/4;
line([sectionLength*4;sectionLength*5],[p5(1);p5(1)],'Color','y')
r51 = 2*p5-l5;
line([sectionLength*4;sectionLength*5],[r51(1);r51(1)],'Color','g')
s51 = 2*p5-h5;
line([sectionLength*4;sectionLength*5],[s51(1);s51(1)],'Color','r')
r52 = p5+(h5-l5);
line([sectionLength*4;sectionLength*5],[r52(1);r52(1)],'Color','g')
s52 = p5-(h5-l5);
line([sectionLength*4;sectionLength*5],[s52(1);s52(1)],'Color','r')
r53 = h5+2*(p5-l5);
line([sectionLength*4;sectionLength*5],[r53(1);r53(1)],'Color','g')
s53 = l5-2*(h5-p5);
line([sectionLength*4;sectionLength*5],[s53(1);s53(1)],'Color','r')

% Section 6
p6 = (o6+h6+l6+c1)/4;
line([sectionLength*5;length(data(:,1))],[p6(1);p6(1)],'Color','y')
r61 = 2*p6-l6;
line([sectionLength*5;length(data(:,1))],[r61(1);r61(1)],'Color','g')
s61 = 2*p6-h6;
line([sectionLength*5;length(data(:,1))],[s61(1);s61(1)],'Color','r')
r62 = p6+(h6-l6);
line([sectionLength*5;length(data(:,1))],[r62(1);r62(1)],'Color','g')
s62 = p6-(h6-l6);
line([sectionLength*5;length(data(:,1))],[s62(1);s62(1)],'Color','r')
r63 = h6+2*(p6-l6);
line([sectionLength*5;length(data(:,1))],[r63(1);r63(1)],'Color','g')
s63 = l6-2*(h6-p6);
line([sectionLength*5;length(data(:,1))],[s63(1);s63(1)],'Color','r')

%%%%%%%%%%% END %%%%%%%%%%%%%