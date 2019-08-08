source_data = {};
for i=1:10
    strin = sprintf('back_pack (%d).mat',i);
    %disp(string);
    load(strin);
    source_data{i} = histogram;
end


for i=1:10
    strin = sprintf('bike (%d).mat',i);
    %disp(string);
    load(strin);
    source_data{i+10} = histogram;
end


for i=1:10
    strin = sprintf('bookcase (%d).mat',i);
    %disp(string);
    load(strin);
    source_data{i+20} = histogram;
end


for i=1:10
    strin = sprintf('bottle (%d).mat',i);
    %disp(string);
    load(strin);
    source_data{i+30} = histogram;
end


for i=1:10
    strin = sprintf('helmet (%d).mat',i);
    %disp(string);
    load(strin);
    source_data{i+40} = histogram;
end




target_data = {};
for i=1:10
    strin = sprintf('back_pack_target (%d).mat',i);
    %disp(string);
    load(strin);
    target_data{i} = histogram;
end


for i=1:10
    strin = sprintf('bike_target (%d).mat',i);
    %disp(string);
    load(strin);
    target_data{i+10} = histogram;
end


for i=1:10
    strin = sprintf('bookcase_target (%d).mat',i);
    %disp(string);
    load(strin);
    target_data{i+20} = histogram;
end


for i=1:10
    strin = sprintf('bottle_target (%d).mat',i);
    %disp(string);
    load(strin);
    target_data{i+30} = histogram;
end


for i=1:10
    strin = sprintf('helmet_target (%d).mat',i);
    %disp(string);
    load(strin);
    target_data{i+40} = histogram;
end




