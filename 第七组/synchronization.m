function [ rxmodify,timestart,corrdata] = synchronization ( rxData,prb_num,rbstart,UL_subframe_num,cellid)
%ͬ��

% ͬ�����ݼ���
pssdata = GenPss(prb_num,rbstart,UL_subframe_num,cellid);%Primary Synchronzation SignalΪPSS�����źŵ�ͬ��

% ͬ�� ����ط���㣩 ����Ӧ�˲�
pssdata_len=2048;% ͬ���볤�� 1024~2048
pssdata=pssdata(1:pssdata_len);

% corrlen=12969 ;% ͬ������س���1024~ 29696  12969 30576 
%corrlen= 12737;% 6737+6000
corrlen= 29696;
[searchflag,timestart,corrdata] = LTECorrFun(rxData,corrlen,pssdata);%����Ӧ�˲�
%���ݲ��Խ��������֡
rxmodify = LTEFram(rxData,timestart);

end

