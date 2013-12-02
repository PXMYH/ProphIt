%% SL_TP (Stop Loss / Take Profit) Description

% Description: 
% Stop Loss/ Take Profit is an necessary (even the most important) step 
% when dealing with FOREX trading. 
% In this script, users have two choices of setting the SL/TP value:
% 1) Mannually type in StopLoss and TAke Profit Price 
% 2) Set the S/L T/P range

% Function Usage:
% Input: Current decision(Buy/Sell); Current price at decision making;
% Processing Mode(Manual / Automatic)
% Output: StopLoss and Take Profit Price

% Example:
% [StopLoss, TakeProfit] = SL_TP (1.04568, 1, 'auto');
% [StopLoss, TakeProfit] = SL_TP (1.04568, 0, 'mannual');

% *************** Local Variables and Explaination ******************* 
% e.g
% dec_price: the price at which buy/sell decision is making
% dec: decision -- buy or sell (1 or 0)
% mode: manual price typing mode or automatic mode 
% SL_p: Stop Loss Price 
% TP_p: Take Profit Price
% state: price vadility checking
% SL_range: Stop Loss range parameter
% TP_range: Take Profit range parameter
% price_validity: subfucntion checks the validity of S/L T/P price typed in
% validity: price vadility result (1: Good; 0: Invalid)

% Modification Tips:
% e.g
% 1. add analysis time frame in, and plot the S/L T/P line in a separate
% figure where shows the analysis period candlestick

% |----------------- Modification Log ----------------------------|
% |ver 0.1     07/08/2012 Inital Script                           |
% |-----------------End of Modification Log ----------------------|

% Author: Michael (Yue) Hu
% Date: July 8, 2012
% (C) Copyright 2012 Unievrsity of British Columbia


%% S/L T/P Algorithm
function [SL_p, TP_p] = SL_TP (dec_price, dec, mode)           % main function

% dec: 0 - short selling
%      1 - long buying

if (strcmp(mode, 'mannual'))                         % Manual S/L, T/P entry mode 
    % Recieve SL/TP Price information
    disp 'For trading safety, please DO set stop loss/take profit threshold';
    fprintf ('current trading price is: %f  \n', dec_price);
    % Decision Conversion
    if (dec == 0)
        dec_str = 'Sell';
    elseif (dec == 1)
        dec_str = 'Buy';
    else % dec ==2
        dec_str =('Unknown');
    end
    fprintf ('Current Decision is: %s \n', dec_str);    
    SL_p = input ('Please type in the stop loss price (exact price):');
    TP_p = input ('Please type in the take profit price (exact price):');

    % Check the validity of SL/TP price
    state = price_validity (SL_p, TP_p, dec, dec_price);
    
    if (state == 0) % S/L & T/P price is wrong
        disp 'Invalid S/L & T/P!!!!';
        return;
    elseif (state == 1) % S/L & T/P price is correct
        disp 'Valid S/L T/P! Order is processed!'
        SL_p;
        TP_p;
    else % state == 2
        disp 'Unknown Validity State, Exiting Function ...';
        return
    end
    
elseif (strcmp(mode, 'auto'))                        % Automatic S/L, T/P entry mode 
    % Set S/L & T/P range in pips 
    SL_range = 10;
    TP_range = 15;
    
    if (dec == 0)       % Selling
        SL_p = dec_price + SL_range/10000;
        TP_p = dec_price - TP_range/10000;
    elseif (dec ==1)    % Buying
        SL_p = dec_price - SL_range/10000;
        TP_p = dec_price + TP_range/10000;
    else                % Unknown Decision
        disp 'Error! No buying/selling decision has been made! Exiting Function ...'  
    end
    
end


%% S/L & T/P Price Validity Check
function [validity] = price_validity (SL, TP, decision, dec_p)

% decision: 0 - short selling
%      1 - long buying

% validity: 0 - Invalid
%           1 - Valid
%           2 - Unknown

switch decision
    case 0  % Selling
        if (SL < dec_p || TP > dec_p)
            validity = 0;
        else
            validity = 1;
        end

    case 1  % Buying
        if (SL > dec_p || TP < dec_p)
            validity = 0;
        else
            validity = 1;
        end

    otherwise % Unknown decision
        validity = 2;
end









