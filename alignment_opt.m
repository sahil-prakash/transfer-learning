function x = alignment_opt(Ks, Kt, Xt)
    k = cell(1,5);
    for i = 1:5
        k{i} = Kernelize_Gauss(Xt,rand()*5);
    end
    for i=1:5
        for j = 1:5
            K(i,j) = forbenius_inner_product(k{i},k{j});
        end
    end
    f = make_f(k,Ks);
    alpha = quadprog(2*K+eye(5),-f);
    x = 0;
    for i = 1:5
        x = x + alpha(i)*k{i};
    end
end