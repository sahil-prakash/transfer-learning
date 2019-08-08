function x = make_matrix(data)
    x = zeros(size(data,2),size(data{1},2));
    for i = 1:size(data,2)
        for j = 1:size(data{i},2)
            x(i,j) = data{i}(j);
        end
    end
end