clc, clear, close all

% Prepare data
scores = [444 460 380 388 389
          387 366 500 467 460
          365 451 611 426 495
          548 412 452 471 402];
strikes = [9  6  5  7  5
           6  4  8 10  7
           4  7 16  9  9
           10  9  8  8  9];

% Plot into 3-by-3 layout
t = tiledlayout(3, 3); 

% Team 1
n(1) = nexttile;
bar([1 2 3 4], strikes(:,1))
title('Team 1 Strikes')

% Team 2
n(2) = nexttile;
bar([1 2 3 4], strikes(:,2))
title('Team 2 Strikes')

% Team 3
n(3) = nexttile;
bar([1 2 3 4], strikes(:,3))
title('Team 3 Strikes')

% Team 4
n(4)  = nexttile;
bar([1 2 3 4], strikes(:,4))
title('Team 4 Strikes')

% Team 5
n(5) = nexttile(7);
bar([1 2 3 4], strikes(:,5))
title('Team 5 Strikes')

% Compare scores of the teams
n(6) = nexttile(5, [2 2]);
plot([1 2 3 4], scores, '-.')
labels = {'Team 1', 'Team 2', 'Team 3', 'Team 4', 'Team 5'};
legend(labels, 'Location', 'northwest')
% Configure ticks and axis labels
xticks([1 2 3 4])
xlabel('Game')
ylabel('Score')
title('The sub title')

% Add layout title
title(t, 'April Bowling League Data')
