function Output = InitTicket()
   
    tableTicket =  [];
    for i = 1:2
        tableTicket(i,1) = i; % Day of the ticket
        tableTicket(i,2) = 35; 
        tableTicket(i,3) = 15;
        tableTicket(i,4) = tableTicket(i,2) + tableTicket(i,3); 
    end
    
    printf('\n+------------------------------------------+\n')
    printf('|              Ticket Information          |\n')
    printf('+---------+----------+----------+----------+\n')
    printf('|   Day   |  Normal  |    VIP   |   Total  |\n')
    printf('+---------+----------+----------+----------+\n')
    printf('|   %2d    |    %2d    |    %2d    |    %2d    |\n', tableTicket(1,1),tableTicket(1,2), tableTicket(1,3), tableTicket(1,4))
    printf('|   %2d    |    %2d    |    %2d    |    %2d    |\n', tableTicket(2,1),tableTicket(2,2), tableTicket(2,3), tableTicket(2,4))
    printf('+------------------------------------------+\n')
    
    Output = tableTicket;