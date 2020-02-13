function Output = LastCustomer(CounterOp,counter)
    % CounterOp: CustomerCounterDistribute
    % counter: number of counter
    for i = (size(CounterOp,1)-1):-1:1
        if(CounterOp(i,3) == counter)
            Output = CounterOp(i,5); % returns the service time
            break
        end
    end
    