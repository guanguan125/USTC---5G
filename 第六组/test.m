clc
clear

prb_num = 100;      %RB����,��ѡ50��100
module_type = 4;    %���Ʒ�ʽ��1: QPSK; 2:16QAM; 3:64QAM 4:256QAM
Qm = module_type*2;
ue_index = 10;
cellid = 0;
C=9;
rm_len=[12800;12800;12800;12800;12800;12800;12800;12800;12800];%���ָ��ÿ����鳤��
 
load demoddata.mat   %�����׼��������
load deccbc_data.mat % �����׼������ݡ� ��ӳ������ݡ�
size(demoddata)
size(deccbc_data)
deccbc_datad = NR_DeScramble(demoddata,prb_num,Qm,ue_index,cellid,C,rm_len);

errnum = sum(sum(deccbc_datad-deccbc_data))%�Ƚϱ�׼�����ʵ�ʳ��������errnumΪ0������д��ȷ����������д���