function Output = InitTicketCount()

    tableTicketCount = [];
    for i = 1:2
        tableTicketCount(i,1) = 35;
        tableTicketCount(i,2) = 15;
    end
    tableTicketCount(3,1) = 300;
    tableTicketCount(3,2) = 800;
    
    Output = tableTicketCount;