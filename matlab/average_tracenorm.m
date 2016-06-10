function val = average_tracenorm( U,n,t )
    

    %
    % Only works for k = 2
    %
    
    %if k ~= 2
    %    fprintf('This function is only designed for k=2\n');
    %end
    %n = k*t;
    
    %
    % Defining the diagonal elements
    %
    
    D = zeros(n,n,n); % contains the n matrices which have a one in the diagonal    
    for i=1:n
        D(i,i,i) = 1;
    end
     
    subsets = nchoosek(1:n,t);
    val = 0;
    i = 0;
    for s=1:nchoosek(n,t)
        i = i+1;
        ss = subsets(s,:);
        
        rho1 = zeros(n,n);
        
        for j=1:t
            rho1 = rho1 + D(:,:,ss(j));
        end
        
        rho1 = 1/t*rho1;
        
        rho2 = U * rho1 * U';
        
        val = val + sum(svd(rho1-rho2));
        
    end
    
    val = val/nchoosek(n,t);
    
end

