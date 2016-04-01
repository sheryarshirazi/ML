function character_recog(I)

% converting Original Image to Black White
bw = ~im2bw(I,0.99);

% getting section of image containing lower case alphabets
lc = bw(13:47,:);

% getting section of image containing upper case alphabets
uc = bw(90:123,:);

% getting section of image containing unknown alphabets
unknown_c = bw(170:205,:);

% uc is a piece of original image containing all the upper case letters
% so we used regionprops function to separate every alphabet
u_alp = regionprops(uc,'Image');

% lc is a piece of original image containing all the lower case letters
% so we used regionprops function to separate every alphabet
l_alp = regionprops(lc,'Image','FilledArea','FilledImage','BoundingBox');
i=l_alp(10);
i_dot=l_alp(9);
% max(size(i.Image))
% i_padded = normalise_image_size(i.Image,max(size(i.Image)));
i_dot_padded = normalise_image_size(i_dot.Image,max(size(i_dot.Image)));
imshow(i_dot_padded);
j=l_alp(11);
j_dot=l_alp(12);
% imshow(j.Image);

% unknown_c is a piece of original image containing all the unknown letters
% so we used regionprops function to separate every alphabet
unknown_alp = regionprops(unknown_c,'Image');

% looping each of the uppercase alphabets to do following two tasks:
% first- normalize each alphabet i.e making aspect ratio 1:1
% second- resize the alphabet to a constant size
% for i =1:length(u_alp)
%     u_alp(i).Image = normalise_image_size(u_alp(i).Image,max(size(u_alp(i).Image)));
%     u_alp(i).Image = imresize(u_alp(i).Image,[40 40]);
% end

% looping each of the lowercase alphabets to do following two tasks:
% first- normalize each alphabet i.e making aspect ratio 1:1
% second- resize the alphabet to a constant size
% for i =1:length(l_alp)
%     l_alp(i).Image = normalise_image_size(l_alp(i).Image,max(size(l_alp(i).Image)));
%     l_alp(i).Image = imresize(l_alp(i).Image,[40 40]);
% end

% looping each of the unknown alphabets to do following two tasks:
% first- normalize each alphabet i.e making aspect ratio 1:1
% second- resize the alphabet to a constant size
% for i =1:length(unknown_alp)
%     unknown_alp(i).Image = normalise_image_size(unknown_alp(i).Image,max(size(unknown_alp(i).Image)));
%     unknown_alp(i).Image = imresize(unknown_alp(i).Image,[40 40]);
% end


% combining uppercase and lowercase alphabets into a single array
% alp = [u_alp; l_alp];


% looping through the unknown alphabets to match each of the unknowns with the trained data

    % for j= 1:length(unknown_alp)

    %     % Looping through the array of trained data to get matched alphabet
    %     for i = 1:length(alp)
    %         temp = alp(i).Image;
    %         temp2 = unknown_alp(j).Image;
    %         D(i) = sum(abs(temp(:) - temp2(:)));
    %     end

    %     % getting minimum distance i.e. its index and its value
    %     [m midx] = min(D);
    %     subplot(1,2,1); imshow(unknown_alp(j).Image)
    %     subplot(1,2,2); imshow(alp(midx).Image)
    %     drawnow
    %     pause(2)

    % end

end


function alp = normalise_image_size(alp,maxS)


        Dif = maxS - size(alp)
        % alp = padarray(alp,[0 Dif(2)/2],'both');
        maxS
        alp = padarray(alp,[22 0],'post');
        max(size(alp))

        % if rem(Dif(1), 2) == 0
        %     alp = padarray(alp,[Dif(1)/2 0],'both');
        % else
        %     alp = padarray(alp,[(Dif(1)-1)/2 0],'both');
        %     alp = padarray(alp,[1 0],'post');
        % end

        % if rem(Dif(2), 2) == 0
        %     alp = padarray(alp,[0 Dif(2)/2],'both');
        % else
        %     alp = padarray(alp,[0 (Dif(2)-1)/2],'both');
        %     alp = padarray(alp,[0 1],'post');
        % end

    end

