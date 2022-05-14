function [errors, total_error, percentage_Error_Correction]  = percentageDetection(codeword, generator)
    generatorLen = length(generator);
    codewordLen = length(codeword);
    datawordLen = codewordLen - generatorLen + 1;
    
    z = 1:codewordLen;
    errors = [];
    total_error = [];
    percentage_Error_Correction = [];

    for i = 2:codewordLen
        detectedErrors = 0;
        Errors = 0;
        
        A = nchoosek(z,i);
        
        for j = 1:size(A,1)
            temp = codeword(1,:);
            errorFlag = 0;
            
            for k = 1:i
                index = uint32(A(j,k));
                temp(1,index) = ~temp(1,index);
            end
            
            [~,~,errorFlag] = detectErrors(temp,generator);
            
            % check for the error. If error detected, increment detectedError bit by 1
            if errorFlag == 1
                detectedErrors = detectedErrors + 1;
            end
            
            Errors = Errors + 1;
        end
        
        prob = 1/(nchoosek(codewordLen,i));
        percentage_Error_Correction = [percentage_Error_Correction prob];
        errors = [errors detectedErrors];
        total_error = [total_error Errors];
    end
end