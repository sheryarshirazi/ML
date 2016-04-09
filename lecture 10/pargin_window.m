function [p] = pargin_window(data, window_size)
	close all;
	sigma = 1;

	X = [min(data) : window_size : max(data)];

	plot(X,0,'*r');
	hold on

	for i=1: length(data)
		P(i,:)= normpdf(X,data(i),sigma);
		plot(X,P(i,:),'k');
		hold on
		% drawnow
		% pause(0.02)
	end
	
	P= sum(P)/length(data);
	plot(X,P.*50,'g')
end

% mean 10 and 20 hai
% > data =[10+10.*randn(300,1)+20+10.*randn(300,1)]