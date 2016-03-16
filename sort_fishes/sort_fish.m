function [labels]=sort_fish(fishes,features)
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

	for fi = 1:2
		fi_1 = fi;

		if fi_1 == 1
			fi_2 = 2;
		else
			fi_2 = 1;
		end

		for fe_1 = 1:4
			for fe_2 = 1:4
				if ~ (fe_1 == fe_2)
					component = fe_1;
					if fi_2 == 1
						component = fe_1+4;
					end
					subplot(1,8,component);

					plot(features(labels==fi_1,fe_1),features(labels==fi_1,fe_2),'*g');
					hold on
					plot(features(labels==fi_2,fe_1),features(labels==fi_2,fe_2),'*r');
				end
			end
		end
	end
end