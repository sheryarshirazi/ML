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
l_alp = regionprops(lc,'Image','FilledArea','FilledImage','BoundingBox','Area','MajorAxisLength','MinorAxisLength');

I=l_alp(10);
I_dot=l_alp(9);

J=l_alp(11);
J_dot=l_alp(12);

Idbb = I_dot.MajorAxisLength * I_dot.MinorAxisLength;
Jdbb = J_dot.MajorAxisLength * J_dot.MinorAxisLength;

I_new = adjusti(I.Image, I_dot.Image);
J_new = adjustj(J.Image, J_dot.Image);

%removing
l_alp(9).Image=I_new;
l_alp(10).Image=J_new;
to_be = [11 12];
l_alp(to_be) = [];

% unknown_c is a piece of original image containing all the unknown letters
% so we used regionprops function to separate every alphabet
unknown_alp = regionprops(unknown_c,'Image','BoundingBox','MajorAxisLength','MinorAxisLength');
statement = unknown_alp;
test = [];
to_be2 = [];
inc=1;
for i =1:length(unknown_alp)
    temp = unknown_alp(i).MajorAxisLength * unknown_alp(i).MinorAxisLength;

    if temp == Idbb
        new_img = adjusti(unknown_alp(i+1).Image,unknown_alp(i).Image);
        statement(i).Image = new_img;
        % to_be2(inc) = i+1;
        to_be2(end+1) = i+1;
    elseif temp == Jdbb
        new_img = adjustj(unknown_alp(i+1).Image,unknown_alp(i).Image);
        statement(i).Image = new_img;
        to_be2(end+1) = i+1;
    end

    statement(i).Image = normalise_image_size(statement(i).Image,max(size(statement(i).Image)));
    statement(i).Image = imresize(statement(i).Image,[40 40]);
    inc=inc+1;

end

%removing legs
statement(to_be2) = [];


% looping each of the uppercase alphabets to do following two tasks:
% first- normalize each alphabet i.e making aspect ratio 1:1
% second- resize the alphabet to a constant size
alp = [];
for i =1:length(u_alp)
    u_alp(i).Image = normalise_image_size(u_alp(i).Image,max(size(u_alp(i).Image)));
    u_alp(i).Image = imresize(u_alp(i).Image,[40 40]);
    alp(end + 1).Image = u_alp(i).Image;

end

% looping each of the lowercase alphabets to do following two tasks:
% first- normalize each alphabet i.e making aspect ratio 1:1
% second- resize the alphabet to a constant size
for i =1:length(l_alp)
    l_alp(i).Image = normalise_image_size(l_alp(i).Image,max(size(l_alp(i).Image)));
    l_alp(i).Image = imresize(l_alp(i).Image,[40 40]);
    alp(end + 1).Image = l_alp(i).Image;
end

% looping through the unknown alphabets to match each of the unknowns with the trained data

    for j= 1:length(statement)

        % Looping through the array of trained data to get matched alphabet
        for i = 1:length(alp)
            temp = alp(i).Image;
            temp2 = statement(j).Image;
            D(i) = sum(abs(temp(:) - temp2(:)));
        end

        % getting minimum distance i.e. its index and its value
        [m midx] = min(D);
        subplot(1,2,1); imshow(statement(j).Image)
        subplot(1,2,2); imshow(alp(midx).Image)
        drawnow
        pause(0.5);

    end

end


function alp = normalise_image_size(alp,maxS)

    Dif = maxS - size(alp);
    if rem(Dif(1), 2) == 0
        alp = padarray(alp,[Dif(1)/2 0],'both');
    else
        alp = padarray(alp,[(Dif(1)-1)/2 0],'both');
        alp = padarray(alp,[1 0],'post');
    end

    if rem(Dif(2), 2) == 0
        alp = padarray(alp,[0 Dif(2)/2],'both');
    else
        alp = padarray(alp,[0 (Dif(2)-1)/2],'both');
        alp = padarray(alp,[0 1],'post');
    end

end

function i = adjusti(alp, adot)
    alp = padarray(alp,[10 0],'pre');
    adot = padarray(adot,[22 0],'post');
    i = alp + adot;
    i = normalise_image_size(i,max(size(i)));
end

function j = adjustj(alp,adot)
    alp = padarray(alp,[10 0],'pre');
    adot = padarray(adot,[28 0],'post');
    adot = padarray(adot,[0 3],'pre');
    j = alp+adot;
    j = normalise_image_size(j,max(size(j)));
end