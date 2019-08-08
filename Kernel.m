function k = Kernel(A)
    for i = 1:size(A,2)
        for j = 1:size(A,2)
            k(i,j) = A{i} * A{j}';
        end
    end     
    k = k ./ max(max(k));
end