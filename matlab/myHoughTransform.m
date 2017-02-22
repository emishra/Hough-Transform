function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
img_r = size(Im, 1);
img_c = size(Im, 2);

Hcols = floor((2*pi)/thetaRes) + 1;

rhoMax = sqrt(img_r*img_r + img_c*img_c);

Hrows = floor(rhoMax/rhoRes) + 1;

H = zeros(Hrows, Hcols);

thetaScale = 0:thetaRes:(2*pi);

rhoScale = 0:rhoRes:rhoMax;

get_p = @(x, y, a) x*cos(a) + y*sin(a);


for y = 1:img_r
    for x = 1:img_c
        if (Im(y, x) > threshold)
           
            for j = 1:Hcols
                theta = thetaScale(j);
                rho = get_p(x, y, theta);
                
                if(rho > 0)
                
                    rho_diff = abs(rhoScale - rho);

                    [~, i] = min(rho_diff);

                    H(i, j) = H(i, j) + 1;
                end
            end
        end
     end   
 end

end
        
        