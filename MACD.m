function [buy_signal,sell_signal]=MACD(data)
% MACD - moving average convergence divergence indicator
%       macdvec is calculated by substracting 26SMA from 12SMA,
%       (defined by default, but can be specified for particular pair trade)
%       nineperma is the 9 period EMA (by default) of the macdvec and plays
%       the role of the signal Line
%       
%       Trades are performed based on the intersectation of two line
%       macdvec and nineperma 
%
%
%
%
%
close_price = data(:,5);
[macdvec, nineperma] = macd(close_price);
%figure
%title('MACD')
plot(macdvec,'b')
hold on
plot(nineperma,'r')

buy_signal=0;
sell_signal=0;
for i = 1:size(data)
    if macdvec(i) == nineperma(i)
        if macdvec(i-1)<nineperma(i-1)
            buy_signal=1; 
        else
            sell_signal=1;
        end
    end
end

