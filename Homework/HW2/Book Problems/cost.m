function [J] = cost(z)
    ideal = 0.8913;
    s = j*z;
    guess = abs(s^3 / (s^3 + 2*s^2 + 2*s + 1));
    
    e = abs(ideal) - abs(guess);
    J = e^2;
end

