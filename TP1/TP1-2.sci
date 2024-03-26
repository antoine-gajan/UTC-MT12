clear

// Question 1

X = linspace(-1, 1, 100)

// Question 2

Y = exp(X)

// Question 10

function val = dl_ordre1(x)
    // DL ordre 1 de la fonction exponentielle
    val = 1 + x
endfunction

ordre1 = dl_ordre1(X)

function val = dl_ordre2(x)
    // DL ordre 2 de la fonction exponentielle
    val = 1 + x + x.*x / 2
endfunction

ordre2 = dl_ordre2(X)

// Affichage graphiques
subplot(2, 1, 1)
plot(X, Y, "-r", X, ordre1, ":g", X, ordre2, ":b")
title("Exponentielle et ses développements limités en 0")
xlabel "x"
ylabel "f(x)"
legend(["exp(x)"; "ordre 1"; "ordre 2"])

subplot(2, 1, 2)
plot(X, abs(Y - ordre1), "-g", X, abs(Y - ordre2), "-b")
title("Erreurs d''approximation des développements limités de l''exponentielle")
xlabel "x"
ylabel "f(x)"
legend(["ordre 1"; "ordre 2"])

