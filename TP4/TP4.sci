// TP4 : Transformée de Fourier Discrète (TFD)
// Auteur : Antoine GAJAN
// Date : 22/04/2024

// Fonction auxiliaire pour avoir des indices qui commencent à 0
function j=I(i)
    j = i+1;
endfunction


// Partie 1 : Implémentation de la matrice de transformée de Fourier discrète (TFD)
function y=TFD1(N)
    omegaN = exp(2*%i*%pi/N);
    OMEGAN = zeros(N,N);
    for n=0:N-1
        for k=0:N-1
            OMEGAN(I(n),I(k)) = omegaN^(n*k);
        end;
    end;
    y=conj(OMEGAN)/N;
endfunction

function y=TFD2(N)
    liste_nb = 0:N-1
    w = sqrt(2 * %pi / N) .* liste_nb .* exp(%i * %pi / 4)
    OMEGAN = exp(w.' * w);
    y=conj(OMEGAN)/N;
endfunction

// Comparaison des temps d'execution
/*
N = [100, 200, 300, 400]
for n = N
    tic()
    TFD1(n)
    t1 = toc()
    tic()
    TFD2(n)
    t2 = toc()
    disp("N = ", n)
    disp("TFD1 : ", t1)
    disp("TFD2 : ", t2)
end*/

// Test pour N = 50000
/*tic()
TFD2(50000)
t = toc()
disp("Temps de TFD2 pour N = 50000 : ", t)*/

// Partie 2 : FFT et débruitage d'un signal

T = 1
N = 1000
f0 = 50
f1 = 120
t=linspace(0,T,N)

f = sin(2 * %pi * f0 * t) + sin(2 * %pi * f1 * t)

// Représentation graphique du signal de f
fig = scf()
plot(t, f);
legend("$f(t) = sin(2 * \pi * f_0 * t) + sin(2 * \pi * f_1 * t)$")
title("Représentation graphique du signal f pour N = 1000")
xlabel("Temps (s)")
ylabel("Signal")
ax=gca()
ax.data_bounds=[0, -5;1, 5];
ax.tight_limits=["on","on"];


// Question 7 : Calcul avec la fonction fft

fhat = fft(f)

// Question 7.b)
frequence=(0:N);//abscisse des frequences
L=1:floor(N/2);//on conserve seulement la moitie des frequences

fig = scf()
subplot(1, 2, 1)
plot(frequence(L),abs(fhat(L))) //abs permet de calculer le module d'un nombre complexe
title("Spectre d''amplitude de f")
xlabel("Fréquence")
ylabel("Amplitude")

subplot(1, 2, 2)
plot(frequence(L),abs(fhat(L)).^2) //abs permet de calculer le module d'un nombre complexe
title("Spectre de puissance de f")
xlabel("Fréquence")
ylabel("Puissance")

// Signal bruité

funclean = f + 2.5 * rand(t, "normal")
funcleanhat = fft(funclean)

fig = scf()
plot(t, funclean)
title("Représentation graphique du signal f bruité")
xlabel("Temps (s)")
ylabel("Signal")

fig = scf()
subplot(2, 1, 1)
plot(frequence(L),abs(fhat(L)))
title("Représentation graphique du spectre d''amplitude de f")
xlabel("Fréquence")
ylabel("Amplitude")

subplot(2, 1, 2)
plot(frequence(L),abs(funcleanhat(L)))
title("Représentation graphique du spectre d''amplitude de f bruité")
xlabel("Fréquence")
ylabel("Amplitude")

// On peut proposer r = 200

// Question 11 : Calcul de fcleanhat
r = 200
H = abs(funcleanhat) >= r
fcleanhat = funcleanhat .* H
fclean = ifft(fcleanhat)

fig = scf()
subplot(3, 1, 1)
plot(t,f)
title("Représentation graphique du signal f")
xlabel("Temps (s)")
ylabel("Signal")

subplot(3, 1, 2)
plot(t, funclean)
title("Représentation graphique du signal f bruité")
xlabel("Temps (s)")
ylabel("Signal")

subplot(3, 1, 3)
plot(t, fclean)
title("Représentation graphique du signal f débruité")
xlabel("Temps (s)")
ylabel("Signal")


