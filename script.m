%train_data will contain Training data out of which first 92 are backpacks,
% next 36 are bottles and next 82 are bookcase, 81 file cabinet

%webcam_data will contain Training data out of which first 5 are backpacks,
% next 3 are bottles and next 2 are bookcase, 2 file cabinets
%
train_data = {};
for i=1:92
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    train_data{i} = histogram;
end

for i=1:36
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    train_data{i+92} = histogram;
end

for i=1:82
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    train_data{i+92+36} = histogram;
end

for i=1:81
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    train_data{i+92+36+82} = histogram;
end


for i=1:10
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    train_data{i+92+36+10+10} = histogram;
end

webcam_data = {};
for i=1:5   %backpack
    x = randi(29)+1
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',x);
    %disp(string);
    load(strin);
    webcam_data{i} = histogram;
end

for i=1:3 %bottle
    x = randi(16)+1;
    x
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',x);
    %disp(string);
    load(strin);
    webcam_data{i+5} = histogram;
end

for i=1:2 %bookcase
    
    x = i;
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',x);
    %disp(string);
    load(strin);
    webcam_data{i+5+3} = histogram;
end

for i=1:2 %filecabinet
    x = i;
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',x);
    %disp(string);
    load(strin);
    webcam_data{i+5+3+2} = histogram;
end


% Gathering testing data
% first 29 are backpacks, next 16 are bottles, 5 headphones
webcam_test = {};
for i=1:29
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    webcam_test{i} = histogram;
end

for i=1:16 
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    webcam_test{i+29} = histogram;
end

for i=1:5
    strin = sprintf('histogram_00%02d.SURF_SURF.amazon_800.SURF_SURF.mat',i);
    %disp(string);
    load(strin);
    webcam_test{i+29+16} = histogram;
end




%KBTL Model starts now.


%initalize the parameters of the algorithm
parameters = struct();

%set the hyperparameters of gamma prior used for projection matrices
parameters.alpha_lambda = 1;
parameters.beta_lambda = 1;

%set the hyperparameters of gamma prior used for bias
parameters.alpha_gamma = 1;
parameters.beta_gamma = 1;

%set the hyperparameters of gamma prior used for weights
parameters.alpha_eta = 1;
parameters.beta_eta = 1;

%%% IMPORTANT %%%
%For gamma priors, you can experiment with three different (alpha, beta) values
%(1, 1) => default priors
%(1e-10, 1e+10) => good for obtaining sparsity
%(1e-10, 1e-10) => good for small sample size problems

%set the number of iterations
parameters.iteration = 200;

%set the margin parameter
parameters.margin = 1;

%set the subspace dimensionality
parameters.R = 50;

%set the seed for random number generator used to initalize random variables
parameters.seed = 1606;

%set the standard deviation of hidden representations
parameters.sigma_h = 0.1;

%set the number of tasks
T = 2;

%initialize the kernel and class labels of each task for training
Ktrain = cell(1, T);
ytrain = cell(1, T);


Ktrain{1} = Kernel(train_data); %should be an Ntra x Ntra matrix containing similarity values between training samples of task t
Ktrain{2} = Kernel(webcam_data);

%ytrain should be an Ntra x 1 matrix containing class labels of task t (contains only -1s and +1s)

%Generate ytrain matrix, for amazon.
y = [];
for i=1:92
    y(i,1) = 1;
end
for i=93:291
    y(i,1) = -1;
end
ytrain{1} = y;
%Generate ytrain matrix, for webcam.
y = [];
for i=1:5
    y(i,1) = 1;
end
ytrain{2} = y;

%perform training
state = kbtl_supervised_classification_variational_train(Ktrain, ytrain, parameters);

%initialize the kernel of each task for testing
Ktest = cell(1, T);
%Ktest{t} should be an Ntra x Ntest matrix containing similarity values between training and test samples of task t
%Ktest{1} = Kernelize(amazon,amazon_test);
Ktest{2} = Kernelize(webcam_data,webcam_test);

%perform prediction
prediction = kbtl_supervised_classification_variational_test(Ktest, state);

%display the predicted probabilities for each task
%for t = 1:T
    display(prediction.p{2});
%end

correct_webcam = 0;
for i=1:29
    if prediction.p{2}(i) >= 0.7
        correct_webcam = correct_webcam + 1;
    end
end
for i=30:50
    if prediction.p{2}(i) <= 0.3
        correct_webcam = correct_webcam + 1;
    end
end
%accuracy_amazon = correct_amazon / 108;
accuracy_webcam = correct_webcam / 50