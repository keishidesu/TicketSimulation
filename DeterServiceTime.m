function Output = DeterServiceTime(r,c)
    % r: generated random number
    % c: counter matrix
    
    row = size(c,1); % number of rows for the matrix
    
    for i = 1:row
        if( r <= (c(i,3))*100)
            Output = c(i,1);
            break
        end
    end
    