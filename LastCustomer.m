function Output = LastCustomer(CounterOp,counter)
    % CounterOp: CustomerCounterDistribute
    % counter: number of counter
    notFound = 0;
    for i = size(CounterOp,1)-1:-1:1     %%% size() - 1 to exclude itself
        if(CounterOp(i,3) == counter)
        	if CounterOp(i,6) > 0
        		notFound = 1;
        		Output = CounterOp(i,6); %%% returns the service ending time of same counter but previous customer
          		break;
        	end
        end
    end

    if notFound == 0
    	Output = 0;
    end
    