function codeword = generateCodeword(dataword, generator)
    datawordLen = length(dataword);
    x = ones(1,datawordLen)*0;
    generatorLen = length(generator);
    dividend = [dataword ones(1,generatorLen-1)*0];
    
    i = 1;

    while ~isequal(dividend(1:datawordLen),x)
        if dividend(1,i) == 1
            dividend(1,i:i+generatorLen-1) =  bitxor(dividend(1,i:i+generatorLen-1),generator);
        end
        i = i+1;
    end
    
    codeword = [dataword dividend(1, datawordLen+1:generatorLen+datawordLen-1)];        
end