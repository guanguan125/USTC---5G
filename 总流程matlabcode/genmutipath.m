function out = genmutipath(inputdata,mutiamp,mutitimeoffset,mutifreoffset,mutiphaseoffset)

% �������
% A1 = (0.1+0.9*rand(1,1))*mutiamp(1);
A1 = mutiamp(1);
% ������ƫ
% P1 = (2*rand(1,1)-1)*mutiphaseoffset(1);
P1 = mutiphaseoffset(1);
% ����Ƶƫ
% F1 = (2*rand(1,1)-1)*mutifreoffset(1);
F1 = mutifreoffset(1);
% ����ʱƫ
% T = floor(rand(1,1)*Tmax*Fs);
% T = floor(rand(1,1)*Tmax);
T1 = mutitimeoffset(1);


% �������
% A2 = (0.1+0.9*rand(1,1))*mutiamp(2);
A2 = mutiamp(2);
% ������ƫ
% P2 = (2*rand(1,1)-1)*mutiphaseoffset(2);
P2 = mutiphaseoffset(2);
% ����Ƶƫ
% F2 = (2*rand(1,1)-1)*mutifreoffset(2);
F2 = mutifreoffset(2);
% ����ʱƫ
% T = floor(rand(1,1)*Tmax*Fs);
% T = floor(rand(1,1)*Tmax);
T2 = mutitimeoffset(2);

%ChannelParameter = [ A P F T SNR];
SNR =35;
Fs=30720000;

% ��ʱƫ
SendSig1 = [ zeros(1,T1) inputdata(1,1:end-T1) ];

% ��Ƶƫ����ƫ�ͷ��ȱ仯
t = (0:length(SendSig1)-1)/Fs;
RecvSig1 = A1*exp(j*(2*pi*F1*t+P1)).*SendSig1; 


% ��ʱƫ
SendSig2 = [ zeros(1,T2) inputdata(1,1:end-T2) ];

% ��Ƶƫ����ƫ�ͷ��ȱ仯
t = (0:length(SendSig2)-1)/Fs;
RecvSig2 = A2*exp(j*(2*pi*F2*t+P2)).*SendSig2; 

mutirecsig = RecvSig2+RecvSig1;

out = awgn(mutirecsig, SNR, 'measured');%�Ӹ�˹������

end