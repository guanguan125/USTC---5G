%% ����
%% �������š�����鼶��
function rm_data = NR_DeScramble(demoddata,vrb_num,qm,ue_index,cellid,C,rm_len)
%% ����
% descrambledata  = DeScramble_5G(demoddata,prb_num,Qm,ue_index,cellid);
% ���������  
% rm_data������鼶������������  
% ���������  
% demoddata���������������  
% vrb_num��UE��RB���� 
% Qm�����Ʒ�ʽ��2��QPSK  4:16QAM  6:64QAM  8:256QAM 
% ue_index��UE������ 
% cellid��С��ID 
% C �������ָ������� 
% rm_len������ƥ���ĳ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% student code %%%%%%%%%%%%%%%%%%%%%%%%%%
out = DeScramble_5G(demoddata,vrb_num,qm,ue_index,cellid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ����鼶��
E = rm_len;
descrambledata = out;
% deccbc_data = DeCdblkConcate_5G(C,descrambledata,rm_len);
rm_data = zeros(C,E(C));
temp = 1;
for r = 1:C
    rm_data(r,1:E(r))= descrambledata(temp:(temp + E(r) - 1));
    temp = temp + E(r);
end
end