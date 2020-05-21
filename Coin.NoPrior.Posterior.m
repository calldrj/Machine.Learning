%% coin_scenario.m
clear all; close all;  warning('off');
%% Inputs 
alpha = 1; 
beta = 1; 
p = 0.7; 
num_toss = 100;

fprintf('\nInputs:\n'); 
fprintf('---------------------------------------\n'); 
fprintf('number of tosses = %i\n', num_toss); 
fprintf('probability of head = %i\n', p); 
fprintf('alpha = %i\n', alpha);
fprintf('beta = %d\n', beta); 
fprintf('***************************************\n');

%% Compute final gamma and theta
[post_alpha, post_beta] = bayesian_way(p, num_toss, alpha, beta);

%% Compute and print out the probability of winning p_hat
[y_n, r_hat, p_hat] = prob_win(post_alpha, post_beta, alpha, num_toss); 
fprintf('\nCompute the probability of winning\n'); 
fprintf('---------------------------------------\n');
fprintf('theta = %i\n', post_alpha);
fprintf('gamma = %i\n', post_beta);
fprintf('r_hat = %d\n', r_hat);
fprintf('YN = %i\n', y_n);
fprintf('Probability of winning = %d\n', p_hat);        % print the probability of winning
fprintf('***************************************\n');
%% Compute and print out the marginal likelihoods
fprintf('\nCompute the marginal likelihoods\n'); 
fprintf('---------------------------------------\n'); 
fprintf('alpha = %i\n', alpha);
fprintf('beta = %i\n', beta);
fprintf('YN = %i\n', y_n);
fprintf('N = %i\n', num_toss);
m_likelihoods = ml(alpha, beta, y_n, num_toss); 
fprintf('Marginal likelihoods = %d\n', m_likelihoods);  % print the marginal likelihoods
fprintf('***************************************\n\n'); 