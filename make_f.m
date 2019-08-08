function f = make_f(k,Ks)
    for i = 1:5
        f(i) = forbenius_inner_product(k{i},Ks);
    end
end