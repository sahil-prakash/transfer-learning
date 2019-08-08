function x = forbenius_inner_product(A,B)
    x = 0;
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            x = x + A(i,j)*B(i,j);
        end
    end
end