clc
clear

I_LBRM =0; %���ڼ���Ncb��ֵ
vnum =1;  %��ĸ���
module_type = 4;    %���Ʒ�ʽ��1: QPSK; 2:16QAM; 3:64QAM 4:256QAM
Qm = module_type*2;
C=9;
Nsym_slot =14;% ÿ��slotռ�õ�symbol��
DMRS_symbol =2; %����ο��źŵķ��Ÿ���
prb_num = 100;      %RB����,��ѡ50��100
rvid = 0; %����汾��
LDPC_base_graph =1; %1:ѡ��LDPC_base_graph1 2��LDPC_base_graph2
Zc=384;

load coded_data.mat  %�����׼��������
load rm_data.mat %�����׼������ݡ� ����ƥ������ݡ�
size(coded_data)
[ rmdata,rmlen ] = NR_RateMatch(coded_data,I_LBRM,vnum,Qm,C,Nsym_slot,DMRS_symbol,prb_num,rvid,LDPC_base_graph,Zc );
% errnum = sum(sum(rmdata-rm_data))%�Ƚϱ�׼�����ʵ�ʳ��������errnumΪ0������д��ȷ����������д���
errnum = sum(sum((rmdata-rm_data).^2));%�Ƚϱ�׼�����ʵ�ʳ��������

% errnumΪ����ƽ���ͣ���С��10^-6������д��ȷ����������д���
 if errnum >=0.000001
 disp('���������������¼�����');
 else
    disp('����У����ȷ');
 end %  