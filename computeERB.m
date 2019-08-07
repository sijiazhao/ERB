% Copyright (c) 2019, Sijia Zhao.  All rights reserved.
clear; close all;
addpath('.\erb\');
path_in = '.\Sounds\';
files = dir([path_in '*.wav']);

ERB = [];
%% calculate ERB loudness with mean(mean(ERBpower(x,sr).^0.3))
for s = 1:numel(files)
    filename = [path_in files(s).name];
    [signal,fs] = audioread(filename);
    ERB = [ERB; mean(mean(ERBpower(signal,fs).^0.3))];
end

if 1
    [ERB_sorted, I] = sort(ERB);
else
    ERB_sorted = ERB;
    I = 1:numel(files);
    I = I';
end

% barplot of sorted ERB with orginal sound name
figure(1); clf;
hold on;
bar(ERB_sorted,'FaceColor',[0 0 0]);
set(gca,'XTick',1:1:numel(files));
set(gca,'XTickLabel',I);
yl = ylim;
xlim([0 numel(files)+1]);
ccount = 0;
for s = I'
    ccount = ccount+1;
    soundname = files(s).name;
    soundname = strrep(soundname,'_',' ');
    soundname = strrep(soundname,'.wav','');
    mytext = [soundname ' = ' num2str(round(ERB(s),3))];
    
    t = text(ccount,min(yl),mytext,'Color',[1,1,1]);
    set(t,'Rotation',90);
    set(t,'Fontsize',12);
end
hold off;
title('ERB power sorted');
ylabel('ERB power');

ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

filename = ['fig01_ERB'];
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6/10*numel(files)+2.5 5]);
print(filename,'-dpng');

condlist = {};
for s = 1:numel(files)
    soundname = files(s).name;
    soundname = strrep(soundname,'_',' ');
    soundname = strrep(soundname,'.wav','');
    condlist{s} = soundname;
end
save('ERB','ERB','condlist');
