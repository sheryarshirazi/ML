function [labels]=sort_fish(fishes,features,fish_1,fish_2)
	close all

	total_fishes = length(fishes);
	a = randperm(total_fishes); 			% Random sequence w.r.t bigger row or column
	rand_fishes = fishes(a);				% Random new fishes
	rand_features = features(a,:);			% Random new fishes measurements

	uni_fishes = unique(rand_fishes);		% unique fishes
	total_uni_fishes = length(uni_fishes);

	for j = 1:total_fishes

	    temp = rand_fishes{j};

	    for i = 1:total_uni_fishes
	        temp1 = uni_fishes{i};

	        if sum(temp(1:4)==temp1(1:4))==4 % temp(1:4) return first 4 characters of fish name
	            labels(j) = i;
	        end
	    end
	end

	counter = 1;
	for fe_1 = 1:4
		for fe_2 = 1:4
			if ~ (fe_1 == fe_2)

				subplot(1,12,counter);

				plot(rand_features(labels==fish_1,fe_1),rand_features(labels==fish_1,fe_2),'*g');
				hold on
				plot(rand_features(labels==fish_2,fe_1),rand_features(labels==fish_2,fe_2),'*r');
				counter = counter+1;
			end
		end
	end
end