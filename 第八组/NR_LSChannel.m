
%% �����ŵ����ơ��ŵ�����
function [outdata,slotlschanneldata] = NR_LSChannel( deremapdata,TransformPrcode_en,cellid,nslotnum,beltaDMRS,UL_DMRS_Config_type,Frist_DMRS_L0,Second_DMRS_L,prb_num,EN_CHES,DMRS_symbol,Nsym_slot)

%% �ŵ�����
if(EN_CHES)
    %���㵼Ƶ����
   rsdata = NR_RS_Gen(TransformPrcode_en,cellid,nslotnum,beltaDMRS,UL_DMRS_Config_type,Frist_DMRS_L0,Second_DMRS_L,prb_num);
   scnum = 12*prb_num;

   %����2����Ƶ���ŵ�λ�ã���L0+L'�����ã�
   l1 = Frist_DMRS_L0 +0;
   l2 = Second_DMRS_L+1;

   %matlabû�з���0
   rs_station0 = l1+1;
   rs_station1 = l2+1;

   %��ȡ2����Ƶ��Ƶ������
   rs0fredata = deremapdata(rs_station0,1:scnum);
   rs1fredata = deremapdata(rs_station1,1:scnum);

   for(iii = 1:scnum)
      if(0 == rsdata(1,iii))   %������Ϊ0�����
          out(1,iii) = 1;
          out(2,iii) = 1;
      else
          out(1,iii) = rs0fredata(iii)/rsdata(1,iii);
          out(2,iii) = rs1fredata(iii)/rsdata(2,iii);
      end

   end
else
    scnum = 12*prb_num;
    out = ones(2,scnum);
end
slotlschanneldata = out;
%% �ŵ�����
start=1;
start1 =1;
datasymbol = 0;
carry_len = prb_num*12;
halfsymbol = Nsym_slot/2;
slotsymbol = Nsym_slot-DMRS_symbol;
% outdata = zeros(slotsymbol,1200);

tail1 = start1+carry_len-1;
if(2 ==DMRS_symbol)
  %����2����Ƶ���ŵ�λ�ã���L0+L'�����ã�
  rsl1 = Frist_DMRS_L0 +0;
  rsl2 = Second_DMRS_L+1;
  
  %matlabû�з���0
  rs_station0 = rsl1+1;
  rs_station1 = rsl2+1;
else
  rsl1 = Frist_DMRS_L0 +0;
   %matlabû�з���0
  rs_station0 = rsl1+1;
  rs_station1 = 20;  %һ��slot�ķ��Ų��ᳬ��20����������Դ����
end

 for(iii=1:halfsymbol)  %ǰ��һ����ŵĴ�����һ����Ƶ���ŵ��ŵ�����ֵ
     if(iii == rs_station0)  %��һ����Ƶ��������
        continue; 
     end
     datasymbol = datasymbol+1;
      tail = start+carry_len-1;
    outdata(start:tail) = deremapdata(iii,start1:tail1)./slotlschanneldata(1,start1:tail1); 
    start = tail+1;
 end
 
  for(iii=(halfsymbol+1):Nsym_slot)  %����һ����ŵĴ����ö�����Ƶ���ŵ��ŵ�����ֵ
     if(iii == rs_station1)  %�ڶ�����Ƶ��������
        continue; 
     end
     datasymbol = datasymbol+1;
      tail = start+carry_len-1;
%       outdata(datasymbol,start:tail) = deremapdata(iii,start1:tail1)./slotlschanneldata(2,start1:tail1); 
      outdata(start:tail) = deremapdata(iii,start1:tail1)./slotlschanneldata(2,start1:tail1);   
      start = tail+1;
 end

end
