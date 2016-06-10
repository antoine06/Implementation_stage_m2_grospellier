function [ c, ceq ] = unitary_constraints( x )
%
% The matrix x is checked to be unitary or not
%
    n = size(x,1);
    % x should be an n x n matrix
    
    ceq = zeros(n*n);
    
    for i=1:n
        for j=1:n
            if i == j
                ceq(i+j*(n-1)) = dot(x(i,:),x(j,:)) - 1;
            else
                ceq(i+j*(n-1)) = dot(x(i,:),x(j,:));
            end
        end
    end
    
    c = [];
    
end

