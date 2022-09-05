clear all
close all

%% Get an hemodynamic response model
% SPM12's hrf (https://www.fil.ion.ucl.ac.uk/spm/)
RT = 1;
p = [];
T = 128;
[hrf,p] = spm_hrf(RT,p,T);
dt  = RT/T;
t = (0:dt:((length(hrf)-1)*dt))';
% Delay it by 200ms
delay = 0.2;
nt = round(delay/dt);

hrf2 = zeros(size(hrf));
hrf2(1+nt:end) = hrf(1:length(hrf2(1+nt:end)));

% Plot both
figure('WindowStyle','docked');
plot(t,hrf); hold on
[~,b] = max(hrf);
plot(t,hrf2)
[~,b2] = max(hrf2);
% t(b2)-t(b)
% dt*nt

% Fit the original model to the delayed model
a = hrf2\hrf;
display(['Amplitude error due to a ' delay 'sec misspecification of delay: ' num2str((1-a)*100,3) '%'])


