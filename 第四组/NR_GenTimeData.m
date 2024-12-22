%% OFDM ����ģ��
%% ����OFDM���ơ���CP
function [output,input] = NR_GenTimeData( fredata,Nsym_slot,Nu,EN_CP)
%% OFDM����
% out = GenTimeData_5G(fredata,Nsym_slot,Nu);
% fredata�����ɵ�Ƶ������ 
% Nsym_slot��ÿ��slotռ�õ�symbol�� 
% Nu��ÿ�����ŵĲ������� 
% EN_CP����CP���أ�1������0�ر�
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% student code %%%%%%%%%%%%%%%%%%%%%%%%%%
out = GenTimeData_5G(fredata,Nsym_slot,Nu);%Ҫ����

size(out)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ��CP
input = out;
% output = addcp(input,EN_CP)
symnum =14;  %һ����֡Ϊ14������
u = 29; %ZC�ĸ�����
N = 157; %��һ�����ŵ�CPΪ160��,10���ڵ�����Ϊ157
start =1;
output =zeros(1,30720);
pssdata = zeros(1,N);

if(EN_CP)
   for ii = 1:symnum
    if((1==ii)|| (8==ii))
       %����1�ͷ���8���CP��CP����Ϊ160
       tempsymdata = input(1,(ii-1)*2048+1:ii*2048);
       tempcpdata = tempsymdata(1,1889:2048);
       tail = start+2048+160 -1;
       output(1,start:tail) = [tempcpdata,tempsymdata];
       start = tail +1;     
    else
       %�����������CP��CP����Ϊ144
       tempsymdata = input(1,(ii-1)*2048+1:ii*2048);
       tempcpdata = tempsymdata(1,1905:2048);
       tail = start+2048+144 -1;
       output(1,start:tail) = [tempcpdata,tempsymdata];
       start = tail +1;   
       
    end
   end  
else
    tempdata1 = zeros(1,160);
    tempdata2 = zeros(1,144);
   for ii = 1:symnum
    if((1==ii)|| (8==ii))
       %����1�ͷ���8���CP��CP����Ϊ160
       tempsymdata = input(1,(ii-1)*2048+1:ii*2048);
%        tempcpdata = tempsymdata(1,1889:2048);
       tempcpdata =tempdata1;
       tail = start+2048+160 -1;
       output(1,start:tail) = [tempcpdata,tempsymdata];
       start = tail +1;     
    else
       %�����������CP��CP����Ϊ144
       tempsymdata = input(1,(ii-1)*2048+1:ii*2048);
%        tempcpdata = tempsymdata(1,1905:2048);
       tempcpdata = tempdata2;
       tail = start+2048+144 -1;
       output(1,start:tail) = [tempcpdata,tempsymdata];
       start = tail +1;   
       
    end
   end  
    
end
end

