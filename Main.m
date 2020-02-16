function Main()

    printf('+-------------------------------------------------+\n');
    printf('| This is a concert counter service simulator.    |\n');
    printf('| There are 2 days of concert.                    |\n');  
    printf('| There are 3 counters:                           |\n');
    printf('| Counter 1, 2 and 3 are for non-members.         |\n');
    printf('| Counter 4 are for members.                      |\n');
    printf('+-------------------------------------------------+\n\n');

    while(1)
        numOfPeople = input('Please input the number of people (at least 4): ');
        printf('\n');
        if(numOfPeople > 3)
            break;
        else
            printf('Number of people must > 3');
        end
    end
    
    
    while(1)
        printf('1: LCG\n');
        printf('2: Exponential Distribution\n');
        printf('3: Uniform Distrubution\n');
        Generatortype = input('Please enter the type of random number generator to use: ');

        if(Generatortype >= 1 && Generatortype <= 3)
            break;
        else
            printf('\n');
            printf('Invalid number input, please try again\n');
        end
    end

    numOfBreak = 6; 

    %LCG
    if Generatortype == 1
        RanServiceTime = mod(randLCG(ceil(rand(1,3)*100),143,numOfPeople),99)+1;
        RanInterArrival = mod(randLCG(round(rand(1,3)*1000),1000,numOfPeople - 1),999)+1;
        RanTicketDay = mod(randLCG(ceil(rand(1,3)*100),184,numOfPeople),99)+1;
        RanTicketType = mod(randLCG(round(rand(1,3)*100),165,numOfPeople),99)+1;
        RanMembership = mod(randLCG(round(rand(1,3)*10),13,numOfPeople),9)+1;
        RanNumberOfTicketPurchased = mod(randLCG(round(rand(1,3)*100),199,numOfPeople),99)+1;
        RanCasherBreak = mod(randLCG(round(rand(1,3)*100),123,numOfBreak),99)+1;
        
    %Exponential     
    elseif Generatortype == 2
        RanServiceTime = mod(round(randexp(100*ones(1,numOfPeople))),99)+1;
        RanInterArrival = mod(round(randexp(1000*ones(1,numOfPeople))),999)+1;
        RanTicketDay = mod(round(randexp(100*ones(1,numOfPeople))),99)+1;
        RanTicketType = mod(round(randexp(100*ones(1,numOfPeople))),99)+1;
        RanMembership = mod(round(randexp(100*ones(1,numOfPeople))),9)+1;
        RanNumberOfTicketPurchased = mod(round(100*randexp(ones(1,numOfPeople))),99)+1;

        RanCasherBreak = mod(round(100*randexp(ones(1,numOfBreak))),99)+1;
    
    %Uniform    
    elseif Generatortype == 3
        RanServiceTime = randi(zeros(1,numOfPeople), 100*ones(1,numOfPeople));
        RanInterArrival = randi(zeros(1,numOfPeople), 1000*ones(1,numOfPeople));
        RanTicketDay = randi(zeros(1,numOfPeople), 100*ones(1,numOfPeople));
        RanTicketType = randi(zeros(1,numOfPeople), 100*ones(1,numOfPeople));
        RanMembership = randi(zeros(1,numOfPeople), 10*ones(1,numOfPeople));
        RanNumberOfTicketPurchased = randi(zeros(1,numOfPeople), 100*ones(1,numOfPeople));

        RanCasherBreak = randi(zeros(1,numOfBreak), 100*ones(1,numOfBreak));

    end
    
    printf('\nThe random numbers for inter-arrival time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanInterArrival);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    
    printf('\nThe random numbers for service time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanServiceTime);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    
    printf('\nThe random numbers for membership time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanMembership);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    
    printf('\nThe random numbers for ticket type time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanTicketType);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    
    printf('\nThe random numbers for ticket day time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanTicketDay);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    
    printf('\nThe random numbers for number Of tickets time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanNumberOfTicketPurchased);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    
    printf('\nThe random numbers for casher break time are: \n');
    printf('--------------------------------------------------------------------------------------------------------------------------------------\n');
    printf('%d ',RanCasherBreak);
    printf('\n--------------------------------------------------------------------------------------------------------------------------------------\n');
    

    Counter1 = [6, 0.1 ;
                7, 0.1 ;
                8, 0.2 ;
                9, 0.6 ];
    
    Counter2 = [4, 0.1;
                5, 0.1;
                6, 0.2;
                7, 0.25;
                8, 0.35];

    Counter3 = [2, 0.3;
                3, 0.28;
                4, 0.25;
                5, 0.17];

    Counter4 = [4, 0.2;
                5, 0.2;
                6, 0.25;
                7, 0.2;
                8, 0.15];

    tableInterarrival = [];
    max = 4;
    for i = 1:max
        tableInterarrival(i,1) = i;
        tableInterarrival(i,2) = 1/max;
    end

    TicketDay =     [1, 0.55;
                     2, 0.45];

    TypeOfTicket =  [1, 0.75;
                     2, 0.25];

    Membership =    [1, 0.2;
                     2, 0.8];

    NumberOfTicket =[1, 0.15;
                     2, 0.60;
                     3, 0.25];

    RanCasherBreakTime = []; %%%To store time spent
    casherBreak = [6, 0.4; 
                   7, 0.25;
                   8, 0.15;
                   9, 0.1;
                   10, 0.1];


    % Printing information tables & re-asign CDF
    Ticket = InitTicket();
    Counter1 = DisplayTable(Counter1,'Counter 1(Non-member)','Service Time', 100);
    Counter2 = DisplayTable(Counter2,'Counter 2(Non-member)','Service Time', 100);
    Counter3 = DisplayTable(Counter3,'Counter 3(Non-member)','Service Time', 100);
    Counter4 = DisplayTable(Counter4,'Counter 4(Non-member)','Service Time', 100);
    InterArrivalTime = DisplayTable(tableInterarrival, 'Interarrival Time' , 'Inte-Arr Time' , 1000 );
    TicketDay = DisplayTable(TicketDay, 'Ticket Day Table', 'Ticket Day ', 100);
    TypeOfTicket = DisplayTable(TypeOfTicket, 'Ticket Type Table', 'Ticket Type ', 100);
    Membership = DisplayTable(Membership, 'Membership Table', 'Membership ', 100);
    NumberOfTicket = DisplayTable(NumberOfTicket, 'Number of Ticket Purcharsed Table(n)', 'Num of Ticket', 10);
    casherBreak = DisplayTable(casherBreak, 'Casher Break Time', 'Time Spent ', 100);

    TicketCount = InitTicketCount();    
    
    

    % Database: [IAT, Arr, Day, Type, Member, No, Paid]
    Database = [];
    for i = 1:numOfPeople
        if(i == 1) % for first row
            Database(i,1) = 0;
            Database(i,2) = 0;
        else
            for j = 1:8
                if(RanInterArrival(i-1) <= (InterArrivalTime(j,3))*1000)
                    Database(i,1) = InterArrivalTime(j,1);          %%%%% Interarrival Time
                    break
                end
            end
            Database(i,2) = Database(i,1) + Database(i-1,2);        %%%%% Arrival Time
        end
        
        for d = 1:2
            if(RanTicketDay(i) <= (TicketDay(d,3))*100)
                Database(i,3) = TicketDay(d,1);                     %%%%% Random TicketDay
                break
            end
        end
        
        for t = 1:2
            if(RanTicketType(i) <= (TypeOfTicket(t,3))*100)
                Database(i,4) = TypeOfTicket(t,1);                  %%%%% Random Type Ticket
                break
            end
        end
        
        for m = 1:2
            if(RanMembership(i) <= (Membership(m,3))*10)
                Database(i,5) = Membership(m,1);                    %%%%% Membership
                break
            end
        end
        
        for n = 1:3
            if(RanNumberOfTicketPurchased(i) <= (NumberOfTicket(n,3))*100) %which category does it falls in
                if(TicketCount(Database(i,3),Database(i,4)) >= NumberOfTicket(n,1))
                    Database(i,6) = NumberOfTicket(n,1);
                    TicketCount(Database(i,3),Database(i,4)) = TicketCount(Database(i,3),Database(i,4)) - NumberOfTicket(n,1);
                    Database(i,7) = Database(i,6) * TicketCount(3,Database(i,4));
                else
                    % total ticket is lesser than what the customer wanted
                    Database(i,6) = TicketCount(Database(i,3),Database(i,4)); %smaller than 3
                    Database(i,7) = Database(i,6) * TicketCount(3,Database(i,4));
                end
                break                                               %%%%% Number ticket Purcharsed
            end                                                     %%%%% Paid
        end        
    end

    for i = 1:numOfBreak
        for b = 1:5
            if(RanCasherBreak(i) <= (casherBreak(b,3))*100)

                %% Random Time Spent by Casher to take break
                RanCasherBreakTime(i,1) = casherBreak(b,1);  

                %% After Which Customer left the counter       
                RanCasherBreakTime(i,2) = mod(round(100*randexp(ones(1,numOfBreak))),98)+2;    %%Start from 2nd 
                break
            end
        end
    end
    
    TicketsSoldTable(numOfPeople,Database,RanInterArrival,RanTicketDay,RanTicketType);
    
    CounterOperation(numOfPeople,Database,Counter1,Counter2,Counter3,Counter4,RanServiceTime, RanCasherBreakTime);
    
    RemainingTicketTable(TicketCount);
    
