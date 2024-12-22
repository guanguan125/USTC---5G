clc;
clear;

%% ʵ�����
%ϵͳ����
module_type = 4;    %���Ʒ�ʽ��1: QPSK; 2:16QAM; 3:64QAM 4:256QAM
prb_num = 100;      %RB����,��ѡ50��100
%ϵͳ����
EN_LDPC=1;          %LDPC���أ�1:on ,0��off
EN_INTERWEAVER=1;   %��֯���أ�1:on, 0��off
EN_CP = 1;          %CP���أ�1:on ,0��off
EN_CHES =0;         %�ŵ����ƿ��أ�1:on ,0��off 

%�ŵ�����
EN_NOISE =0; %1:�������  0�����������

SNR =10;      %����ȣ�dB��,���뷶Χ0~40
EN_BUTSRINTER =0; %ͻ�����ſ��أ�1:on, 0��off
lenburstinter = 800 ; %ͻ�����ŵ�ʱ�򳤶ȣ����뷶Χ500~1000
EN_FREOFFSET = 0 ;   %Ƶƫ���أ�1:on ,0��off
freoffset = 120;    %Ƶƫ��Hz��,���뷶Χ50~150
EN_TIMEOFFSET = 0;  %�ŵ��շ�ʱ�ӿ��أ�1:on�� 0��off
timeoffset =15000;    %�ŵ��շ�ʱ���ӳٲ�����,���뷶Χ0~15360

EN_TIMEOFFSETCP = 0 ;  %CP�ྶʱ��ʱ�ӿ��أ�1:on�� 0��off
timeoffsetCP =140 ;    %CP�ྶʱ���ӳٲ�����,���뷶Χ100~200

%�ྶ���ò���
EN_Mutipath = 0; %1:ʹ�ܶ��� 0����ʹ�ܶ���
mutitimeoffset =[10,140]; %��1���͵�2��ʱ���ӳٲ�����
mutiamp = [1,0.5];  %��1���͵�2���ķ���
mutifreoffset = [20,140];%��1���͵�2��Ƶƫ
mutiphaseoffset = [0,pi/3];%��1���͵�2����ƫ


atte_factor = 1;    %˥�����ӣ�1~1000

rfflag = 0;         %1:����Զ��  0��������� ��ע���������ʵ�鲻��ʾ�˲���

%% Ӳ������
% rfflag=1������Զ��ʱ���²�������ʾ
antnum =1;      %����������Ŀ 1�������߽���  2:2���߽���
txantnum =1;    %����������Ŀ 1�������߷��� 2:2���߷���
recant = 0;     %�����߽��գ�0������0���� 1������1����
txindex = 0;    %�����߷��䣬0������0���� 1������1����

pcip = '192.168.1.180';
xsrpip = '192.168.1.166';

%% Ĭ�ϲ���
Imcs = 20; %20  %���ݴ�ֵ��38.214 ��5.1.3.1-2
MCS_Table_PDSCH = 1; %1:֧��256QAM 0����֧��256QAM
DMRS_symbol =2; %����ο��źŵķ��Ÿ���
Frist_DMRS_L0 = 3; %Type A��ӳ�䷽ʽ��L0ֵ��
Second_DMRS_L = 10;%Type A��ӳ�䷽ʽ�����ݱ�6.4.1.1.3-4���õ��ڶ������ŵ�l'
vnum =1;  %��ĸ���
rvid = 0; %����汾��
I_LBRM =0; %���ڼ���Ncb��ֵ
i_ls =1; %���ڼ���LDPC���ƶ���С����38.212 ��5.3.2-1
LDPC_base_graph =1; %1:ѡ��LDPC_base_graph1 2��LDPC_base_graph2
Nsym_slot =14;% ÿ��slotռ�õ�symbol��
TransformPrcode_en = 1; %1:ʹ�ܴ���Ԥ���� 0����ʹ�ܴ���Ԥ����
CodebookTransform_en = 0; %1:ʹ���뱾����  0����ʹ���뱾����
TPMIindex = 0; %Ԥ�������ָʾ
Antportnum =1; %���߶˿�����

nslotnum = 2; %������֡ʱ϶��
beltaDMRS = 1; %DMRS�Ĺ�������
UL_DMRS_Config_type =1; %DMRS���������ͣ��߲��ָʾ������DMRS��ʹ��
Nu=2048; %ÿ�����ŵĲ�������

rbstart = 0;
Qm = module_type*2;
ue_index = 10;
cellid = 0;

imagestxpath='tx_img.bmp';
imagrxpath='rx_img.bmp';

%����RB�����͵��Ʒ�ʽȷ��tbsize
tbsize = calc_tbsize(module_type,prb_num);

%% ��Դ
info_data = NR_SourceData(tbsize,imagestxpath);

%% CRC���
[p,C,Zc,K,K_p,cdblkseg_data,F] = NR_crc24a(info_data,LDPC_base_graph,i_ls);

%% LDPC����
[coded_data,H] = NR_LDPC_Encode_opt(cdblkseg_data,LDPC_base_graph,C,EN_LDPC);

% ����LTE_NULL��λ��
null_pos = find(coded_data==2);

%% ����ƥ�䡿
[rm_data,rm_len] = NR_RateMatch(coded_data,I_LBRM,vnum,Qm,C,Nsym_slot,DMRS_symbol,prb_num,rvid,LDPC_base_graph,Zc);

%% ��֯
iw_data = NR_Interweave(rm_data,rm_len,Qm,C,EN_INTERWEAVER);

%% ����
save('iw_data.mat')
scramble_data = NR_Scramble(C,iw_data,rm_len,prb_num,Qm,ue_index,cellid);
save('scramble_data.mat');

%% ����ӳ��
mod_data = NR_Mod(scramble_data,prb_num,module_type);
size(mod_data)
%% Ԥ����
precodedata = NR_Precode(mod_data, vnum,TransformPrcode_en,Nsym_slot,DMRS_symbol,prb_num, CodebookTransform_en, TPMIindex,Antportnum);
yubian = size(precodedata)
%% ������Ƶ����
rsdata = NR_RS_Gen(TransformPrcode_en,cellid,nslotnum,beltaDMRS,UL_DMRS_Config_type,Frist_DMRS_L0,Second_DMRS_L,prb_num);
save('rsdata.mat');
%% ��Դӳ�䣬����һ���н���˳��Ĳ���
save('precodedata.mat');

fredata = NR_REMap( precodedata,rsdata,prb_num,Frist_DMRS_L0,Second_DMRS_L,DMRS_symbol,Nsym_slot,Nu );
ziyuan = size(fredata)
save('fredata.mat');

%% OFDM����,��IFFT
[txdata,input] = NR_GenTimeData( fredata,Nsym_slot,Nu,EN_CP);
OFDM=size(txdata)
%% �ŵ����������
rxdata = NR_Channel(txdata,SNR,rfflag,EN_NOISE,EN_BUTSRINTER,EN_FREOFFSET,EN_TIMEOFFSET,EN_Mutipath,mutitimeoffset,mutifreoffset,mutiamp,mutiphaseoffset,lenburstinter,freoffset,timeoffset,recant,txantnum,txindex,atte_factor,pcip,xsrpip);

rxdata_I = real(rxdata);

rxdata_Freq =abs(fftshift(fft(rxdata))) ;
fs = 30720000 ;
N  = 30720 ;
freqPixel=fs/N ; %Ƶ�ʷֱ��ʣ��������֮��Ƶ�ʵ�λ
w=(-N/2:1:N/2-1)*freqPixel ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
% %% ͬ��
UL_subframe_num=nslotnum;
[rxmodify,timestart,corrdata] =synchronization( rxdata,prb_num,rbstart,UL_subframe_num,cellid);

% 
rxdata=rxmodify;
timestart

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% OFDM���
defredata = NR_DeFreData( rxdata,Nsym_slot,Nu,EN_TIMEOFFSETCP,timeoffsetCP);

%% ����Դӳ��
deremapdata = NR_DeRemap(defredata,Nsym_slot,Nu,prb_num);

%% �ŵ����������
[equdata,slotlschanneldata]= NR_LSChannel( deremapdata,TransformPrcode_en,cellid,nslotnum,beltaDMRS,UL_DMRS_Config_type,Frist_DMRS_L0,Second_DMRS_L,prb_num,EN_CHES,DMRS_symbol,Nsym_slot);

%% ��Ԥ����
delayermapdata = NR_DePrecode( CodebookTransform_en, TPMIindex,equdata,Antportnum,TransformPrcode_en,Nsym_slot,DMRS_symbol,prb_num,vnum);

%% �����ӳ��
demoddata = NR_Demod(delayermapdata,Qm);

%% ����
save('demoddata.mat');
deccbc_data = NR_DeScramble(demoddata,prb_num,Qm,ue_index,cellid,C,rm_len);
save('deccbc_data.mat');

%% �⽻֯
deiwdata = NR_DeInterWeave(deccbc_data,rm_len,Qm,C,EN_INTERWEAVER);

%% ������ƥ��
dermdata = NR_DeRateMatch(deiwdata,vnum,Qm,C,Nsym_slot,DMRS_symbol,prb_num,rvid,LDPC_base_graph,Zc,null_pos,coded_data,EN_LDPC);

%% LDPC����
deldpccode = NR_LDPC_Decode_opti(dermdata,C,Zc,EN_LDPC,cdblkseg_data,LDPC_base_graph);

%% CRCУ��
[tbdata ,crcflag] = NR_DeCRC(deldpccode,C,F);
crcflag
%% ����
NR_ReSourceData(tbdata,imagrxpath);  

%���ֽ��ֵ����
coded_data = 1-2*coded_data;
errnum_ldpc = sum(sum(xor(dermdata,coded_data)));%��������LDPC��������ݺ�LDPC����ǰ���ݱȽϣ�
errnum_moddemod = sum(xor(scramble_data,demoddata));%������������ӳ���������ݺͽ����ӳ��������ݱȽϣ�
errnum = sum(xor(info_data,tbdata));% ����������Դ���غ����ޱ��رȽϣ�
subcarr_num = 12*prb_num;

delayermapdata_I = real(delayermapdata);
delayermapdata_Q = imag(delayermapdata);
%% ʵ����
% 1���ŵ����������ظ�����
tbsize
% 2�����ز�����
subcarr_num
% 3������ͼƬ
% 4������ӳ�������ͼ
figure(101)
plot(mod_data,'*')
% 5�������ŵ�������źŲ���
figure(201)
plot(rxdata_I);

figure(301)
plot(corrdata);
% 6�������ŵ�������ź�Ƶ��
figure(401)
plot(w,rxdata_Freq)
% 7�������ӳ�������ͼ
figure(501)
plot(delayermapdata_I,delayermapdata_Q,'*')
% 8����������LDPC��������ݺ�LDPC����ǰ���ݱȽϣ�
 errnum_moddemod 
errnum_ldpc
% 9������������Դ���غ����ޱ��رȽϣ�
errnum
% 10������ͼƬ



