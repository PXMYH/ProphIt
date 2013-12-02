
clc
clear
close all


load DSP.mat
format long
% date_num = datenum(date);
% d = datevec (date);
% candle (high_price,low_price,close_price,open_price,'g');
candle (high_price,low_price,close_price,open_price,'g', date);
%axis on

%set(gca, 'XMinorTick', 'on');
% xticklabel_rotate([],45)

% set (gca, 'XTickLabel', num2str(get(gca,'XTick')','%d'))%#'
% xticklabel_rotate([],45)


% figure
% % specify the minor grid vector
% xg = [0:0.025:1];
% % specify the Y-position and the height of minor grids
% yg = [0 0.1];
% xx = reshape([xg;xg;NaN(1,length(xg))],1,length(xg)*3)
% yy = repmat([yg NaN],1,length(xg))
% h_minorgrid = plot(xx,yy,'r')
% axis([0 1 0 10])