function CounterOperation(totalNumOfCus, database ,c1,c2,c3,c4, ranSTime, ranBreakTime)


    database                  %%% [ IAT, Arr, Day, Type, Member, No, Paid ]

    ranBreakTime              %%% [ TimeSpent , AfterWhichCustomer]
    
    lastServiceEnds_C1 = 0;   %%% Times that the previous customer ends their service 
    lastServiceEnds_C2 = 0;
    lastServiceEnds_C3 = 0;
    On_Off_Condition = 4;     %%% Condition for on off counter 3
 
    %%%      1          2                   3             4                 5                     6                  7                    8
    %%% [ index | ori arrival time  | counter no. | service time | services start time | services end time | total time in queue | RanServiceTime]
    %%% [ index | negative value -1 | counter no. | break time   | break time start    | break time end    | 0 zero              | 0 zero   ]
          
    CustomerCounterDistribute = []; %%% distribute customer to which counter
   


    numOfBreak = 0;
    breakDatabase = [];
    casherBreakChecking = 0;
    for i = 1:size(ranBreakTime,1)
        if ranBreakTime(i,2) <= totalNumOfCus
            numOfBreak = numOfBreak + 1;
            breakDatabase(numOfBreak,1) = ranBreakTime(i,1);
            breakDatabase(numOfBreak,2) = ranBreakTime(i,2);
        end
    end
    totalNumOfCus = totalNumOfCus + numOfBreak;
    breakDatabase;
 


    %%% first customer special case
    CustomerCounterDistribute(1,1) = 1;
    CustomerCounterDistribute(1,2) = database(1,2); 
    if database(1,5) == 1; %%% is member
        CustomerCounterDistribute(1,3) = 4;
        CustomerCounterDistribute(1,4) = DeterServiceTime(ranSTime(1),c4);
    else
        CustomerCounterDistribute(1,3) = 1;
        CustomerCounterDistribute(1,4) = DeterServiceTime(ranSTime(1),c1);
    end
    CustomerCounterDistribute(1,5) = 0;
    CustomerCounterDistribute(1,6) = CustomerCounterDistribute(1,4);
    CustomerCounterDistribute(1,7) = 0;
    CustomerCounterDistribute(1,8) = ranSTime(1);
    

  for i = 2: totalNumOfCus
  gotBreak = 0;

      for j = 1:numOfBreak
          if i == breakDatabase(j,2)
              CustomerCounterDistribute(i,1) = i;
              CustomerCounterDistribute(i,2) = -1;
              CustomerCounterDistribute(i,3) = CustomerCounterDistribute(i-1,3); %%Place at last counter 
              CustomerCounterDistribute(i,4) = breakDatabase(j,1);
              CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i-1,6);
              CustomerCounterDistribute(i,6) = CustomerCounterDistribute(i,4) + CustomerCounterDistribute(i,5);
              CustomerCounterDistribute(i,7) = 0;
              CustomerCounterDistribute(i,8) = 0;
              casherBreakChecking = casherBreakChecking +1 ;
              breakDatabase(j,2) = totalNumOfCus + 100 + j;
              gotBreak = 1;
              break;
          end
      gotBreak = 0;
      end

  if gotBreak == 1
    continue;
  end

      CustomerCounterDistribute(i,1) = i;                                            %%% number of customer
      CustomerCounterDistribute(i,2) = database(i - casherBreakChecking, 2);         %%% customer arrival time

      if database(i - casherBreakChecking ,5) == 2

          lastServiceEnds_C1 = LastCustomer(CustomerCounterDistribute,1); % counter1 previous customer servie end time
          queueTimeC1 = lastServiceEnds_C1 - CustomerCounterDistribute(i,2);
          lastServiceEnds_C2 = LastCustomer(CustomerCounterDistribute,2); % counter2 previous customer service end time
          queueTimeC2 = lastServiceEnds_C2 - CustomerCounterDistribute(i,2);

          if queueTimeC1 < On_Off_Condition

              CustomerCounterDistribute(i,3) = 1; 
              CustomerCounterDistribute(i,4) = DeterServiceTime(ranSTime(i- casherBreakChecking),c1);  
              
              if queueTimeC1 <= 0
                  CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2);
                  CustomerCounterDistribute(i,7) = 0;
              else 
                  CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2) + queueTimeC1;
                  CustomerCounterDistribute(i,7) = queueTimeC1;
              end

          elseif  queueTimeC2 < On_Off_Condition

              CustomerCounterDistribute(i,3) = 2;
              CustomerCounterDistribute(i,4) = DeterServiceTime(ranSTime(i- casherBreakChecking),c2);
            
              if queueTimeC2 <= 0
                  CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2);
                  CustomerCounterDistribute(i,7) = 0;
              else 
                  CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2) + queueTimeC2;
                  CustomerCounterDistribute(i,7) = queueTimeC2;
              end
          else

              lastServiceEnds_C3 = LastCustomer(CustomerCounterDistribute,3);    % counter3 previous customer service end time
              queueTimeC3 = lastServiceEnds_C3 - CustomerCounterDistribute(i,2);
              CustomerCounterDistribute(i,3) = 3;
              CustomerCounterDistribute(i,4) = DeterServiceTime(ranSTime(i- casherBreakChecking),c3);
              
              if queueTimeC3 <= 0
                  CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2);
                  CustomerCounterDistribute(i,7) = 0;
              else 
                  CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2) + queueTimeC3;
                  CustomerCounterDistribute(i,7) = queueTimeC3;
              end
          end
      else 
          CustomerCounterDistribute(i,3) = 4;
          lastServiceEnds_C4 = LastCustomer(CustomerCounterDistribute,4);                             
          % service time > arrival time, need to wait
          if lastServiceEnds_C4 >= CustomerCounterDistribute(i,2)
              CustomerCounterDistribute(i,7) = lastServiceEnds_C4 - CustomerCounterDistribute(i,2);  
          else
              CustomerCounterDistribute(i,7) = 0;
          end
          CustomerCounterDistribute(i,4) = DeterServiceTime(ranSTime(i- casherBreakChecking),c4);
          CustomerCounterDistribute(i,5) = CustomerCounterDistribute(i,2) + CustomerCounterDistribute(i,7);          
      end

      % service time ends = arrival time + service time + waiting time
      CustomerCounterDistribute(i,6) = CustomerCounterDistribute(i,2) + CustomerCounterDistribute(i,4) + CustomerCounterDistribute(i,7);
      CustomerCounterDistribute(i,8) = ranSTime(i- casherBreakChecking)
  end   
    


    %CustomerCounterDistribute
    %PrintMessage(database, CustomerCounterDistribute);
    
    checker = 0;
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
        for j = 1:totalNumOfCus
            if CustomerCounterDistribute(j,3) == i %customer goes to the counter
                if CustomerCounterDistribute(j,2) == -1
                    printf('| %3d |              Counter Take A %1d Minutes Break                  |\n', j, CustomerCounterDistribute(j,4));
                    printf('+-----+---------+---------+---------+---------+---------+------------+\n');
                    checker = checker +1;
                    count = count + 1;
                else
                    printf('| %3d |   %3d   |   %3d   |   %3d   |   %3d   |   %3d   |    %3d     |\n', j, CustomerCounterDistribute(j,8), CustomerCounterDistribute(j,4), CustomerCounterDistribute(j,5), CustomerCounterDistribute(j,6), CustomerCounterDistribute(j,7), CustomerCounterDistribute(j,6)-CustomerCounterDistribute(j,2));
                    printf('+-----+---------+---------+---------+---------+---------+------------+\n');
                    count = count + 1;
                end
            end
        end
        if count == 0 
            printf('|  -  |    -    |    -    |    -    |    -    |    -    |      -     |\n');
            printf('+-----+---------+---------+---------+---------+---------+------------+\n');
        end
    end
    
    