%% OFDM���
%% ����ȥCP��OFDM���
function out = NR_DeFreData( input,Nsym_slot,Nu,EN_TIMEOFFSETCP,timeoffsetCP) 

%% �ྶCPʱ��

% EN_TIMEOFFSETCP = 1;  %CP�ྶʱ��ʱ�ӿ��أ�1:on�� 0��off
% timeoffsetCP =150;    %CP�ྶʱ���ӳٲ�����,���뷶Χ100~200
T=timeoffsetCP;
 if(EN_TIMEOFFSETCP)
%         txdata = gentimeoffset(txdata,timeoffsetCP);
        input = [  zeros(1,T)  input(1,1:end-T) ];
    end


%% ȥCP
symnum =14;  %һ����֡Ϊ14������

start =1;
output =zeros(1,2048*14);

for ii = 1:symnum
     if((1==ii)|| (8==ii))   %CP����Ϊ160
         start = start+160;
         tail = start+2048-1;
         output(1,(ii-1)*2048+1:ii*2048) = input(start:tail);  
         start = tail+1;
     else    %cp����Ϊ144
         start = start+144;
         tail = start+2048-1;
         output(1,(ii-1)*2048+1:ii*2048) = input(start:tail);  
         start = tail+1;
         
     end
end

timedata = output;
%% OFDM ���
nfft = Nu;
start =1;

out = zeros(1,Nu*Nsym_slot);

for(iii=1:Nsym_slot)
        
    tmpdata = timedata((iii-1)*nfft+1:iii*nfft);
    fftdata = fft(tmpdata,nfft);
    tail = start+nfft-1;
    out([start:tail]) =fftdata([1:nfft]);      
    start = tail+1;   
end


end

