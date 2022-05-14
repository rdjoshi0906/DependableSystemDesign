dataMatrix = [];
probabilityMatrix = [];

% CRCN generators
% Each CRCN matrix has k generators of N bit
CRC1 = [1 1];
CRC2 = [1 0 0; 1 0 1];
CRC3 = [1 0 0 0; 1 0 1 1];
CRC4 = [1 0 0 0 0; 1 0 0 1 1];
CRC5 = [1 0 0 0 0 0; 1 0 1 0 0 1; 1 1 0 1 0 1; 1 0 0 1 0 1];
CRC6 = [1 0 0 0 0 0 0; 1 0 0 1 1 1 1; 1 0 1 1 1 1 1; 1 0 0 0 0 1 1; 1 0 0 1 0 1 0];
CRC7 = [1 0 0 0 0 0 0 0; 1 0 0 0 1 0 0 1; 1 0 1 0 1 0 0 1; 1 0 0 0 1 0 1 1];

inputCrc = input('Select CRC from the list below:\n1. CRC1\n2. CRC2\n3. CRC3\n4. CRC4\n5. CRC5\n6. CRC6\n7. CRC7\n\nEnter from 1 to 7:\n');
dataWord = input('Input Vector dataword in format [1 0 0 1]:\n'); 

% Test will have the CRCN corresponding to inputted N
Test = [];

switch(inputCrc)
    case 1
        Test = CRC1;
    case 2 
        Test = CRC2;
    case 3 
        Test = CRC3;
    case 4 
        Test = CRC4;
    case 5 
        Test = CRC5;
    case 6 
        Test = CRC6;
    case 7 
        Test = CRC7;
end

for i = 1:size(Test,1)
    generator = Test(i,:);
    
    % generate each codeword from dataword wrt to the selected generator
    inputCrc = generateCodeword(dataWord, generator);
    [err,total,pro] = percentageDetection(inputCrc,generator);
    probabilityMatrix = [probabilityMatrix; pro];
    
    dataMatrix = [dataMatrix; (err./total)*100];
end

data2 = transpose(dataMatrix);
probT = transpose(probabilityMatrix);

probT = probT.*data2;

for i = 1:size(data2,1)
    figure;
    data = data2(i,:);
    labels = probT(i,:);
    bar(data);
    
    text(1:length(data),data,strcat(num2str(data'),' and ',num2str(labels')),'vert','bottom','horiz','center');   
    box off;
    c = cell(1:size(Test,1));
    for k = 1:size(Test,1)
       c{k} = num2str(Test(k,:));
    end
    set(gca,'XTickLabel',c);
    
    ylabel('Percentage %');
    xlabel(strcat('No. of bit errors :', num2str(i+1)));
end
