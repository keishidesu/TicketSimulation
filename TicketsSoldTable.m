function TicketsSoldTable(num,database,interArrival,ticketDay,ticketType)
    
    % num: numOfPeople
    % database: The customer database from main function
    % interArrival: Series of random numbers for inter-arrival time
    % ticketDay: Series of random numbers for ticket day
    % ticketType: Series of random numbers for ticket type
    
    printf('\n+-------------------------------------------------------------------------------------------------+\n')
    printf('|       Result of simulation                                                                      |\n')
    printf('+-----+----------+---------+----------+---------+---------+---------+--------+-----------+--------+\n')
    printf('|  n  | RN for   | Inter-  | Arrival  | RN for  | Ticket  | RN for  | Ticket | Number of | Total  |\n')
    printf('|     | inter-   | arrival | time     | ticket  | day     | ticket  | type   | ticket    | amount |\n')
    printf('|     | arrival  | time    |          | day     |         | type    |        | purchased | paid   |\n')
    printf('|     | time     |         |          |         |         |         |        |           |        |\n')
    printf('+-----+----------+---------+----------+---------+---------+---------+--------+-----------+--------+\n')
    for i = 1:num
        if (i == 1)
            printf('| %3d |      0   |    %d    |   %4d   |   %3d   |    %d    |   %3d   |    %d   |     %d     |  %4d  |\n',i,database(i,1),database(i,2),ticketDay(i),database(i,3),ticketType(i),database(i,4),database(i,6),database(i,7))
        else
            printf('| %3d |   %4d   |    %d    |   %4d   |   %3d   |    %d    |   %3d   |    %d   |     %d     |  %4d  |\n',i,interArrival(i-1),database(i,1),database(i,2),ticketDay(i),database(i,3),ticketType(i),database(i,4),database(i,6),database(i,7))
        end
        printf('+-----+----------+---------+----------+---------+---------+---------+--------+-----------+--------+\n')
    end