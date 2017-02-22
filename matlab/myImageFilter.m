function [img1] = myImageFilter(img0, h)

rows = size(img0, 1);
cols = size(img0, 2);

rowsh = size(h, 1);
colsh = size(h, 2);

%initialize result
res = zeros(rows, cols);

hoffset = floor(colsh/2);

voffset = floor(rowsh/2);

%pad array
padimg = padarray(img0, [voffset, hoffset], 'replicate');

%mirror filter for convolution
h = rot90(h, 2);

row_begin = 1+voffset;
col_begin = 1+hoffset;

for row = row_begin:(rows+voffset)
    for col  = col_begin:(cols+hoffset)
        
       r = row - voffset;
       c = col - hoffset;
        
       patch = padimg(row-voffset:row+voffset, col-hoffset:col+hoffset);
       new_patch = h .* patch;
       
       %sum everything in patch
       %put patch sum in current row and col
       
       patch_sum = sum(sum(new_patch));
       
       res(r, c) = patch_sum;      
    end
end

img1 = res;

end
