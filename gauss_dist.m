function [ y ] = gauss_dist(x,mu,var)
% GAUSS_DIST function for gaussian distribution
    y=(1/(sqrt(2*pi*var)))*exp((-(x-mu).^2)/(2*var));
end