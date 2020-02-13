function PrintMessage(database, customer)
	
	% database : 
	% [ IAT | Arr | Day | Type | Member | No | Paid ]
	
    % customerCounterDistribute :
	%      1          2              3            4                 5                 6
    % [ index | arrival time | counter no. | service time | service time ends | waiting time ]
    
    
    for j = 0:customer(size(customer,1),5)
        for i = 1:size(customer, 1)
            if(database(i,4) == 1)
                tickettype = 'Normal';
            else
                tickettype = 'VIP';
            end
            if j == customer(i,2)
                printf('Arrival of Customer %d at minute %d ', customer(i,1), database(i,2));
                printf('and %d tickets of %s ticket on Day %d were purchased.\n\n',database(i,6), tickettype, database(i,3));
                if i > 1
                    printf('Service for %d Customer started at minute %d\n\n', i, customer(i,2) + customer(i,6));
                end
            elseif j == customer(i,5) 
                printf('Departure of Customer %d at minute %d.\n\n', customer(i,1), customer(i,5));
            end
        end
        %Departure time, service time, counteroperation
    end
    
    
    
    