clear variables; close all;

% **************************
% *** EDITABLE VARIABLES ***
% **************************
words = ["Red","Green","Blue"]; % What words you want to record
numTrain = 3; % number of training data for each word
recTime = 1; % record time in seconds
Fs = 8e3; % recording sampling frequency
nBits = 16; % number of bits to record audio in
NumChannels = 1; % number of channels to record from
DistanceMetric = "squared"; % euclidean, absolute, squared as options
% ***********
% *** END ***
% ***********

%% Record and save audio
recObj = audiorecorder(Fs,nBits,NumChannels); % creating record object

fprintf("Get Ready to record!\n");
pause(1);

for c = words
    eval(c+"=[];");
    for k = 1:numTrain
       fprintf("Click any button to start recording #"+num2str(k)+" for "+c+"\n");
       waitforbuttonpress;
       fprintf("Recording ...\n");
       recordblocking(recObj,recTime);
       fprintf("End recording #"+num2str(k)+" for "+c+"\n");
       pause(0.5);
       fprintf("Playing back recording #"+num2str(k)+" for "+c+"\n");
       play(recObj);
       pause(1);
       if k == 1; eval(c+"=getaudiodata(recObj);");
       else; eval("temp=getaudiodata(recObj);"); 
             eval(c+"=["+c+",temp];");
       end
    end
end

clear temp;

%% Plot saved audio
close all;

for c = words
    figure();
    for k = 1:numTrain
        subplot(numTrain,1,k);
        eval("plot(linspace(0,"+num2str(recTime)+","+num2str(recTime*Fs)+"),"+c+"(:,k),'k');");
        title("Recording #"+num2str(k)+" for "+c);
        xlabel("seconds"); ylabel("amplitude");
    end
end

%% Record input audio
recObj = audiorecorder(Fs,nBits,NumChannels); % creating record object
fprintf("Get Ready to record!\n");
pause(1);
fprintf("Click any button to start recording input audio\n");
waitforbuttonpress;
fprintf("Recording ...\n");
recordblocking(recObj,recTime);
fprintf("End recording\n");
pause(0.5);
fprintf("Playing back input audio recording\n");
play(recObj);
pause(1);
inputAudio = getaudiodata(recObj); % save input audio

% plot input audio
figure(); 
plot(linspace(0,recTime,recTime*Fs),inputAudio,'k');
title("Recording of Input Audio");


%% Calculate MFCC Coefficients

for c = words
   for k = 1:numTrain
       K = num2str(k);
       C = c+K;
       eval("coef"+C+"=mfcc("+c+"(:,k),Fs);");
   end
end

coefInputAudio = mfcc(inputAudio,Fs);

%% Calculate Dynamic Time Warping distance for MFCC coefficients
for i = 1:width(coefInputAudio)
    for c = words
       for k = 1:numTrain
           K = num2str(k);
           C = c+K;
           Ci = C+"_"+num2str(i);
           eval("[dist"+Ci+",x"+Ci+",y"+Ci+"]=dtw(coef"+C+"(:,i),coefInputAudio(:,i),'"+DistanceMetric+"');");
       end 
    end
end

%% Plot new warped signals
for c = words
    figure();
    for k = 1:numTrain
        subplot(numTrain,1,k);
        K = num2str(k);
        C = c+K;
        for i = width(coefInputAudio)
            Ci = C+"_"+num2str(i);
            hold on;
            eval("plot(coef"+C+"(x"+Ci+","+num2str(i)+"),'k')");
            hold on;
            eval("plot(coefInputAudio(y"+Ci+",i),'b');");
            hold on;
        end
        title("DTW of Input Audio vs. " + C);
    end
end

%% Calculate sum of distances

for c = words
    for k = 1:numTrain
        C = c+num2str(k);
        eval(C+"sum=0;");
        for i = 1:width(coefInputAudio)
            eval(C+"sum="+C+"sum + dist"+C+"_"+num2str(i)+";");
        end
    end
end

for c = words
    for k = 1:numTrain
        C = c+num2str(k);
        eval(C+"sum");
    end
end
