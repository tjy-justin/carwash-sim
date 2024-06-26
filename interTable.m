function rangeArrival = interTable(r, loopNum, m, a, c, rangeArrival)
    %this function prints inter arrival probability table
    
    loopNum = 4;
    
    if r == 1
    for i=1:loopNum
        probability(i) = rand();
        probability = probability / sum(probability); %normalising so that sum(probability) = 1
        probability = round(probability * 100) / 100;
    end
    
    elseif r == 2
        probability = lcg(loopNum,m,a,c);
    
    elseif r == 3
        probability = rvge(loopNum) ;
    
    elseif r == 4
        probability = rvgu(loopNum) ;
    
    else
        fprintf('zero \n');
        return;
    end
    
    % normalising so that sum(probability) = 1
    probability = probability / sum(probability);
    probability = round(probability*100)/100;
    
    % sometimes sum(probability) will not equal 1 because each value is rounded so here the leftover is
    if sum(probability) ~= 1
        leftover = 1 -sum(probability);
        index = randi(1,loopNum) ;
        probability(index) = probability(index) + leftover;
    end
    
    % returns probability
    output = probability;
    
    % setting cdf
    cdf= zeros(1,4) ;
    cdf(1) = probability(1);
    for i=2:4
        cdf(i) =probability(i) + cdf(i-1);
    end

    % setting range
    range = zeros(1,4) ;
    for i = 1:4
        range(i) = ceil(cdf(i) * 100); % Modified line: using ceil to round up to whole numbers
        rangeArrival(i) = range(i);
    end

    fprintf('\n---------- Inter-Arrival Times ----------\n\n');

    fprintf('Arrival Time|');
    for i = 1:loopNum
        fprintf(' %6d |', i);
    end
    fprintf('\n');

    % checking if arrays work
    % disp(cdf);
    % disp(range);

    fprintf('Probability |');
    for i = 1:length(probability)
        fprintf(' %6.2f |', probability(i));
    end
    fprintf('\n');

    fprintf('CDF         |');
    for i = 1:length(cdf)
        fprintf(' %6.2f |', cdf(i));
    end
    fprintf('\n');

    fprintf('Range       |');
    fprintf(' 0 -%3d |', range(1));
    for i = 2:length(range)
        fprintf(' %3d-%3d |', range(i-1) + 1, range(i));
    end
    fprintf('\n');