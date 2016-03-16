%% myreg: create a regration line and plot on graph
function [b0 b1] = myreg(x, y, x_plot)

    if length(x) == length(y)

        n = length(x);

        x_bar = mean(x);
        y_bar = mean(y);

        diff_x = x - x_bar;
        diff_y = y - y_bar;

        prod_xy = diff_x .* diff_y;

        Sxy = sum(prod_xy) / (n-1);

        S_sqx = sum( (diff_x ) .^ 2  ) / (n-1);

        b1 = Sxy / S_sqx;
        b0 = y_bar - b1 .* x_bar;

        y_new = b0 + b1 * x;
        y_plot = b0 + b1 * x_plot;

        close all;

        plot(x,y,'*g');
        hold on
        plot(x,y_new,'b');     % Least square regression line
        plot(x_plot,0:y_plot,'*r'); % 0:y_plot y-axis 0 to y_plot
        plot(0:x_plot,y_plot,'*r'); % 0:x_plot x-axis 0 to x_plot
        plot(x_plot,y_plot,'om')    % plot spot on line
    end
end
