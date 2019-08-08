function k = Kernelize(A,B)
    for i = 1:size(A,2)
        for j = 1:size(B,2)
            k(i,j) = A{i} * B{j}';
        end
    end
    k = k ./ max(max(k));
end