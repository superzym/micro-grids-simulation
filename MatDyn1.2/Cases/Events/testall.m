function [event,buschange,linechange] = testall

% testall
% MatDyn event data file
% 
% MatDyn
% Copyright (C) 2009 Stijn Cole
% Katholieke Universiteit Leuven
% Dept. Electrical Engineering (ESAT), Div. ELECTA
% Kasteelpark Arenberg 10
% 3001 Leuven-Heverlee, Belgium

%%

% event = [time type]
event=[ 0.2     1; 
        0.3     1;
        1       1;
        1.1     1;
        1.2     2;
        1.2     2;
        1.2     2;
        1.4     1];

% buschange = [time bus(row)  attribute(col) new_value]
buschange   = [0.2  6  6  -1e10;
               0.3  6  6  0;
               1    5  6  -1e10;
               1.1  5  6  0;
               1.4  7  3  0.9;
               1.4  7  4  0.5 ];

% linechange = [time  line(row)  attribute(col) new_value]
linechange = [1.2  2   3   0.1;
              1.2  2   4   0.2;
              1.2  2   5   0.3];

return;