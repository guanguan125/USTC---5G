%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName:            genantdata.m
%  Description:         ����ʱ�����ݣ�OFDM���ƣ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parameter List:       
%       Output Parameter
%           out                   ���ʱ�����ݣ�����ά��1*28672
%       Input Parameter
%           input_data      ����Ƶ�����ݣ�����ά��14*2048
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  History
%    1. Date:          2010-06-20
%       Author:         zzk
%       Version:        1.0 
%       Modification:   ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function out =genantdata(inputdata)

nfft=2048;
nulsym = 7;
start =1;
half =600;
total =1200;
out = zeros(1,28672);

for(iii=1:2*nulsym)
    %�˿�0������iii
%     tmpdata=[inputdata(iii,(half+1):total),zeros(1,(nfft-total)),inputdata(iii,1:half)];
    tmpdata=inputdata(iii,:);
    ifftdata = ifft(tmpdata,2048);
    tail = start+nfft-1;
    out([start:tail]) =ifftdata([1:nfft]);      
    start = tail+1;   
end