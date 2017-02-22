function [rhos, thetas] = myHoughLines(H, nLines)
rows = size(H, 1);
cols = size(H, 2);

padH = padarray(H, [1,1]);

rhos = zeros(nLines, 1);
thetas = zeros(nLines, 1);

for n = 1:nLines
    [~, lin_i] = max(padH(:));
    [i, j] = ind2sub([rows+2, cols+2], lin_i);
    r = i - 1;
    c = j - 1;
    rhos(n) = r;
    thetas(n) = c;
    padH(i-1:i+1, j-1:j+1) = 0;
end

  
end
        