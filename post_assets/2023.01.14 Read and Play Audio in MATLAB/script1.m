clc, clear, close all

ainfo = audioinfo("wanfeng.mp3");

[data, fs] = audioread("wanfeng.mp3", 'native');

% sound(data, fs)
% clear sound

t = 0:1/fs:floor(ainfo.Duration);
t = t(1:end-1);

data = data(1:numel(t),:);

figure
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
plot(t, data(:,1), DisplayName="left-channel")
plot(t,  data(:,2), DisplayName="right-channel")
legend()
xlim([t(1), t(end)])
xlabel('Time')
ylabel('Audio Signal')

