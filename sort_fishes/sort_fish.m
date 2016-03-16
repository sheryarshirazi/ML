function [labels]=sort_fish(fishes,features,fish1,fish2,feature1,feature2)
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

	for fe_1 = 1:4
		for fe_2 = 1:4
			subplot(1,4,fe_1);
			plot(features(labels==fish1,fe_1),features(labels==fish1,fe_2),'*g');
			hold on
			plot(features(labels==fish2,fe_1),features(labels==fish2,fe_2),'*r');
		end
	end
end