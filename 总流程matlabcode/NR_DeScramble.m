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

function [descrambledata] = DeScramble_5G(demoddata,vrb_num,qm,ue_index,cellid)
totallen = vrb_num * 12 * 12 * qm;%����������ĳ���
cinit = ue_index * ( 2 ^ 15 ) + cellid;
NC = 1600;
setlen= NC +totallen - 31;%����Ҫ���ɵ�x1x2���ȣ����󳤶�+��ǿ����Ա���-���г��ȣ�


x1 = zeros( 1, 31 );
x1( 1 ) = 1;

for ( i = 1:31 )
    x2( i ) = mod( cinit, 2 );
    cinit = floor( cinit / 2 );
end 

for ( i = 1:setlen )
    x1( i + 31 ) = xor( x1( i + 3 ), x1( i ) );
    x2( i + 31 ) =xor(xor(x2(i+3),x2(i+2)),xor(x2(i+1),x2(i)));
end 
for ( i = 1:totallen )
    
    scrambit( i ) = xor(x1( i + NC ) , x2( i + NC ));%��벿��
    
end 

for ( i = 1:totallen )
    descrambledata( i ) = xor( scrambit(i ), demoddata( i) );%b+c��mod2
end
end
