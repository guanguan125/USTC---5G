clc
clear

%% �������
module_type = 4; %���Ʒ�ʽ��1: QPSK; 2:16QAM; 3:64QAM 4:256QAM 
prb_num = 100;   %RB����,��ѡ50��100
%% ��������
load scramble_data.mat  %�����׼��������
load mod_data.mat %�����׼������ݡ� mod_data.matΪ256QAM���ݣ�mod_data1.matΪ64QAM���ݣ�mod_data2.matΪ16QAM���ݣ�mod_data3.matΪQPSK����

%%
out = NR_Mod(scramble_data,prb_num,module_type);

errnum = sum((mod_data-out).^2)%�Ƚϱ�׼�����ʵ�ʳ��������errnumΪ����ƽ���ͣ���С��10^-6������д��ȷ����������д���
 if errnum >=0.000001
 disp('���������������¼�����');
 else
    disp('����У����ȷ');
 end %     