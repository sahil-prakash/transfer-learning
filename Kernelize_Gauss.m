function x = Kernelize_Gauss(Xt,sigma)
    for i = 1:size(Xt,1)
        for j = 1:size(Xt,1)
            v = Xt(i) - Xt(j);
            x(i,j) = exp(-(norm(v)*norm(v))/(2*sigma*sigma));
        end
    end
end