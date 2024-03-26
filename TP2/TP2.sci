// TP2 : Développement sur une base orthogonale

// Exercice 1  : Récursivité

// Question 1

function U = Suite1(n)
    if n < 0 then
        U = null
    elseif n == 0 then
        U = 1
    else
        U = Suite1(n-1) + 1        
    end
endfunction

// Question 2

function U = Fibo(n)
    if n < 0 then
        U = null
    elseif (n == 0 || n == 1) then
        U = 1
    else
        U = Fibo(n-1) + Fibo(n-2)        
    end
endfunction

// Question 3

function f = x_puissance_n(x, n)
    if n < 0 then
        f = null
    elseif n == 0 then
        f = x
    else 
        f = x_puissance_n(x, n-1) .* x
    end
endfunction

// Question 4 : C'est x^n. Affichage dans [-1, 1]

X = linspace(-1, 1, 100)
Y0 = x_puissance_n(X, 0)
Y1 = x_puissance_n(X, 1)
Y2 = x_puissance_n(X, 2)

fig1=scf()
plot(X, Y0, X, Y1, X, Y2)
legend("$f(x) = x$", "$f(x) = x^2$", "$f(x) = x^3$")
title("3 premiers termes de la suite dans l''intervalle [-1, 1]")
xlabel("x")
ylabel("y = f(x)")

// Exercice 2 : Polynômes de Legendre

// Question 5

function y = LegendreP(n, x)
    if n < 0 then
        y = null
    elseif n == 0 then
        y = 1
    elseif n == 1 then
        y = x
    else
        y = (2 .* n - 1) ./ n .* x .* LegendreP(n - 1, x) - (n - 1) ./ n .* LegendreP(n - 2, x)
    end
endfunction

// Question 6 : Inégalité de Bessel

a_0=sqrt(2)*sinh(1),
a_1=-sqrt(6)/exp(1)
a_2=(exp(2)-7)/exp(1)*sqrt(5/2)
a_3=(5*exp(2)-37)/exp(1)*sqrt(7/2)
a_4=3*sqrt(2)*(18*exp(2)-133)/exp(1)
a_5=(329*exp(2)-2431)/exp(1)*sqrt(11/2)
a_6=(3655*exp(2)-27007)/exp(1)*sqrt(13/2)

a = [a_0, a_1, a_2, a_3, a_4, a_5, a_6]

function mod2 = module_carre_f()
    mod2 = integrate("exp(-x) * exp(-x)", "x", -1, 1)
endfunction

s = a_0 + a_1 + a_2 + a_3 + a_4 + a_5 + a_6

disp("Somme des a_k : ", s)
disp("Module carré de f : ", module_carre_f())

// Question 7 : Représentation des polynomes de Legendre et de la fonction f

x = linspace(-1, 1, 400)
fig2 = scf()

y0 = LegendreP(0, x);
y1 = LegendreP(1, x);
y2 = LegendreP(2, x);
y3 = LegendreP(3, x);
y4 = LegendreP(4, x);
y5 = LegendreP(5, x);
y6 = LegendreP(6, x);
plot(x, y0, x, y1, x, y2, x, y3, x, y4, x, y5, x, y6);
legend("n = 0", "n = 1", "n = 2", "n = 3", "n = 4", "n = 5", "n = 6")
title("Les 7 premiers polynômes de Legendre")
xlabel("x")
ylabel("y = f(x)")

function val = prod_scalaire(m, n)
    if m == n then
        val = 2 / (2*n + 1)
    else
        val = 0
    end
endfunction

function val = pi6f(x)
    val = 0
    for k = 0:6
        val = val + a(k + 1) .* LegendreP(k, x) ./ sqrt(prod_scalaire(k, k))
    end
endfunction

fig3 = scf()
y1 = exp(-x)
y2 = pi6f(x)
erreur = y1 - y2

plot(x, y1, x, y2, x, erreur);
title(["Représentation de la fonction" "$f(x) = exp(-x)$" "et du polynôme" "$\pi$$_6f(x)$"]);
xlabel("x")
ylabel("y")
legend("$f(x) = exp(-x)$", "$\pi$$_6f(x)$", "Erreur de projection")

// Question 8 : Faire de même avec g(x) = abs(x)
// Fait sur papier

// Question 9 : Fonction pour calculer ak selon la fonction indiquée en paramètre

function ak = compute_ak(fonction, k)
    fonction_a_integrer = strcat([fonction,  "* LegendreP(k, x) / sqrt(prod_scalaire(k, k))"])
    ak = integrate(fonction_a_integrer, "x", -1, 1)
endfunction

// Question 10 : Vérification
disp("Vérification de la fonction qui calcule les ak : ")
disp(compute_ak("abs(x)", 0))
disp(1 / sqrt(2))
disp(compute_ak("abs(x)", 2))
disp(sqrt(10) / 8)
disp(compute_ak("abs(x)", 4))
disp(- sqrt(2) / 16)

// Question 11 : Affichage des polynômes

function val = fonction_approx(fonction, n, x)
    val = 0
    for k = 0:n
        val = val + compute_ak(fonction, k) .* LegendreP(k, x) ./ sqrt(prod_scalaire(k, k))
    end
endfunction

fig4 = scf()
subplot(2, 1, 1)
y = abs(x)
y2 = fonction_approx("abs(x)", 2, x)
y4 = fonction_approx("abs(x)", 4, x)
y6 = fonction_approx("abs(x)", 6, x)

erreur2 = y - y2
erreur4 = y - y4
erreur6 = y - y6

plot(x, y, "b", x, y2, "g", x, y4, "r", x, y6, "c")
title(["Affichage de la fonction" "$g(x) = |x|$" "et de ses approximations"])
legend("$g(x) = |x|$", "n = 2", "n = 4", "n = 6")

subplot(2, 1, 2)
plot(x, erreur2, "g", x, erreur4, "r", x, erreur6, "c")
title("Affichage des erreurs commises lors des approximations")
legend("n = 2", "n = 4", "n = 6")
