% Convex optimization 2
% HomeWork 1
% Amirreza Hatamipour
%% section a n=200 k=15
clc;clear;
tic
n=200;
K=15;
t=1:n;
f = t.';
intcon = n;
A = zeros(n,1).';
b = 7;
Aeq = ones(n,1).';
beq = K;
lb = zeros(n,1).';
ub = 2*ones(n,1).'; 
x0 = [];
%options = optimoptions('intlinprog','Display','off');
x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,x0)%,options)

toc
%% section a n=2000 k=150
clc;clear;
tic
n=2000;
K=150;
t=1:n;
f = t.';
intcon = n;
A = zeros(n,1).';
b = 7;
Aeq = ones(n,1).';
beq = K;
lb = zeros(n,1).';
ub = 2*ones(n,1).'; 
x0 = [];
%options = optimoptions('intlinprog','Display','off');
x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,x0)%,options);
toc
%% section b n=200 k=15
clc;clear;
tic
n=200;
K=15;
t=1:n;
f = t.';
A = zeros(n,1).';
b = 7;
Aeq = ones(n,1).';
beq = K;
lb = zeros(n,1).';
ub = 2*ones(n,1).'; 
[x,fval]  = linprog(f,A,b,Aeq,beq,lb,ub)

toc
%% section a n=2000 k=150
clc;clear;
tic
n=2000;
K=150;
t=1:n;
f = t.';
A = zeros(n,1).';
b = 7;
Aeq = ones(n,1).';
beq = K;
lb = zeros(n,1).';
ub = 2*ones(n,1).'; 
x0 = [];
[x,fval]  = linprog(f,A,b,Aeq,beq,lb,ub)
toc