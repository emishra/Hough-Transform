function [Im] = myEdgeFilter(img, sigma)

rows = size(img, 1);
cols = size(img, 2);

res = zeros(size(img));

hsize = 2*ceil(3*sigma)+1;

h = fspecial('gaussian', hsize, sigma);

smooth = myImageFilter(img, h);

h_sobel = fspecial('sobel');

v_sobel = transpose(h_sobel);

Ix = myImageFilter(smooth, h_sobel);

Iy = myImageFilter(smooth, v_sobel);

%get magnitudes

fun = @(x, y) sqrt(x*x + y*y);

for row = 1:rows
    for col = 1:cols
        dx = Ix(row, col);
        dy = Iy(row, col);
        mag = fun(dx, dy);
        res(row, col) = mag;
        
    end
end

%nms

padres = padarray(res, [1,1]);

for row = 2:(rows+1)
    for col = 2:(cols+1)
        
        r = row - 1;
        c = col - 1;
        
        current = padres(row, col);
        
        dx = Ix(r, c);
        dy = Iy(r, c);
        
        angle = atan(dy/dx);
        
        a = angle + pi/2;    
        a = round(a/(pi/4));
        
        comp1 = 0;
        comp2 = 0;
        
        if (a == 0) %0
            comp1 = padres(row, col-1);
            comp2 = padres(row, col+1);
            
        elseif(a == 1) % 45
            comp1 = padres(row-1, col+1);
            comp2 = padres(row+1, col-1);
            
        elseif(a == 2) % 90
            comp1 = padres(row-1, col);
            comp2 = padres(row+1, col);
            
        else %135
            comp1 = padres(row-1, col-1);
            comp2 = padres(row+1, col+1);           
        end
        
        if (current < comp1 || current < comp2)
            res(r, c) = 0;
        end
        
    end
end
            

Im = res;
Im = Im/max(Im(:));

end
    
                
        
        
