function RemainingTicketTable(TicketCount)
    % TicketCount : matrix for remaining ticket

    printf('\n+--------------------------------------------------------+\n')
    printf('|                Remaining  Ticket  Table                |\n')
    printf('+-------------+------------------------------------------+\n')
    printf('|             |       Number of Remaining Ticket(s)      |\n')
    printf('|             |------------------------------------------|\n')
    printf('|     Day     |    Normal Ticket    |     VIP Ticket     |\n')
    printf('+-------------+---------------------+--------------------+\n')
    for i = 1:2
        printf('|      %d      |          %2d         |         %2d         |\n',i,TicketCount(i,1), TicketCount(i,2))
        printf('+-------------+---------------------+--------------------+\n')
    end
    