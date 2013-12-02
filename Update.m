

% function [data] = Update ()
clear
clc

% url = 'http://www.fxhistoricaldata.com/download/EURUSD?t=hour';

% Download & Unzip
% Method #1
% [filestr, status] = urlwrite (url, 'EURUSD.zip');
% content = unzip ('EURUSD.zip');

% Method #2
% file_name = unzip (url);

% Check if there's any update
% i.e. use comparison in matlab


% Load Spreadsheet Information
file_name = 'EURUSD_hour.csv';
[num,txt,raw] = xlsread(file_name);
data_tmp= num;
volume(length(data_tmp),:) = 0;
open_price = data_tmp(:, 3); 
close_price = data_tmp(:, 6);
high_price = data_tmp(:, 5);
low_price = data_tmp(:, 4);
data = [volume open_price close_price low_price high_price];
save ('ProphIt.mat');





