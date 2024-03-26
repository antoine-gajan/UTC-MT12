clear

// Question 15 : Apprendre à faire des vecteurs
X = 1:10
disp(X)

X = [1 2 4 6]
disp(X)

X = zeros(2, 3)
disp(X)

X = ones(2, 4)
disp(X)

X = rand(1, 10, "normal")
disp(X)

clear

// Question 16 

function scal = scalaire(a, b)
    scal = a * b'
endfunction

function ort = orthogonal(vect1, vect2)
    if scalaire(vect1, vect2) == 0 then
        ort = %T
    else
        ort = %F
    end
endfunction

X = [0 0 1 1]
Y = [1 1 0 0]
Z = [0 1 0 0]

disp(scalaire(X, Y)) // Renvoie 0
disp(scalaire(Y, Z)) // Renvoie 1
disp(orthogonal(X, Y)) // Renvoie True
disp(orthogonal(Y, Z)) // Renvoie False


// Question 17 : Création de la suite

function s = suite(n)
    N = 1:n
    s = 1 ./ (N.^2)
endfunction

disp(suite(3))

// Question 18 : Calcul de la somme

function ser = serie(n)
    s = suite(n)
    ser = sum(s)
endfunction

// Question 19 : Clacul de la somme avec une boucle for

function s = S_2(n)
    s = zeros(n)
    for i = 1:n
        s(i) = 1 / (i^2)
    end
endfunction

// Question 20 : Calcul du temps

timer();
s1 = suite(10000)
time_elapsed1=timer()

timer();
s2 = S_2(10000)
time_elapsed2 = timer()

disp("Temps 1 (calcul matriciel) : ")
disp(time_elapsed1)
disp("Temps 2 (boucle for) : ")
disp(time_elapsed2)

// La fonction la plus rapide est celle utilisant le calcul matriciel, qui est implémenté de manière optimisée dans Scilab.
