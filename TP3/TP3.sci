// TP3 : Intégration numérique et convergence des séries de Fourier

// Partie 1

function [Imoins, Iplus, N]= Riemann(f, a, b, epsilon)
    nsubdiv = 20;
    N = 1;
    done = %F;
    while (~done)
        N = 2 * N;
        h = (b-a) / N
        Imoins = 0;
        Iplus = 0;
        for k = 1:N
            Ik = [ a+(k-1)* h, a+k*h]; // (1)
            subdiv = linspace(Ik(1), Ik(2), nsubdiv) ; // Subdivision de l'intervalle
            fmin = min(f(subdiv));
            fmax = max(f(subdiv));
            Imoins = Imoins + h * fmin;
            Iplus = Iplus + h * fmax;
        end
        done = (Iplus - Imoins) < epsilon;
    end; // (while)
endfunction

f = deff('y=f(x)','y=sin(%pi * x)')
[Imoins, Iplus, N] = Riemann(f, 0, 1, 0.0001)
disp("Imoins : ", Imoins) 
disp("Iplus : ", Iplus) 
disp("Valeur exacte : ", integrate("sin(%pi*x)", "x", 0, 1))
disp("N", N)

function I= rectangles_gauche(f, a, b, N)
    h = (b-a) / N
    I = 0;
    for k = 1:N
        Ik = [ a+(k-1)* h, a+k*h];
        val = f(Ik(1));
        I = I + h * val;
    end
endfunction

integ = rectangles_gauche(f, 0, 1, 100)
disp(integ)

// Partie 2

// Fonction f
x1 = linspace(0, 1, 400)
y1 = x1
x2 = linspace(1, 2, 400)
y2 = 2 - x2

fx = cat(2, x1, x2)
fy = cat(2, y1, y2)

plot(fx, fy);
legend("f(x)")
title("Fonction étudiée dans la partie 2")
xlabel("x")
ylabel("y = f(x)")

// Fonction f(2n+1)

function calc = calcul_f2nplus1(x, N)
    calc = 1/2
    for k = 0:N
        temp = 4 / (%pi)**2 * cos((2*k+1)*%pi.*x) / (2*k+1)**2
        calc = calc - temp
    end
endfunction

fig = scf()
x = linspace(0, 2, 400)
y2 = calcul_f2nplus1(x, 2)
y4 = calcul_f2nplus1(x, 4)
y8 = calcul_f2nplus1(x, 8)
y16 = calcul_f2nplus1(x, 16)
y32 = calcul_f2nplus1(x, 32)
y64 = calcul_f2nplus1(x, 64)
y128 = calcul_f2nplus1(x, 128)
y256 = calcul_f2nplus1(x, 256)
plot(fx, fy, x, y2, x, y4, x, y8, x, y16, x, y32, x, y64, x, y128, x, y256);

title("Comparaison de la fonction étudiée avec sa série de Fourier")
xlabel("$x$")
ylabel("$y = f_\(2n+1\)(x)$")
legend("f(x)", "N = 2", "N = 4", "N = 8", "N = 16", "N = 32", "N = 64", "N = 128", "N = 256")


// Partie 3

fig = scf()

// Fonction f

function valeurs_f = partie_3_calcul_f(x)
    valeurs_f = [];
    for i = 1:length(x)
        if x(i) < 0 then
            valeurs_f = [valeurs_f, -1 - x(i)];
        elseif x(i) >= 0 then
            valeurs_f = [valeurs_f, 1 - x(i)];
        end
    end
endfunction

// Fonction fn

function calc = partie_3_calcul_fn(x, N)
    calc = 0
    for k = 1:N
        temp = 2 / (%pi * k) * sin(k * %pi .*x)
        calc = calc + temp
    end
endfunction

x = linspace(-1, 1, 400)
y = partie_3_calcul_f(x)
y2 = partie_3_calcul_fn(x, 2)
y4 = partie_3_calcul_fn(x, 4)
y8 = partie_3_calcul_fn(x, 8)
y16 = partie_3_calcul_fn(x, 16)
y32 = partie_3_calcul_fn(x, 32)
y64 = partie_3_calcul_fn(x, 64)
y128 = partie_3_calcul_fn(x, 128)
y256 = partie_3_calcul_fn(x, 256)
plot(x, y, ".", x, y2, x, y4, x, y8, x, y16, x, y32, x, y64, x, y128, x, y256);
title("Phénomène de Gibbs")
xlabel("$x$")
ylabel("$f(x)$")
legend("f(x)", "N = 2", "N = 4", "N = 8", "N = 16", "N = 32", "N = 64", "N = 128", "N = 256")

disp("La différence entre fn(0) et f(0) est -1 pour tout N >= 1")
disp("Il n''y a donc pas convergence ponctuelle de la série de Fourier de f vers f sur R.")
disp("C''est cohérent avec le théorème de Dirichlet. f est continue par morceaux et dérivable par morceaux. Donc le théorème indique que fn(x) tend vers 1/2 * (f(x+) + f(x-)). En 0, on a fn(x) -> 1/2*(1 - 1) = 0. Comme f(0) = 1, on retrouve bien le résultat du théorème.")

// Question 3

function calc = calcul_difference_f_fn(K, N)
    calc = 0
    for i = 0:K-1
        point = -1 + i*2/K
        temp = abs(partie_3_calcul_f(point) - partie_3_calcul_fn(point, N))
        calc = calc + 2/K * (temp**2)
    end
endfunction

K = 600
for N = [2, 4, 8, 16, 32, 64, 128, 256]
    disp("N = ", N)
    disp(calcul_difference_f_fn(K, N))
end
