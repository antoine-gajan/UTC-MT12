// TP1 - Partie 4

// Question 21 : Nombres sous la médiane
function elts = sous_mediane(tableau)
    tab_trie = gsort(tableau, "g", "i")
    taille = size(tableau, 2)
    elts = tab_trie(1:round(taille / 2)) 
endfunction

tab = [3 1 5 6 7 2 4 8]
disp(sous_mediane(tab))


// Question 22 : Dérivée de la fonction
function d = deriv(X, Y)
    d = zeros(size(Y, 2) - 1)
    for i = 1 : size(Y, 2) - 1
        d(i) = (Y(i + 1) - Y(i)) / (X(i + 1) - X(i))
    end
endfunction

// Question 23

X = linspace(-10, 10, 4000)
Y = X.^4
deriv_1 = deriv(X, Y)
deriv_2 = deriv(X(1:3999), deriv_1)
deriv_3 = deriv(X(1:3998), deriv_2)
deriv_4 = deriv(X(1:3997), deriv_3)

plot(X, Y, X(1:3999), deriv_1, X(1:3998), deriv_2, X(1:3997), deriv_3, X(1:3996), deriv_4)
legend(["x^4"; "Dérivée 1"; "Dérivée 2"; "Dérivée 3"; "Dérivée 4"])
title("X^4 et ses 4 premières dérivées")

// Question 24 : Temps écoulé (on prend un nombre de données plus important pour voir la différence de temps)
X = linspace(-1000, 1000, 400000)
Y = X.^4

timer();
deriv1 = deriv(X, Y)
time_elapsed1 = timer()
disp("Temps écoulé (boucle for) : ")
disp(time_elapsed1)

// Question 25 : Même chose sans boucle for
function d = deriv_2(X, Y)
    X = diff(X)
    Y = diff(Y)
    d = Y ./ X
endfunction

timer();
deriv2 = deriv_2(X, Y)
time_elapsed2 = timer()
disp("Temps écoulé (sans boucle for) : ")
disp(time_elapsed2)
