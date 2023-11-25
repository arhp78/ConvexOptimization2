clear;close all;clc;
proc_sched_data;
cvx_begin
    variable X(T,n)
    X >= 0;
    s = sum(X')';
    minimize(sum(alpha+beta*s+gamma*square(s)))
    s >= Smin;
    s <= Smax;
    abs(s(2:end)-s(1:end-1))<=R; % slew rate constraint
    % start/stop constraints
    for i=1:n
        for t=1:A(i)-1
            X(t,i)==0;
        end
        for t=D(i)+1:T
            X(t,i)==0;
        end
    end
    sum(X)>= W';
cvx_end
theta = X./(s*ones(1,n));
figure;
bar((s*ones(1,n)).*theta,1,'stacked');
xlabel('t');
ylabel('s_t');