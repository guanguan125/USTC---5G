%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName:            DpskSysChannel.m
%  Description:         �ŵ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parameter List:       
%       Output Parameter
%           RecvSig         �����ź�
%           ChanParameter   �ŵ�����
%       Input Parameter
%           SendSig         �����ź�
%           Fs                  ������
%           Amax            ����źŷ���
%           Pmax            �����λƫ��
%           Fmax            ���Ƶƫ����λHz
%           Tmax            ���ʱƫ����λ��
%           SNR             �����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ RecvSig, ChannelParameter] = DpskSysChannel(SendSig,Fs,Amax,Pmax,Fmax,Tmax,SNR)



% �������
A = Amax;
% ������ƫ
P = Pmax;
% ����Ƶƫ
F = Fmax;
% ����ʱƫ
% T = floor(rand(1,1)*Tmax*Fs);
% T = floor(rand(1,1)*Tmax);
T = Tmax;

ChannelParameter = [ A P F T SNR];

% ��ʱƫ
SendSig = [ SendSig(1,1+end-T:end)   SendSig(1,1:end-T) ];
% zeros(1,T) SendSig(1,1:end-T)

% ��Ƶƫ����ƫ�ͷ��ȱ仯
t = (0:length(SendSig)-1)/Fs;
RecvSig = A*exp(j*(2*pi*F*t+P)).*SendSig; 

end
