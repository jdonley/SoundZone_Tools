function [ y ] = SineSweepExp( t,f0,t1,f1 )
%EXPSINESWEEP Summary of this function goes here
%   Detailed explanation goes here
w1 = 2*pi*f0;
w2 = 2*pi*f1;
y = sin(  w1*t1 ./ (log(w2/w1)) .* (exp(t./t1.*log(w2/w1))-1)  );

t_ = 1:16000;
y(t_) = y(t_) .* linspace(0,1,length(t_));

t_ = (length(y)-320):length(y);
y(t_) = y(t_) .* linspace(1,0,length(t_));

end

