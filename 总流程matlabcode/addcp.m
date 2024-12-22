%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName:            addcp.m
%  Description:         ��CP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parameter List:       
%       Output Parameter
%           output	 ��CP������
%       Input Parameter
%           input	  ���ƺ�����        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  History
%    1. Date:          2010-06-20
%       Author:         zzk
%       Version:        1.0 
%       Modification:   ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = addcp(input)
symnum =14;  %һ����֡Ϊ14������
u = 29; %ZC�ĸ�����
N = 157; %��һ�����ŵ�CPΪ160��,10���ڵ�����Ϊ157
start =1;
output =zeros(1,30720);
pssdata = zeros(1,N);

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
% output = output*30;

% %����ͬ����
% for n=1:N
%     pssdata(n) = exp(-1j*pi*u*(n-1)*n/N);
% end
% % ifftpssdata = ifft(pssdata);
% pssdata = pssdata/120;
% 
% output(1,1:N) = pssdata;
    
end