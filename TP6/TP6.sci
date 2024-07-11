// TP6 : Résolution approchée d’équations différentielles

// Question 1

// y' = -50*y
// y(0) = 10
// => y'/ y = -50 => ln(y) = -50*t + C => y = C * exp(-50*t) 
// Conditions initiales : y(0) = 10 => C = 10
// Solution : y = 10 * exp(-50*t)


// Question 2

function Y = sol(y)
    Y = 10 .* exp(-50.*y)
endfunction

function y=f(x)
    y=-50.*x
endfunction

function Y=EulerExpl(Y0,T,N,f)
    dt=T/N;
    Y=zeros(length(Y0),N + 1)
    Y(:,1)= Y0;
    for i=1:N
        Y(:,i+1)= Y(:, i) + dt * f(Y(:,i));
    end
endfunction

function Y=Heun(Y0,T,N,f)
    dt=T/N;
    Y=zeros(length(Y0),N + 1)
    Y(:,1)= Y0;
    for i=1:N
        temp = f(Y(:,i)) + f(Y(:,i) + dt.*f(Y(:,i)))
        Y(:,i+1)= Y(:, i) + dt / 2 .* temp;
    end
endfunction

function Y=RK4(Y0,T,N,f)
    dt=T/N;
    Y=zeros(length(Y0),N + 1)
    Y(:,1)= Y0;
    for i=1:N
        k1 = f(Y(:,i))
        k2 = f(Y(:,i) + dt / 2 .* k1)
        k3 = f(Y(:,i) + dt/ 2 .* k2)
        k4 = f(Y(:,i) + dt .* k3)
        Y(:, i+1) = Y(:,i) + dt / 6 .* (k1 + 2*k2 + 2*k3 + k4)
    end
endfunction

T = 1
N = 50
Y0 = 10
t = 0:T/N:T

fig = scf()
subplot(3, 1, 1)
plot(t, EulerExpl(Y0, T, N, f),t, sol(t))
legend("Approchée", "Solution")
title("Euler explicite")

subplot(3, 1, 2)
plot(t, Heun(Y0, T, N, f),t, sol(t))
legend("Approchée", "Solution")
title("Heun")

subplot(3, 1, 3)
plot(t, RK4(Y0, T, N, f),t, sol(t))
legend("Approchée", "Solution")
title("RK4")

// Question 4 :
// y1'(t) = -50*y1(t)
// y2'(t) = 3*y2(t)
// y(0) = (10, 2)T

// y1 = 10*exp(-50*t)
// y2 = 2*exp(3*t)

function Y = sol2(y)
    Y = 2 .* exp(3.*y)
endfunction

function y2=f2(x)
    y2=3.*x
endfunction

T = 0.5
N = 50
Y0 = 2
t = 0:T/N:T

fig = scf()
subplot(3, 1, 1)
plot(t, EulerExpl(Y0, T, N, f2),t, sol2(t))
legend("Approchée", "Solution")
title("Euler explicite")

subplot(3, 1, 2)
plot(t, Heun(Y0, T, N, f2),t, sol2(t))
legend("Approchée", "Solution")
title("Heun")

subplot(3, 1, 3)
plot(t, RK4(Y0, T, N, f2), t, sol2(t))
legend("Approchée", "Solution")
title("RK4")

// Question 6

function ans=f3(X)
    ans=[3*X(1) - X(1)*X(2) ; -2*X(2) + X(1)*X(2)]
endfunction

N = 5000
T = 20
X10 = 1
X20 = 2
Y0 = [X10, X20]'

fig = scf()
solution = EulerExpl(Y0, T, N, f3)
comet(solution(1,:), solution(2,:))
title("Evolution de la population proie-prédateurs")
xlabel("Proies")
ylabel("Prédateurs")

// Question 10
// discretisation domaine spatial
L=100; // on considere le carre [-50,50]
M=100;

dx=L/M;// pas d'espace
x=-L/2:dx:L/2-dx;

// discretisation domaine frequentiel

xi= (1/L)*[-M/2:M/2-1]';
xi=fftshift(xi);// utile pour la suite

// discretisation domaine temporel

T=20;
dt=1e-3;// pas de temps

t=0:dt:T;
N=length(t);

function y = fCh(v, xi, a)
    y = -a.*4.*%pi.^2.*xi.^2.*v
endfunction

function res = fChaleur(v)
    res = fCh(v, xi, a)
endfunction

u0=zeros(1,length(x));
u0((L/2-L/10)/dx:(L/2+L/10)/dx)=1;
u0=u0';

// Question 11

a = 1

function sol = back_to_spatial(uhat)
    sol = zeros(M,N)
    for k = 1:length(N)
        sol(:,k)=ifft(uhat(:,k))
    end
endfunction


fig = scf()
uhat = RK4(fft(u0), 0, N, fChaleur)
uhat2 = RK4(fft(u0), 2, N, fChaleur)
uhat3 = RK4(fft(u0), 10, N, fChaleur)
plot(t, back_to_spatial(uhat), t, back_to_spatial(uhat2), t, back_to_spatial(uhat3))
legend("t=0", "t=2", "t=10", "t=20")
title("Résolution de l''équation différentielle")
