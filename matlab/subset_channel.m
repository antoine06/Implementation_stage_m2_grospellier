%
% This is about studying the subset channel
% The input to the channel is some x in [n] with n = k*t
% And the output is a randomly chosen subset y of [n] of size t
%   that contains x (there are \binom{n-1}{t-1} of these).
%

%
% Assume we want to send k different messages through this channel
%

%
% Take k = 2 
k = 2;

n = 4;
t = 2;
% We consider and we consider a special class of encodings with a maximally
% etangled state in dimension n
% The measurement of Alice is given by a basis of C^n
%
E = zeros(k, n, n);

% This is just the standard basis
for i=1:n
    E(1,i,i) = 1;
end


%
% Another code for doing the same thing now with this average_tracenorm
% function
%
ntest2 = 1;
max_val2 = 0;
bestU2 = zeros(n,n);
for l=1:ntest2
    %U = 1/sqrt(5)*[
    % 0     1     1     1     1    -1;
    % 1     0    -1     1    -1    -1;
    % 1    -1     0     1     1     1;
    % 1     1     1     0    -1     1;
    % 1    -1     1    -1     0    -1;
    %-1    -1     1     1    -1     0];
    U = orth(randn(n,n));
    v = average_tracenorm(U,n,t);
    v = 1/2+1/4*v;
    if v > max_val2
        max_val2 = v;
        bestU2 = U;
    end
    %fprintf('succ prob is = %d\n', v);
end
fprintf('max success prob 2 is = %d\n', max_val2);
%
% Now optimizing starting from U
%

ntestopt = 10;

min_fval = 1;
Uoptbest = zeros(n,n);
for l=1:ntestopt
%U0 = bestU2;
U0 = orth(randn(n,n));
options = optimset('fmincon');
options.MaxFunEvals = 300000;
options.MaxIter = 300000;
[Uopt, fval] = fmincon(@(U)(-average_tracenorm(U,n,t)), U0, [],[],[],[],[],[],@unitary_constraints,options)
if fval < min_fval
    min_fval = fval;
    Uoptbest = Uopt;
end
end

%average_tracenorm22(Uoptbest);

fprintf('after optimization = %d\n', 1/2+1/4*(-min_fval));

Uoptbest

%Ucand = 1/sqrt(5)*[0 1 1 1 1; -1 0 -1 -1 1; 1 1 0 1 1; 1 1 1 0 1; 1 1 1 1 0];
