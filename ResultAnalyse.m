function ResultAnalyse(CounterOp,Database,TicketCount)
    
    % CUSTOMER 
    % average interarrival time
    % average arrival time
    
    % COUNTER PERFORMANCE
    % average service time (each counter)
    % sales made (each counter)
    % percentage of counter X to be busy
    
    % OVERALL PERFORMANCE
    % average waiting time of customer (overall)
    % probability of a customer need to wait
    % average time spent in system (overall)
    % percentage of sale for each ticket type (x4)
    
    
    % [ IAT | Arr | Day | Type | Member | No | Paid ]
    
    %     1           2              3            4                 5                  6
    % [ index | arrival time | counter no. | service time | service time ends | waiting time ]
    
    numOfCustomer = size(Database,1);
    simEndTime = CounterOp(numOfCustomer,5);
    
    
    totalInterarrivalTime = 0;
    totalArrivalTime = 0;
    totalWaitingTime = 0;
    totalWaitings = 0;
    totalTimeSpent = 0;
    for i = 1:numOfCustomer
        totalInterarrivalTime = totalInterarrivalTime + Database(i,1);
        totalArrivalTime = totalArrivalTime + Database(i,2);
        totalTimeSpent = totalTimeSpent + (CounterOp(i,5)-CounterOp(i,2));
        if CounterOp(i,6) > 0 %The customer waits
            totalWaitingTime = totalWaitingTime + CounterOp(i,6);
            totalWaitings = totalWaitings + 1;
        end
    end
    printf('\n FLOW OF CUSTOMER\n');
    printf('The average customer interarrival time is %5f \n',totalInterarrivalTime/numOfCustomer);
    printf('The average customer arrival time is %5f \n',totalArrivalTime/numOfCustomer);
   
    
    printf('\n INDIVIDUAL COUNTER PERFORMANCE\n');
    for i = 1:4
        num = 0;
        totalServiceTime = 0;
        totalSales = 0;
        printf(' > Counter %d\n',i);
        for j = 1:numOfCustomer
            if CounterOp(j,3) == i
                num = num + 1;
                totalServiceTime =  totalServiceTime + CounterOp(j,4);
                totalSales = totalSales + Database(j,7);
            end
        end
        if(num == 0)
            printf('There is no customer visiting this counter\n');
        else
            printf('Average service time is %5f \n',totalServiceTime/num);
            printf('Total sales made is RM%2f \n',totalSales);
            printf('Percentage of counter is busy is %5f \n',totalServiceTime/simEndTime);
        end
    end
    
    
    printf('\n OVERALL PERFORMANCE\n');
    printf('Average waiting time in queue is %5f \n',totalWaitingTime/numOfCustomer);
    printf('Probability that a customer has to wait is %5f \n',totalWaitings/numOfCustomer);
    printf('Average time spent in system is %5f \n',totalTimeSpent/numOfCustomer);
    for i = 1:2
        printf('Percentage of sale for day %d normal ticket is %5f \n',i,(1-TicketCount(i,1)/35)*100);
        printf('Percentage of sale for day %d VIP ticket is %5f \n',i,(1-TicketCount(i,2)/15)*100);
    end

        
            
        
        
    