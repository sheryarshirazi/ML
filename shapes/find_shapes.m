%% find_shapes: Categorizing shapes with its properties
%  Major axis, Minor axis, area, area of bounding box
function find_shapes(I,shape)
    close all;

    bw = ~ im2bw(I,0.99);    % convert into black and white and invert
    symbol_labels = bwlabel(bw);            % label shapes in image
    blank_img = zeros(size(symbol_labels));        % making blank image of same size

    symbols = regionprops(symbol_labels,{'Area','MajorAxisLength','MinorAxisLength','BoundingBox'});

    for i=1:length(symbols)

        A = symbols(i).Area ;
        Maj = symbols(i).MajorAxisLength;
        Min = symbols(i).MinorAxisLength;
        ABB =  symbols(i).BoundingBox(3)* symbols(i).BoundingBox(4); % calculating area by producting sides

        switch(shape)

            case 'circle'
                % circle and square have major and minor axis are equal
                if Maj/Min >0.99 && Maj/Min<1.01

                    % among circle and square square has area of bounding box is zero
                    if ABB/A >1.05
                        blank_img = or(blank_img,symbol_labels==i) ;
                    end
                end
            case 'square'
                % circle and square have major and minor axis are equal
                if Maj/Min >0.99 && Maj/Min<1.01

                    % among circle and square square has area of bounding box is zero
                    if ABB/A <1.01 &&ABB/A >0.99
                        blank_img = or(blank_img,symbol_labels==i);
                    end
                end

            case 'triangle'
                % triangle hase area of bounding box is equal to area
                if A/(ABB/2)>0.9 && A/(ABB/2)<1.1
                    blank_img= or(blank_img,symbol_labels==i);
                end

            case 'rectangle'
                % rectangle's major and minor axes are not equal
                if Maj/Min >1.05
                    % area of rectangle is equal to its area of bounding box
                    if ABB/A <1.01 && ABB/A >0.99
                        blank_img = or(blank_img,symbol_labels==i);
                    end
                end
        end

        imshow(blank_img)
    end
end