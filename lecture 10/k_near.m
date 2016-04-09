function [p] = k_near(data,k)

n = length(data);
range = max(data) - min(data);
intervals = range/n;
X = min(data):intervals:max(data);

for i=1:length(X)
 
    [d index]= pdist2(data, X(i), 'euclidean', 'smallest', k);
    
    r = data(index);
    v = max(r) - min(r);
    p(i) = (k/n)/v;
    
end
plot(data,0,'*k')
hold on
plot(X,p,'r');
