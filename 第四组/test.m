clc
clear

Nsym_slot =14;      % ÿ��slotռ�õ�symbol��
Nu=2048;            %ÿ�����ŵĲ�������
EN_CP = 1;          %CP���أ�1:on ,0��off

load fredata.mat    %�����׼��������
load txdata.mat     %�����׼�������
size(fredata)
output = NR_GenTimeData( fredata,Nsym_slot,Nu,EN_CP);

errnum = sum(abs(txdata-output).^2)%�Ƚϱ�׼�����ʵ�ʳ��������errnumΪ0������д��ȷ����������д���

% errnumΪ����ƽ���ͣ���С��10^-6������д��ȷ����������д���
 if errnum >=0.000001
 disp('���������������¼�����');
 else
    disp('����У����ȷ');
 end %  