clear variables; close all;

opts = detectImportOptions("data.xls");
labels = opts.VariableNames;
data = readmatrix("data.xls");
clear opts;

eval(labels(1) + " = data(:,1);");

freq = [zeros(20,1);frequency];

freq_guess1 = 19.8 * exp(0.00995 * [1:715]);
freq_guess2 = 16.23 * exp(0.00995 * [1:715]);
freq_guess3 = 16.23 * exp(0.00951 * [1:715]);

er1 = abs(freq_guess1' - freq);
er2 = abs(freq_guess2' - freq);
er3 = abs(freq_guess3' - freq);


figure(); plot(er1,'r');
title("er1");

figure(); plot(er2,'r');
title("er2");

figure(); plot(er3,'r');
title("er3");


figure(); plot(freq,'k'); hold on; plot(freq_guess2,'r');
%figure(); plot(frequency,'k'); hold on;
%plot(freq_guess, freq_guess,'b'); hold on;

%error_ = frequency - freq_guess;
%plot(error_,'r');
