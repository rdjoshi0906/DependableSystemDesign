function [rec, syndrome, err] = detectErrors(received, generator)
    received_codewordLen = length(received);
    generatorLen = length(generator);
    temp = received;
    iterator = 1;
    
    % This loop is responsible for xor division
    while iterator<=received_codewordLen - generatorLen + 1
        if temp(1,iterator) == 1
            temp(1,iterator:iterator+generatorLen-1) = bitxor(temp(1,iterator:iterator+generatorLen-1),generator);
        end
        iterator = iterator+1;
    end

    rec = received;
    
    syndrome = temp(1, received_codewordLen - generatorLen + 2: received_codewordLen);
    check = ones(1, generatorLen - 1)*0;
    
    % check if syndrome is 0
    % if 0 then no error or untraceable error else there is an error
    if isequal(syndrome, check)
        err = 0;
    else
        err = 1;
    end
end