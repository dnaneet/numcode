function u = units(varargin)
% load the units package. Returns a struct containing the units.
%
% typical usage:
% >> u = units;
% >> velocity = 5*u.m/u.s % velocity in m/s
% 5*m/s
% >> t = 5*u.min % time in minutes
% 300*s
% >> d = velocity*t  %distance traveled
% 1500*m
% >> d.as(u.ft)
%
% ans =
%
% 4921.259843 ft

% if ~(datenum(version('-date')) >= datenum('March 18, 2011'))
%     error('You need at least Matlab R2011a to use units')
% end

if nargin > 0
    u = unit.units(varargin{:});
else
    u = unit.units;
end