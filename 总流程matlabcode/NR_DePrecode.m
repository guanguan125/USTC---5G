%% ��Ԥ����
%% ������Ԥ���롢�⴫��Ԥ���롢���ӳ��
function outdata = NR_DePrecode( CodebookTransform_en, TPMIindex,equdata,Antportnum,transformprcode_en,Nsym_slot,DMRS_symbol,prb_num,vnum)
%% ��Ԥ����
temp = 1/(2^0.5);
vnum2table = [1,0;
              0,1;
              1,1;
              1,-1;
              1,j;
              1,-j];

if(0 == CodebookTransform_en)
    output = equdata;
else
    %���ֻ��һ�㣬W=1
    if(1 == Antportnum)
       output = inputdata; 
    else
        if(2 == Antportnum)
            PreMatrix  = (temp*vnum2table(TPMIindex+1,:))';
            output = equdata/PreMatrix;  %Ԥ����ʱ����Ԥ������󣬽�Ԥ����ʱ����Ԥ�������
        else
          %����4���߶˿�
        end
    end
end
deprecodedata = output;
%% �⴫��Ԥ����
% function out = DeTransformProcode_5G( transformprcode_en,deprecodedata,Nsym_slot,DMRS_symbol,prb_num )
nsymnum = Nsym_slot - DMRS_symbol;
carry_len = prb_num*12;
start =1;
out = deprecodedata;

if(0 == transformprcode_en)
    out = deprecodedata;
else
    %�⴫��Ԥ����ֻ�ǶԵ�һ������з��Ž���IDFT�仯,����������ݲ����б仯��
    tempdata = deprecodedata(1,:)*sqrt(carry_len);
    for k =1:nsymnum
         tail = start+carry_len-1;
%          dftout = fft(tempdata([start:tail]),carry_len)/sqrt(carry_len);
%          out(1,start:tail) = dftout;
           fftout = ifft(tempdata(start:tail),carry_len);
           out(1,start:tail) = fftout;
          start =tail+1;        
    end
end
detransformprecodedata = out;
%% ���ӳ��
%����ÿ������ݳ���
len = length(detransformprecodedata(1,:));

%���������ݺϳ�һ·���ݣ����ں���Ľ��
for ii = 1:len
    for jj = 1:vnum
        outdata((ii-1)*vnum+jj) = detransformprecodedata(jj,ii);
    end
    
end
end

