function out = NR_REMap( precodedata,rsdata,prb_num,Frist_DMRS_L0,Second_DMRS_L,DMRS_symbol,Nsym_slot,Nu )
%% 
start=1;
datasymbol = 0;
carry_len = prb_num*12;
outdata = zeros(Nsym_slot,1200);

if(2 ==DMRS_symbol)
  %����2����Ƶ���ŵ�λ�ã���L0+L'�����ã�
  rsl1 = Frist_DMRS_L0 +0;
  rsl2 = Second_DMRS_L+1;
  
  %matlabû�з���0
  rs_station0 = rsl1+1
  rs_station1 = rsl2+1
else
  rsl1 = Frist_DMRS_L0 +0;
   %matlabû�з���0
  rs_station0 = rsl1+1;
  rs_station1 = 20;  %һ��slot�ķ��Ų��ᳬ��20����������Դ����
end

 for(iii=1:Nsym_slot)  %ÿ�����ŷֱ���
     if(iii == rs_station0)  %��һ����Ƶ����ӳ��
         outdata(iii,1:carry_len) = rsdata(1,:);
        continue; 
     end
     if(iii == rs_station1)  %�ڶ�����Ƶ����ӳ��
         outdata(iii,1:carry_len) = rsdata(2,:);
        continue; 
     end
     datasymbol = datasymbol+1;
      tail = start+carry_len-1;
      outdata(iii,start:tail) = precodedata(carry_len*(datasymbol-1)+1:carry_len*datasymbol);
%       start = tail+1; 
     
 end

remapdata =  outdata;
 
 %% 
 nfft = Nu;
half = prb_num*12/2;
total = prb_num*12;

out = zeros(Nsym_slot,Nu);

for iii=1:Nsym_slot
    %�˿�0������iii
    tmp1 = remapdata(iii,(half+1):total);
    tmpdata=[tmp1,zeros(1,(nfft-total)),remapdata(iii,1:half)];

     out(iii,1:nfft)=tmpdata;
end

end

