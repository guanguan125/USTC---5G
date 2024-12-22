%% OFDM 调制模块
%% 包含OFDM调制、加CP
function [output,input] = NR_GenTimeData( fredata,Nsym_slot,Nu,EN_CP)
%% OFDM调制
% out = GenTimeData_5G(fredata,Nsym_slot,Nu);
% fredata：生成的频域数据 
% Nsym_slot：每个slot占用的symbol数 
% Nu：每个符号的采样点数 
% EN_CP：加CP开关，1开启，0关闭
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% student code %%%%%%%%%%%%%%%%%%%%%%%%%%
out = GenTimeData_5G(fredata,Nsym_slot,Nu);%要做到

size(out)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 加CP
input = out;
% output = addcp(input,EN_CP)
symnum =14;  %一个子帧为14个符号
u = 29; %ZC的根序列
N = 157; %第一个符号的CP为160，,10以内的质数为157
start =1;
output =zeros(1,30720);
pssdata = zeros(1,N);

if(EN_CP)
   for ii = 1:symnum
    if((1==ii)|| (8==ii))
       %符号1和符号8添加CP，CP长度为160
       tempsymdata = input(1,(ii-1)*2048+1:ii*2048);
       tempcpdata = tempsymdata(1,1889:2048);
       tail = start+2048+160 -1;
       output(1,start:tail) = [tempcpdata,tempsymdata];
       start = tail +1;     
    else
       %其它符号添加CP，CP长度为144
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
       %符号1和符号8添加CP，CP长度为160
       tempsymdata = input(1,(ii-1)*2048+1:ii*2048);
%        tempcpdata = tempsymdata(1,1889:2048);
       tempcpdata =tempdata1;
       tail = start+2048+160 -1;
       output(1,start:tail) = [tempcpdata,tempsymdata];
       start = tail +1;     
    else
       %其它符号添加CP，CP长度为144
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

