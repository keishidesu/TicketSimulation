function CounterOperation(num,database,c1,c2,c3,c4,sTime)
    
    database; % [ IAT, Arr, Day, Type, Member, No, Paid ]
    
    lastServiceEnds = 0;
    lastServiceEnds2 = 0;
    lastServiceEnds3 = 0;
    Counter1 = []; % for printing summary table here later
    Counter2 = [];
    Counter3 = [];
    Counter4 = [];
    
    %      1          2              3            4                   5            6
    % [ index | arrival time | counter no. | service time | service time ends | waiting time ]
    CustomerCounterDistribute = []; % customer to which counter
    

    for i = 1:num
      CustomerCounterDistribute(i,1) = i; % number of customer
      CustomerCounterDistribute(i,2) = database(i,2); % customer arrival time
      if i == 1 % first customer special case
          if database(i,5) == 1; % is member
              CustomerCounterDistribute(i,3) = 4;
              CustomerCounterDistribute(i,4) = DeterServiceTime(sTime(i),c4);
          else
              CustomerCounterDistribute(i,3) = 1;
              CustomerCounterDistribute(i,4) = DeterServiceTime(sTime(i),c1); 
          end
          CustomerCounterDistribute(i,6) = 0;
      else
          if database(i,5) == 2 % non member
              lastServiceEnds = LastCustomer(CustomerCounterDistribute,1); % check counter one
              if lastServiceEnds > CustomerCounterDistribute(i,2)
                  lastServiceEnds2 = LastCustomer(CustomerCounterDistribute,2); % check counter two
                  if lastServiceEnds2 >= lastServiceEnds
                      %
                      % need to wait (wait at counter 1)
                      CustomerCounterDistribute(i,3) = 1;
                      CustomerCounterDistribute(i,6) = lastServiceEnds - CustomerCounterDistribute(i,2);
                      CustomerCounterDistribute(i,4) = DeterServiceTime(sTime(i),c1);
                      % need to improve code ^^^^
                      %
                  else
                      % directly go counter 2
                      waiting = 0;
                      if lastServiceEnds2 >= CustomerCounterDistribute(i,2)
                          waiting = lastServiceEnds2 - CustomerCounterDistribute(i,2);
                      end
                      CustomerCounterDistribute(i,3) = 2;
                      CustomerCounterDistribute(i,6) = waiting;
                      CustomerCounterDistribute(i,4) = DeterServiceTime(sTime(i),c2);
                  end
              else
                  % directly go counter 1
                  CustomerCounterDistribute(i,3) = 1;
                  CustomerCounterDistribute(i,6) = 0;
                  CustomerCounterDistribute(i,4) = DeterServiceTime(sTime(i),c1);
              end
                      
                      
              % !! havent activate counter 3 !!  
              
          else % members go counter 4
              CustomerCounterDistribute(i,3) = 4;
              lastServiceEnds = LastCustomer(CustomerCounterDistribute,4);
              % service time > arrival time, need to wait
              if lastServiceEnds >= CustomerCounterDistribute(i,2)
                  CustomerCounterDistribute(i,6) = lastServiceEnds - CustomerCounterDistribute(i,2);
              else
                  CustomerCounterDistribute(i,6) = 0;
              end
              CustomerCounterDistribute(i,4) = DeterServiceTime(sTime(i),c4);
          end
          
      end
      % service time ends = arrival time + service time + waiting time
      CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2) + CustomerCounterDistribute(i,4) + CustomerCounterDistribute(i,6);
      
    end
    
    %CustomerCounterDistribute
    
    %PrintMessage(database, CustomerCounterDistribute);
    
    CustomerCounterDistribute;
    
    for i = 1:4
        count = 0;
        printf('\n+--------------------------------------------------------------------+\n');
        printf('|          Counter %d                                                 |\n', i);
        printf('+-----+---------+---------+---------+---------+---------+------------+\n');
        printf('|  n  | RN for  | Service | Time    | Time    | Waiting | Time spent |\n');
        printf('|     | service | time    | service | service | Time    | in the     |\n');
        printf('|     | time    |         | begins  | ends    |         | system     |\n');
        printf('+-----+---------+---------+---------+---------+---------+------------+\n');
        % Time service begins = arrival time + waiting time
        % Time service ends = arrival time + waiting time + service time
        % Time spent in the system = Time service ends - arrival time
        for j = 1:num
            if CustomerCounterDistribute(j,3) == i %customer goes to the counter
                %
                printf('| %3d |   %3d   |   %3d   |   %3d   |   %3d   |    %d    |    %3d     |\n', j, sTime(j), CustomerCounterDistribute(j,4), CustomerCounterDistribute(j,2)+CustomerCounterDistribute(j,6), CustomerCounterDistribute(j,5), CustomerCounterDistribute(j,6), CustomerCounterDistribute(j,5)-CustomerCounterDistribute(j,2));
                printf('+-----+---------+---------+---------+---------+---------+------------+\n');
                count = count + 1;
            end
        end
        if count == 0 
            printf('|  -  |    -    |    -    |    -    |    -    |    -    |      -     |\n');
            printf('+-----+---------+---------+---------+---------+---------+------------+\n');
        end
    end
    
    