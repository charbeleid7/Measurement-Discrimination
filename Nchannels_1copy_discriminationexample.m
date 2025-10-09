function [T,p_succ,status_code] = Nchannels_1copy_discriminationexample(C,d)

d_in  = d(1);
d_out = d(2);
N     = size(C,3);

yalmip('clear');

% declare SDP variables
T = sdpvar(d_in*d_out,d_in*d_out,N,'hermitian','complex');

% save all constraints as a single variable "F"
F = [trace(sum(T,3))==d_out,
    sum(T,3)==kron(PartialTrace(sum(T,3),2,[d_in d_out]),eye(d_out)/d_out)
    ];

p_succ = 0;
for i=1:N
    F = F + [T(:,:,i)>=0];
    p_succ = p_succ + (1/N)*real(trace(T(:,:,i)*C(:,:,i)));
end

% solvesdp(constraints, objective, sdpsettings('solver','solvername',verbose,0/1,'cachesolvers',0/1)
% objective function is always minimized, so to maximize J, the objective function must be -J.

solution = solvesdp(F,-p_succ,sdpsettings('solver','mosek','verbose',0,'cachesolvers',1));

% convert from SDPvar to double
T = double(T); 
p_succ = double(p_succ);

status_code = solution.problem;
status_msg = yalmiperror(status_code);
disp(['Solver status: ' status_msg]);