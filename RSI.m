function [normal,oversold,overbought,cold,hot]=RSI(data)
% RSI relative strength index 
%       
%        RSI is defined in the following way:
%           RSI = 100 - 100/(1+RS)
%           
%           whre RS is relative strength = (average gains)/(average loses)
%           whithin specified time interval
%
% Input: data of closing prices for the period of interest 
%        and period is the processing window width (assigned by default =
%        14)
% Output: Normal= market 40<RSI<60
%         Oversold= market 0<RSI<30        
%         Overbought= market 70<RSI<100   
%         Cold= market 0<RSI<20 
%         Hot= market  80<RSI<100
%
%   RSI 
%
%
%

%date = data(:,1);
RSI_high_price = data(:,3);
RSI_low_price =data(:,4);
RSI_close_price = data(:,5);
RSI_open_price = data(:,2);
%candle (high_price,low_price,close_price,open_price,'b');
data_rsi=rsindex(RSI_close_price);
%figure

%date_std = datestr(date);
%date_Con = strcat (date_std, {' '}, time);
%date_Con_num = datenum(date_Con);
plot(data_rsi,'r')
RSI_smmoth = smooth (data_rsi, 0.5, 'moving');
hold on
plot (RSI_smmoth);
%datetick ('x', 'mmm/dd/yy');

% indicators for action based on the RSI value
normal=0;
oversold=0;
overbought=0;
cold=0;
hot=0;


for i = 1:size(data_rsi) 
    if data_rsi(i) <= 20
        hot=1;
    elseif data_rsi(i) >= 80
        cold=1;
    elseif 60 >= data_rsi(i) >= 40
        normal=1;
    elseif data_rsi(i) <= 30
        oversold=1;
    elseif data_rsi(i) >= 70
        overbought=1;
    end
end
