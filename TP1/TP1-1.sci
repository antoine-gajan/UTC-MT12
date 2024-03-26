clear

// Question 5

//// Demande des valeurs de a et b
//a = input("Premier nombre : ")
//b = input("Deuxième nombre : ")
//// Calculs
//if a < b then
//    disp("Le minimum est : ", a)
//else 
//    if b > a
//        disp("Le minimum est : ", b)
//    else
//        disp("Les deux nombres sont égaux !")
//    end
//end

// Question 6

function mini = my_min(a, b)
    if a < b then
        mini = a
    else 
        mini = b
end
endfunction

// Question 7

function [is_min, mini] = my_min(a, b)
if a < b then
    mini = a
    is_min = %T
else 
    mini = b
    is_min = %F
end
endfunction
