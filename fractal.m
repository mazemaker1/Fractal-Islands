close all
clear all
clc

%% INPUT
nIterations = 5;     % number of ierations (not counting starting geometry)
% ^ keep this around 5 or 6 for 4-line fractal patterns, upt to like 12 is
% good for 2-line patterns

% starting geometry
xstart = [-0.5,0.5,0.5,-0.5,-0.5];     % x values of the points in the starting geometry
ystart = [-0.5,-0.5,0.5,0.5,-0.5];     % y values of the points in the starting geometry

% fractal shape
xfract = [0.33,0.67];     % x points in a unit fractal shape, not including ends
yfract = [-0.1,0.1];   % x points in a unit fractal shape, not including ends
% the ends have x values of 0 and 1, and y values of 0 and 0

% control the random adjustments to the start geometry
st_dev = 0.1;          % standard deviation of point location, previously only used in screensaver mode but now also used to randomly move starting geometry
% (random adjustments to the fractal geometry are handled in the fractalLine function and do not use this standard deviation)

% window size
plus_minus_x = 1.2; % centers window on origin and goes to the x value specified

% dont't need to edit this next stuff:
plus_minus_y = plus_minus_x; % centers window on origin and goes to the y value specified
xbounds = [-plus_minus_x,plus_minus_x];
ybounds = [-plus_minus_y,plus_minus_y];

% xbounds = [-1.5,1.5];   % manual entry of plot boundaries
% ybounds = [-1.5,1.5];

animation_pause = 0.25;  % the time between plotting each iteration, s

screensaver = 0;        % turn on screensaver mode to run continuously
% Not compatible with GNU Octave


%% CALCULATIONS/PLOTTING

% add randomness to the start points
xstart = normrnd(xstart, st_dev)
ystart = normrnd(ystart, st_dev)
xstart(end) = xstart(1)
ystart(end) = ystart(1)

% Plot the starting geometry
% hold on     % have hold on to see how it changes through the iterations
plot(xstart,ystart)
daspect([1,1,1])
xlim(xbounds)
ylim(ybounds)

x = xstart;
y = ystart;

if ~screensaver     % not screensaver mode
% Go through the iterations
for i = 1:nIterations
    
    % Initialize xnew and ynew
    xnew = zeros(1, ((length(xstart)-1)*(length(xfract)+1)^i)+1);
    ynew = zeros(1, ((length(ystart)-1)*(length(yfract)+1)^i)+1);
    xnew(1) = xstart(1);
    ynew(1) = ystart(1);
    
    % Go through each line in the pattern so far
    for j = 1:length(x)-1
        % Apply the fractal pattern to the line
        [xnewline,ynewline] = fractalLine(x([j,j+1]), y([j,j+1]), xfract, yfract);
        
        % Add the coordinates from the line to the list of all coords
        xnew((j-1)*(length(xfract)+1)+2:j*(length(xfract)+1)+1) = xnewline(2:length(xnewline));
        ynew((j-1)*(length(yfract)+1)+2:j*(length(yfract)+1)+1) = ynewline(2:length(ynewline));
    end
    
    % Update x and y coordinate lists
    x = xnew;
    y = ynew;
    
    % Plot animation
    pause(animation_pause)
    plot(x,y)
    xlim(xbounds)
    ylim(ybounds)
    daspect([1,1,1])   % sets plot aspect ratio
end
disp('Done')

else    % if screensaver mode is on (NOTHING BELOW THIS POINT IS CONVERTED TO GNU OCTAVE)
xfract_mean = xfract;
yfract_mean = yfract;
while true
    xfract = random('normal',xfract_mean,st_dev);
    yfract = random('normal',yfract_mean,st_dev);
    for i = 1:nIterations

        % Initialize xnew and ynew
        xnew = zeros(1, ((length(xstart)-1)*(length(xfract)+1)^i)+1);
        ynew = zeros(1, ((length(ystart)-1)*(length(yfract)+1)^i)+1);
        xnew(1) = xstart(1);
        ynew(1) = ystart(1);

        % Go through each line in the pattern so far
        for j = 1:length(x)-1
            % Apply the fractal pattern to the line
            [xnewline,ynewline] = fractalLine(x([j,j+1]), y([j,j+1]), xfract, yfract);

            % Add the coordinates from the line to the list of all coords
            xnew((j-1)*(length(xfract)+1)+2:j*(length(xfract)+1)+1) = xnewline(2:length(xnewline));
            ynew((j-1)*(length(yfract)+1)+2:j*(length(yfract)+1)+1) = ynewline(2:length(ynewline));
        end

        % Update x and y coordinate lists
        x = xnew;
        y = ynew;

        % Plot animation
        pause(animation_pause)
        plot(x,y)
        xlim(xbounds)
        ylim(ybounds)
        daspect([1,1,1])   % sets plot aspect ratio
    end
    
    pause(2*animation_pause)  % hold the pattern for a bit
    for i = 1:nIterations
        x = x(1:(length(xfract)+1):length(x));
        y = y(1:(length(yfract)+1):length(y));
        
        % Plot animation
        pause(animation_pause)
        plot(x,y)
        xlim(xbounds)
        ylim(ybounds)
        daspect([1,1,1])   % sets plot aspect ratio
    end
    
end
end


