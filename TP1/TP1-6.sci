// TP1 - Partie 6


// Question 28  : Fonction de Heaviside

function h = heaviside(x)
    h = (x > 0) + 0
endfunction


X = linspace(-10, 10, 10)
h = heaviside(X)
disp(X)
disp(h)


scatter(X, h, "x")
gca().data_bounds(3:4) = [-1 2]
gca().tight_limits = "on"
title("Fonction de Heaviside entre -10 et 10")

// Question 29 : Exponentielle

scf()

X = linspace(-2, 2, 100)

function values = f(x)
    values = zeros(size(x))
    moins_un_zero = (x >= -1 & x < 0)
    zero_et_un = (x >= 0 & x < 1)
    en_dehors = (x < -1 | x > 1)
    values(moins_un_zero) = exp(x(moins_un_zero)) - exp(-1)
    values(zero_et_un) = exp(x(zero_et_un) .* (-1)) - exp(-1)
    values(en_dehors) = 0
endfunction

plot(X, f(X))
title("Représentation graphique de la fonction f(x)")
gca().data_bounds(1:2) = [-2 2] // Restreindre au support de la fonction
gca().tight_limits = "on"

