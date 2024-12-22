%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FileName:             de_CRC.m
%  Description:          CRCУ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parameter List:       
%       Output Parameter       
%           tb_data           ȥCRCУ���������
%           crc_flag           CRCУ����
%       Input Parameter
%           decodeout          �ŵ����������
%           C                    �����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  History
%    1. Date:          2010-06-20
%       Author:         zzk
%       Version:        1.0 
%       Modification:   ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tb_data,crc_flag] = de_CRC(decodeout,C)
temp_len = 1;
 for r = 1:C     
     %%�ӿ�CRCУ��
     if(C>1)
        check_out(1,r) = CRC_check(decodeout(r,:),2);
        %ȥ�ӿ�CRC �����ָ�
        sub_cw = decodeout(r,1:(length(decodeout)-24));
        temp_tb_data(1,temp_len:(temp_len + length(sub_cw) - 1)) = sub_cw;
        temp_len = temp_len + length(sub_cw);
     else
         temp_tb_data = decodeout;
     end
 end
 
 %%�����CRCУ��
 crc_flag = CRC_check(temp_tb_data,1);

 %ȥ�����CRC
 tb_data = temp_tb_data(1,1:(length(temp_tb_data)-24));