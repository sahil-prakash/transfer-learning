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
parameters.iteration = 800;

%set the margin parameter
parameters.margin = 1;

%set the subspace dimensionality
parameters.R = 20;

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
for i=6:12
    y(i,1) = -1;
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