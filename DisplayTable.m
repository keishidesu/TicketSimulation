function Output = DisplayTable(m, title, first, rangeSize) 

    fprintf('\n+--------------------------------------------------------+\n')
    if(size(title) <25)            
        fprintf('| %37s %18s\n' , title , '|' )
    else
        fprintf('| %45s %10s\n' , title , '|' )
    end

    fprintf('+--------------------------------------------------------+\n')
    fprintf('| %13s %40s\n', first , '| Probability |     CDF    |    Range    |')
    printf('+---------------+-------------+------------+-------------+\n')
   
    A = size(m,1);
    CDF = 0;
    upperBoundary = 0;
    lowerBoundary = 0;
    
    for i = 1:A
        CDF = CDF + m(i,2);
        lowerBoundary = CDF * rangeSize;
        printf('|      %2d       |   %f  |  %f  | %4d - %4d |\n', m(i,1),m(i,2), CDF, upperBoundary, lowerBoundary)
        upperBoundary = lowerBoundary + 1;
        m(i,3) = CDF;
    end
    printf('+--------------------------------------------------------+\n')

    Output = m;