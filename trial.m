Ks = Kernelize(source_data,source_data);
Kt = Kernelize(target_data,target_data);

Acap = forbenius_inner_product(Ks,Kt)/sqrt(forbenius_inner_product(Ks,Ks)*forbenius_inner_product(Kt,Kt));

r = cell(1,1);
r = 5;
Wst = cell(1,10);

for i = 1:10
    Kst = alignment_opt(Ks,Kt,Xt);
    Wst{i} = convexnmf(Kst',r);
end

Xt = make_matrix(target_data);

Hst = CNMF(Xt,Wst,r);