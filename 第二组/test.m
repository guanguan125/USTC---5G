clc
clear

I_LBRM =0; %用于计算Ncb的值
vnum =1;  %层的个数
module_type = 4;    %调制方式，1: QPSK; 2:16QAM; 3:64QAM 4:256QAM
Qm = module_type*2;
C=9;
Nsym_slot =14;% 每个slot占用的symbol数
DMRS_symbol =2; %解调参考信号的符号个数
prb_num = 100;      %RB个数,可选50、100
rvid = 0; %冗余版本号
LDPC_base_graph =1; %1:选用LDPC_base_graph1 2：LDPC_base_graph2
Zc=384;

load coded_data.mat  %导入标准输入数据
load rm_data.mat %导入标准输出数据。 速率匹配后数据。
size(coded_data)
[ rmdata,rmlen ] = NR_RateMatch(coded_data,I_LBRM,vnum,Qm,C,Nsym_slot,DMRS_symbol,prb_num,rvid,LDPC_base_graph,Zc );
% errnum = sum(sum(rmdata-rm_data))%比较标准输出和实际程序输出。errnum为0则程序编写正确，否则程序有错误。
errnum = sum(sum((rmdata-rm_data).^2));%比较标准输出和实际程序输出。

% errnum为误差的平方和，若小于10^-6则程序编写正确，否则程序有错误。
 if errnum >=0.000001
 disp('数据误差过大，请重新检查程序');
 else
    disp('数据校验正确');
 end %  