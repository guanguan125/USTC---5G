clc
clear

TransformPrcode_en = 1; %1:ʹ�ܴ���Ԥ���� 0����ʹ�ܴ���Ԥ����
nslotnum = 2; %������֡ʱ϶��
cellid = 0;
beltaDMRS = 1; %DMRS�Ĺ�������
UL_DMRS_Config_type =1; %DMRS���������ͣ��߲��ָʾ������DMRS��ʹ��
Frist_DMRS_L0 = 3; %Type A��ӳ�䷽ʽ��L0ֵ��
Second_DMRS_L = 10;%Type A��ӳ�䷽ʽ�����ݱ�6.4.1.1.3-4���õ��ڶ������ŵ�l'
prb_num = 100;      %RB����,��ѡ50��100
EN_CHES =1;         %�ŵ����ƿ��أ�1:on ,0��off 
DMRS_symbol =2; %����ο��źŵķ��Ÿ���
Nsym_slot =14;% ÿ��slotռ�õ�symbol��
 
load deremapdata.mat   %�����׼��������
load equdata.mat % �����׼������ݡ� �ŵ����ƺ����ݡ�

[outdata,slotlschanneldata] = NR_LSChannel( deremapdata,TransformPrcode_en,cellid,nslotnum,beltaDMRS,UL_DMRS_Config_type,Frist_DMRS_L0,Second_DMRS_L,prb_num,EN_CHES,DMRS_symbol,Nsym_slot);

errnum = sum(sum(equdata-outdata))%�Ƚϱ�׼�����ʵ�ʳ��������errnumΪ0������д��ȷ����������д���
