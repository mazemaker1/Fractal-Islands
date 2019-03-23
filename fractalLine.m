function [ xcoords, ycoords ] = fractalLine( xline, yline, xfract, yfract )
%Applies a fractal pattern to the input line
%   Takes in the coordinates of the two points defining the starting line,
%   xline and yline, and the coordinates that define the fractal pattern on
%   a unit line from (0,0) to (1,0), not inlucing the endpoints of the line.
%   Returns the coordinates of the fractal pattern applied to the input 
%   line, including endpoints

% get the length and angle of the input line
length = sqrt((xline(2)-xline(1))^2 + (yline(2)-yline(1))^2);
theta = atan((yline(2)-yline(1))/(xline(2)-xline(1)));
if xline(2) < xline(1)
    theta = theta + pi;
end

% add some randomness to the fractal pattern
st_dev = 0.1;
xfract = normrnd(xfract, st_dev);
yfract = normrnd(yfract, st_dev);

% get global coordinates of the fractal geometry (not ncluding end points)
xcoords_middle = xline(1)+length*(xfract*cos(theta)-yfract*sin(theta));
ycoords_middle = yline(1)+length*(yfract*cos(theta)+xfract*sin(theta));

% combine to form a new sequence of lines from the input line
xcoords = [xline(1), xcoords_middle, xline(2)];
ycoords = [yline(1), ycoords_middle, yline(2)];


end

