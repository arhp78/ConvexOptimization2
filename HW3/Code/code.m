% HW3
% Amirreza Hatamipour
% 97101507 
%% Question 3
Q=[1 -1/2;-1/2 2];
f=[-1 ;0];
A=[1 2;1 -4;5 76];
u1=-2; u2=-3;
b=[u1 ; u2; 1];
cvx_begin
    variable x(2)
    dual variable landa
    minimize(quad_form(x,Q)+f'*x)
    subject to
        landa: A*x <= b;
cvx_end
p_star = cvx_optval

%KKT 
% primal
A*x <= b
%dual 
landa >= 0
% complementry
landa.*(A*x-b)
%
2*x(1)-x(2)-1+landa(1)+landa(2)+5*landa(3)
4*x(2)-x(1)+2*landa(1)-4*landa(2)+76*landa(3)

%% section b
arr_i = [0 -0.1 0.1];
table = [];
for i = arr_i
    for j = arr_i        
        cvx_begin
            variable x(2)
            minimize(quad_form(x,Q)+f'*x)
            subject to
                A*x <= b+[i;j;0]
        cvx_end
        p_exact = cvx_optval;
        p_pred = p_star - landa'*[i; j;0];
        table = [table; i j p_pred p_exact]
    end
end
disp('      delta1  delta2   p_pred    p_exact'); disp(table); 
%% Question 4
% section a
clc; clear;
cvx_begin
    variables x y
    minimize(exp(-x))
    subject to
        x.^2 <= 0;
        y>0;
cvx_end
%% section b
cvx_begin
    variables x y
    dual variable landa
    minimize(exp(-x))
    subject to
        landa: x.^2 <= 0;
        y>0;
cvx_end
%% Question 5 
clc;clear;close all

p = 6; n = 9; eps = .1;

% Incidence matrix
A = [-1 +1  0  0  0  0  0  0 -1;
     +1  0 -1  0  0  0  0 -1  0;
      0 +1 +1 -1  0  0  0  0  0;
      0  0  0 +1 -1 -1  0  0  0;
      0  0  0  0 +1  0 +1  0 +1;
      0  0  0  0  0 +1 -1 +1  0];

% Source rates
s = [1;0;0;0;-1;0];
t = [0;1;0;0;0;-1];
cvx_begin
    variables x(n) y(n)
    dual variables landa1 landa2
    minimize(sum((x+y).^2)+eps*(sum(x.^2+y.^2)))
    subject to
        landa1: A*x+s==0;
        landa2: A*y+t==0;
         x >= 0;
         y >= 0;
cvx_end
f_min = cvx_optval;
% Dual
landa_1 = zeros(p,1); landa_2 = zeros(p,1);
x = zeros(n,1); y = zeros(n,1);
ite = 200;
L = []; infeasibility1 = []; infeasibility2 = [];
for i = 1:ite
    delta_mu = A'*landa_1; delta_nu = A'*landa_2;
    for j = 1:n
         [x(j),y(j)] = quad2_min(eps,delta_mu(j),delta_nu(j));
    end
    infeasibility1 = [infeasibility1 norm(A*x+s)];
    infeasibility2 = [infeasibility2 norm(A*y+t)];
    l = sum((x+y).^2)+eps*(sum(x.^2+y.^2))+landa_1'*(A*x+s)+landa_2'*(A*y+t);
    L = [L l];
    alpha = .1;
    landa_1 = landa_1+alpha*(A*x+s);
    landa_2 = landa_2+alpha*(A*y+t);
end

figure
plot(1:ite,L,'b',[1 ite],[f_min f_min],'r')
xlabel('iter')
legend('lb','opt')
title('Lower bound')
grid on

figure
semilogy(infeasibility1)
xlabel('iter')
title('||Ax+s||')
grid on

figure
semilogy(infeasibility2)
title('||Ay+t||')
xlabel('iter')
grid on
