% Parameters
num_microphones = 16;
num_snapshots = 320;
num_freq_bins = 3760;

% Generate random data (replace this with your actual data)
%Y = randn(num_microphones, num_snapshots, num_freq_bins) + 1i * randn(num_microphones, num_snapshots, num_freq_bins);

% CRB calculation
CRB_avg = zeros(1, num_microphones);

for mics = 1:num_microphones
    CRB_per_frequency = zeros(1, num_freq_bins);

    for freq = 1:num_freq_bins
        % Extract the data for the current frequency
        %y = squeeze(Y(:, :, freq));

        % Calculate the Fisher Information matrix (for simplicity, assuming a known DOA)
        % You need to adapt this part based on your actual signal model
        J = fisher_information(mics,noise_variance);

        % Calculate the CRB for the current frequency
        CRB_per_frequency(freq) = 1 / trace(inv(J));
    end

    % Average the CRB across frequencies
    CRB_avg(mics) = mean(CRB_per_frequency);
end

% Plot the results
figure;
plot(1:num_microphones, CRB_avg, 'o-');
xlabel('Number of Microphones');
ylabel('Average CRB');
title('Cramer Rao Bound per Frequency Band');

function J = fisher_information(u,noise_variance)
    h = ones(u,1);
    % C: covariance matrix of noise mxm
    C = diag(noise_variance(1:m)); % Generate diagonal matrices

    % BLUE estimator
    A = h.' / C; % h^T*C^-1
    % theta_hat = inv(A * h) * A * x;
    J = 3760* inv(A * h) ;
end
