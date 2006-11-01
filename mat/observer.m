function [fit_limit_reached, max_gen_reached] = observer(max_fit, current_gen)

global fit_limit
global max_gen

if max_fit == fit_limit || max_fit > fit_limit
    fit_limit_reached = 1;
else
    fit_limit_reached = 0;
end

if current_gen == max_gen || current_gen > max_gen
    max_gen_reached = 1;
elseif current_gen < max_gen
    max_gen_reached = 0;
end