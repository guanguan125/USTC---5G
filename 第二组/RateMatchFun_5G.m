function [ Output,out_len ] = RateMatchFun_5G( Info_data,I_LBRM,vnum,Qm,C,Nsym_slot,DMRS_symbol,prb_num,rvid,LDPC_base_graph,Zc,k,Er)
%{
输出参数： 
rm_data：    速率匹配后的数据 
rm_len：     速率匹配后的长度 
输入参数： 
coded_data：   LDPC编码后的码块数据 
I_LBRM：    用于计算Ncb的值 
vnum         层的个数 
Qm：        调制方式。2：QPSK  4:16QAM  6:64QAM  8:256QAM 
C：          传输块分割的码块数 
Nsym_slot：  每个slot占用的symbol数 
DMRS_symbol：解调参考信号的符号个数 
prb_num：     UE的RB个数 
rvid：         冗余版本号 
LDPC_base_graph：1:选择LDPC_base_graph1  2: LDPC_base_graph2 
Zc：          LDPC的移位值 
I_LBRM =0;
vnum =1; 
module_type = 4;    %调制方式，1: QPSK; 2:16QAM; 3:64QAM 4:256QAM
Qm = module_type*2;C=9;Nsym_slot =14;DMRS_symbol =2;
prb_num = 100;      rvid = 0; 
LDPC_base_graph =1; %1:选用LDPC_base_graph1 2：LDPC_base_graph2
Zc=384;
load coded_data.mat  %导入标准输入数据
load rm_data.mat %导入标准输出数据。 速率匹配后数据。
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% student code %%%%%%%%%%%%%%%%%%%%%%%%%%
%根据I_LBRM确定Ncb
TBS_LBRM = 100;%有待确定
[a1,N]=size(Info_data);%是输入序列的一维长度
R_LBRM = 2/3;
Nref = floor(TBS_LBRM/(C*R_LBRM));
if (I_LBRM==0)
    Ncb = N;
    disp('根据I_LBRM==0，Ncb取N');
else
    Ncb = min(N,Nref);
    disp('根据I_LBRM==1，Ncn取min(N,Nref)');
end
%根据rvid确定
switch rvid
    case 0
         k0 = 0;
    case 1
        if(LDPC_base_graph==1)
            k0 = Zc*floor((17*Ncb)/(66*Zc));
        elseif(LDPC_base_graph==2)
            k0 = Zc*floor((13*Ncb)/(50*Zc));
        else
            disp('LDPC_base_graph条件出错')
        end
    case 2
        if(LDPC_base_graph==1)
            k0 = Zc*floor((33*Ncb)/(66*Zc));
        elseif(LDPC_base_graph==2)
            k0 = Zc*floor((25*Ncb)/(50*Zc));
        else
            disp('LDPC_base_graph条件出错')
        end
    case 3
        if(LDPC_base_graph==1)
            k0 = Zc*floor((56*Ncb)/(66*Zc));
        elseif(LDPC_base_graph==2)
            k0 = Zc*floor((43*Ncb)/(50*Zc));
        else
            disp('LDPC_base_graph条件出错')
        end
    
    otherwise
        disp('rvid出错，应为0、1、2、3')
end

%判断k，Er大小，由k0，Ncb计算匹配后的数据
j = 0;
Er
length= size(Info_data)
Output = zeros(1,Er);
for k=1:Er
    Output(1,k) = Info_data(mod(k0+j,Ncb)+1);
    j=j+1;
end
out_len = Er;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%