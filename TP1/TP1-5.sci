// TP1 - Partie 5

// Question 27 : Comprendre le fonctionnement des masques

X = rand(1, 10)

disp(X(X < median(X))) // Affichage des données en dessous de la médiane

disp(X < median(X)) // Affichage d'un tableau de booléens

disp(X(X > 0.1 & X < 0.6)) // Affichage des valeurs remplissant la condition

disp(X(X < 0.1 | X > 0.6)) // Affichage des valeurs remplissant la condition
