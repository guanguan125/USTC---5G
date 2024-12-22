function [tb_data,crc_flag] = NR_DeCRC( decodeout,C,F) 

Info_len = length(decodeout(1,:)); 

temp_len = 1;
 for r = 1:C     
     %%�ӿ�CRCУ��
     if(C>1)
        check_out(1,r) = CRC_check(decodeout(r,1:Info_len-F),2);
        %ȥ�ӿ�CRC �����ָ�
        sub_cw = decodeout(r,1:(length(decodeout)-F-24));
        temp_tb_data(1,temp_len:(temp_len + length(sub_cw) - 1)) = sub_cw;
        temp_len = temp_len + length(sub_cw);
     else
         temp_tb_data = decodeout(1:Info_len-F);
     end
 end
 
 %%�����CRCУ��
 crc_flag = CRC_check(temp_tb_data,1);

 %ȥ�����CRC
 tb_data = temp_tb_data(1,1:(length(temp_tb_data)-24));

end

