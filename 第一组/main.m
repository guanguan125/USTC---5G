clc
clear

LDPC_base_graph = 1; %1:ѡ��LDPC_base_graph1 2��LDPC_base_graph2
i_ls =1; %���ڼ���LDPC���ƶ���С����38.212 ��5.3.2-1

load info_data  %�����׼��������
load cdblkseg_data %�����׼�������

[p,C,Zc,K,K_p,outdata,F] = NR_crc24a(info_data,LDPC_base_graph,i_ls);%NR_crc24a.m�ļ�

errnum = sum(sum((cdblkseg_data-outdata).^2))%�Ƚϱ�׼�����ʵ�ʳ��������

% errnumΪ����ƽ���ͣ���С��10^-6������д��ȷ����������д���
 if errnum >=0.000001
 disp('���������������¼�����');
 else
    disp('����У����ȷ');
 end %  