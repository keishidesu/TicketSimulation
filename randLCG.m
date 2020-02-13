function Output = randLCG(Seed, m, n)
    result = [];
    for i = 1:n
        if i == 1
            result(i) = Seed(3);
        else
            result(i) = mod((Seed(1) * result(i - 1) + Seed(2)), m);
        end
    end
    
    Output = result;
    
    