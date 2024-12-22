clc
clear

module_type = 3; %���Ʒ�ʽ��1: QPSK; 2:16QAM; 3:64QAM 4:256QAM 
qm = module_type*2;
%�����׼��������,delayermapdata.mat��Ӧ256QAM��delayermapdata1.mat��Ӧ64QAM��delayermapdata2.mat��Ӧ16QAM��delayermapdata3.mat��ӦQPSK
%�����׼�������,demoddata.mat��Ӧ256QAM��demoddata1.mat��Ӧ64QAM��demoddata2.mat��Ӧ16QAM��demoddata3.mat��ӦQPSK
if qm==2
    load delayermapdata3.mat    
    load demoddata3.mat 
    delayermapdata = delayermapdata3;
    demoddata = demoddata3;
elseif qm==4
    load delayermapdata2.mat    
    load demoddata2.mat 
    delayermapdata = delayermapdata2;
    demoddata = demoddata2;
elseif qm==6
    load delayermapdata1.mat    
    load demoddata1.mat 
    delayermapdata = delayermapdata1;
    demoddata = demoddata1;
elseif qm==8
    load delayermapdata.mat    
    load demoddata.mat 
end
 
outdemod = NR_Demod(delayermapdata,qm);
errnum = sum((demoddata-outdemod).^2)%�Ƚϱ�׼�����ʵ�ʳ��������
% errnumΪ����ƽ���ͣ���С��10^-6������д��ȷ����������д���
 if errnum >=0.000001
    disp('���������������¼�����');
 else
    disp('����У����ȷ');
 end %  