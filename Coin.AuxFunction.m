%% Helper functions used in the programs ..Coin.Posterior.m
%% Function to compute then plot posterior, and return the final gamma and theta
    % Get num_toss of tosses, probability of head p, alpha, and beta, depending on scenariors
    % Compute and plot the posteriors for the 1st scenarios for num_toss 10 and 100
    % Compute then return the final gamma
    % Compute then return the final theta
function [post_alpha, post_beta] = bayesian_way(p, num_toss, alpha, beta)
    x = rand(1, num_toss);     % uniformedly-distributed probability p of 100 tosses generated
    toss_data = (x < p);       % set element of toss_data = 1 for 'H' if p < 0.7, otherwise 0 for 'T'
    %% Plot the current and previous posteriors over 100 coin tosses
    post_alpha = alpha;                                    % initialize theta = alpha = 1
    post_beta  = beta;                                     % initialize gamma  = beta  = 1
    ch = {'T','H'};
    toss_string = [];
    r = [0:0.01:1];                                        % generate 100 points of r with step of 0.01 staring at 0
    for i = 1:length(toss_data)
        toss_string = [toss_string ch{toss_data(i) + 1}];  
        figure(1);
        hold off
        if i == 10 || i == 100                             % plot the posterior at toss #10 and #100
        plot(r, betapdf(r, post_alpha, post_beta),'k--');  % previous posterior drawn with a ' - '
        end
        post_alpha = post_alpha + toss_data(i);            % update current theta parameter 
        post_beta  = post_beta + 1 - toss_data(i);         % updata current gamma parameter
        hold on
        if i == 10 || i == 100                             % plot the posterior at toss #10 and #100
        plot(r, betapdf(r, post_alpha, post_beta),'k');    % current posterior drwawn with a '.'
        end
        legend('Previous posterior', 'Current posterior');
        ti = sprintf('Posterior after %g tosses:\n%s', i, toss_string);
        title(ti); xlabel('r'); ylabel('p(r|...)');
        if i == 10                   % pause after toss #10 for 5 seonds to save the the posterior plot
        pause(5)
        end
    end
end
 
%% Function to compute YN, r^, and the probability of winning p_hat
function [y_n, r_hat, p_hat] = prob_win(post_alpha, post_beta, alpha, num_toss)
    y_n = post_alpha - alpha;                             % calculate YN
    r_hat = post_alpha/(post_alpha + post_beta);          % calculate r^
    p_hat = binocdf(y_n, num_toss, r_hat);                % calculate the probability of winning
end
 
%% Function to compute the maginal likelihoods
function m_likelihoods = ml(alpha, beta, y_n, num_toss)
    m_likelihoods = (gamma(alpha + y_n) / gamma(alpha + beta + num_toss)) * (nchoosek(num_toss, y_n) * gamma(alpha + beta) / gamma(alpha) * gamma(beta)) * gamma(beta + num_toss - y_n);
end
