%% Ԥ����
%% ������ӳ�䡢����Ԥ���롢Ԥ����
function output = NR_Precode(moddata, vnum,transformprcode_en,Nsym_slot,DMRS_symbol,prb_num, CodebookTransform_en, TPMIindex,Antportnum)
%% ��ӳ��
%outdatda = LayerMapper_5G( moddata, vnum)
len = length(moddata);
switch vnum
    case 1
        outdatda = moddata;
    case 2
        outdatda(1,:) = moddata(1:2:len-1);
        outdatda(2,:) = moddata(2:2:len);
    case 3
        outdatda(1,:) = moddata(1:3:len-2);
        outdatda(2,:) = moddata(2:3:len-1);
        outdatda(3,:) = moddata(3:3:len);     
    case 4
        outdatda(1,:) = moddata(1:4:len-3);
        outdatda(2,:) = moddata(2:4:len-2);
        outdatda(3,:) = moddata(3:4:len-1);    
        outdatda(4,:) = moddata(4:4:len);  
    otherwise
       disp('layer number is worng' );     
end
inputdata = outdatda;
%% ����Ԥ����
%  out = TransformProcode_5G( transformprcode_en,inputdata,Nsym_slot,DMRS_symbol,prb_num)
nsymnum = Nsym_slot - DMRS_symbol;
carry_len = prb_num*12;
start =1;
out = inputdata;

if(0 == transformprcode_en)
    out = inputdata;
else
    %����Ԥ����ֻ�ǶԵ�һ������з��Ž���DFT�仯,����������ݲ����б仯��
    tempdata = inputdata(1,:);
    for k =1:nsymnum
         tail = start+carry_len-1;
         dftout = fft(tempdata([start:tail]),carry_len)/sqrt(carry_len);
         out(1,start:tail) = dftout;
          start =tail+1;        
    end
    
    
end
inputdata = out;
%% Ԥ����
% output = Precode_5G( CodebookTransform_en, TPMIindex,inputdata,Antportnum)
temp = 1/(2^0.5);
vnum2table = [1,0;
              0,1;
              1,1;
              1,-1;
              1,j;
              1,-j];

if(0 == CodebookTransform_en)
    output = inputdata;
else
    %���ֻ��һ�㣬W=1
    if(1 == Antportnum)
       output = inputdata; 
    else
        if(2 == Antportnum)
            PreMatrix  = (temp*vnum2table(TPMIindex+1,:))';
            output = inputdata*PreMatrix;
        else
          %����4���߶˿�
        end
    end
end


end

