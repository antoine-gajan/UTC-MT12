// TP5 : Traitement d'images
// Auteur : Antoine GAJAN
// Date : 23/05/2024

fig = scf()
U=double(imread("C:\Users\antoi\Desktop\UTC\GI04\MT12\TPs\TP5\Images\mandrill.bmp"))
[nRows, nCols] = size(U)
imshow(mat2gray(U))

// Partie 1 : Travailler avec des images sous Scilab

// Question 1 : Carrés noirs
// En haut à gauche
U(1:50, 1:50) = 0
// En haut à droite
U(1:50, nCols-49:nCols) = 0
// En bas à gauche
U(nRows-49:nRows, 1:50) = 0
// En bas à droite
U(nRows-49:nRows, nCols-49:nCols) = 0
fig = scf()
imshow(mat2gray(U))

// Partie 2 : Bruiter une image

U=double(imread("C:\Users\antoi\Desktop\UTC\GI04\MT12\TPs\TP5\Images\mandrill.bmp"))
[nRows, nCols] = size(U)

// Question 2.a)
function Ub = bruitgaus(U, s)
    // Récupération des dimensions de l'image
    [nRows, nCols] = size(U)
    // Création d'une matrice de même dimension que U composée de nombres aléatoires suivant la loi normale
    B = grand(nRows, nCols,'nor',0,s)
    Ub = U + B
endfunction

fig = scf()

subplot(2, 2, 1)
U1 = bruitgaus(U, 1)
imshow(mat2gray(U1))
title("s = 1")
subplot(2, 2, 2)
U10 = bruitgaus(U, 10)
imshow(mat2gray(U10))
title("s = 10")
subplot(2, 2, 3)
U50 = bruitgaus(U, 50)
imshow(mat2gray(U50))
title("s = 50")
subplot(2, 2, 4)
U100 = bruitgaus(U, 100)
imshow(mat2gray(U100))
title("s = 100")

// Question 2.b)

function Uimp = bruitimp(U, p)
    [nRows, nCols] = size(U)
    I = rand(nRows, nCols)
    Uimp = 255*rand(nRows, nCols).*(I<p/100)+(I>=p/100).*U;
endfunction

fig = scf()

subplot(2, 2, 1)
U5 = bruitimp(U, 5)
imshow(mat2gray(U5))
title("p = 5")
subplot(2, 2, 2)
U20 = bruitimp(U, 20)
imshow(mat2gray(U20))
title("p = 20")
subplot(2, 2, 3)
U50 = bruitimp(U, 50)
imshow(mat2gray(U50))
title("p = 50")
subplot(2, 2, 4)
U80 = bruitimp(U, 80)
imshow(mat2gray(U80))
title("p = 80")

// Partie 3 : Filtre moyenne et médian

// Question 3
f=10;
[N,M]=size(U)
Ubig10=zeros(N+2*f,M+2*f)
Ubig10(f+1:N+f,f+1:M+f)=U

f=80;
[N,M]=size(U)
Ubig80=zeros(N+2*f,M+2*f)
Ubig80(f+1:N+f,f+1:M+f)=U

f=160;
[N,M]=size(U)
Ubig160=zeros(N+2*f,M+2*f)
Ubig160(f+1:N+f,f+1:M+f)=U

fig = scf()
subplot(1, 3, 1)
title("f = 10")
imshow(mat2gray(Ubig10))
subplot(1, 3, 2)
title("f = 80")
imshow(mat2gray(Ubig80))
subplot(1, 3, 3)
title("f = 160")
imshow(mat2gray(Ubig160))

// Question 4 : Application avec des filtres

// Question 4.a)
function Umoy = moyenne(U, f)
    // Obtention de f centré
    [N,M]=size(U)
    Ubig=zeros(N+2*f,M+2*f)
    Ubig(f+1:N+f,f+1:M+f)=U
    // Calcul de Umoy
    Umoy = zeros(N, M)
    for i = f+1 : N+f
        for j = f+1 : M+f
            Umoy(i - f, j - f) = mean(Ubig(i-f:i+f, j-f:j+f))
        end
    end
endfunction

function debruitage_gaus(Ub, f_list)
    index = 0
    nb_values = size(f_list, '*')
    fig = scf()
    for f = f_list
        Umoy = moyenne(Ub, f)
        subplot(nb_values, 3, 3 * index + 1)
        title("Image initiale")
        imshow(mat2gray(U))
        subplot(nb_values, 3, 3 * index + 2)
        title("Image bruitée (s=30)")
        imshow(mat2gray(Ub))
        subplot(nb_values, 3, 3 * index + 3)
        title("Filtre moyenne (f = " + string(f) + ")")
        imshow(mat2gray(Umoy))
        index = index + 1
    end
    
endfunction

Ub = bruitgaus(U, 30)
debruitage_gaus(Ub, [1, 10, 20])

// Question 4.b)
function Umed = mediane(U, f)
    // Obtention de f centré
    [N,M]=size(U)
    Ubig=zeros(N+2*f,M+2*f)
    Ubig(f+1:N+f,f+1:M+f)=U
    // Calcul de Umed
    Umed = zeros(N, M)
    for i = f+1 : N+f
        for j = f+1 : M+f
            Umed(i - f, j - f) = median(Ubig(i-f:i+f, j-f:j+f))
        end
    end
endfunction

function debruitage_imp(Uimp, f_list)
    index = 0
    nb_values = size(f_list, '*')
    fig = scf()
    for f = f_list
        Umed = mediane(Uimp, f)
        subplot(nb_values, 3, 3*index + 1)
        title("Image initiale")
        imshow(mat2gray(U))
        subplot(nb_values, 3, 3*index + 2)
        title("Image bruitée (p=30)")
        imshow(mat2gray(Uimp))
        subplot(nb_values, 3, 3*index + 3)
        title("Filtre médiane (f = " + string(f) + ")")
        imshow(mat2gray(Umed))
        index = index + 1
    end
    
endfunction

Uimp = bruitimp(U, 30)
debruitage_imp(Uimp, [1, 5, 10])

// Partie 4 : Détecter les contours d'une image

// Question 5

function norme_grad = norme_gradient(U, i, j)
    norme_grad = sqrt((U(i+1, j) - U(i-1, j))^2 + (U(i, j+1) - U(i, j-1))^2)/2
endfunction

function Ucontour = contour(U)
    // Prolongement de l'image au niveau des bords (f = 1)
    [N,M]=size(U)
    f = 1
    Ubig=zeros(N+2*f,M+2*f)
    Ubig(f+1:N+f,f+1:M+f)=U
    Ucontour = zeros(N, M)
    // Calcul de la norme du gradient discret pour chaque pixel
    for i = 1:N
        for j = 1:M
            Ucontour(i, j) = norme_gradient(Ubig, i+f, j+f)
        end
    end
endfunction

Uboat = double(imread("C:\Users\antoi\Desktop\UTC\GI04\MT12\TPs\TP5\Images\boat.bmp"))

fig = scf()
Umandrillcontour = contour(U)
Uboatcontour = contour(Uboat)
subplot(1, 2, 1)
imshow(mat2gray(Umandrillcontour))
title("Mandrill")
subplot(1, 2, 2)
imshow(mat2gray(Uboatcontour))
title("Bateau")


