clc
clear

prb_num = 100;      %RB����,��ѡ50��100
rbstart = 0;
UL_subframe_num=2;
cellid = 0;
% ��������� 
% rxmodify��ͬ����������� 
% rimestart��ʱ϶��ʼλ�� 
% corrdata��ͬ������غ����� 
% ��������� 
% rxData�������ŵ������� 
% prb_num��UE��RB���� 
% rbstart��UEռ�õ�������Դ�����ʼλ�� 
% UL_subframe_num��������֡ʱ϶�� 
% cellid��С��ID 
load corrdatatest.mat
load rxdata.mat   %�����׼��������
load rxmodify.mat % �����׼������ݡ� ͬ�������ݡ�
size(corrdatatest)
[ rxmodify1,timestart,corrdata] = synchronization (rxdata,prb_num,rbstart,UL_subframe_num,cellid);
should = 6737
timestart
dert = corrdatatest-corrdata;
figure(333);
plot(corrdata);
figure(222);
plot(abs(dert));
errnum = sum(sum(rxmodify-rxmodify1))%�Ƚϱ�׼�����ʵ�ʳ��������errnumΪ0������д��ȷ����������д���