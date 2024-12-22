function outdemod = NR_Demod(moddata,qm)
d0 = 1/sqrt(2);   %QPSK�Ĺ�һ������
d1 = 1/sqrt(10);  %16QAM�Ĺ�һ������
d2 = 1/sqrt(42);  %64QAM�Ĺ�һ������
d3 = 1/sqrt(170); %256QAM�Ĺ�һ������
[row,colo] = size(moddata);
start =1;
for(jjj =1:row)
    tail =start+colo-1;
    moddatatmp(start:tail) = moddata(jjj,:);
    start = tail+1;
end
realdata = real(moddatatmp);  % I·
imagedata = imag(moddatatmp); % Q·
len = length(moddatatmp);
switch qm
    case 2    %QPSK Ӳ���
        for(iii=1:len)
            if(realdata(iii)>0)
                outdemod(2*(iii-1)+1) = 0;
            else
                outdemod(2*(iii-1)+1) = 1;
            end
            if(imagedata(iii)>0)
                outdemod(2*(iii-1)+2) = 0;
            else
                outdemod(2*(iii-1)+2) = 1;
            end
        end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% student code %%%%%%%%%%%%%%%%%%%%%%%%%%
    case 4   %16QAM Ӳ���
            for(iii=1:len)
                tmpdata1 = 2*d1 - abs(realdata(iii)); 
                tmpdata2 = 2*d1 - abs(imagedata(iii));
            if(realdata(iii)>0)
                outdemod(4*(iii-1)+1) = 0;
            else
                outdemod(4*(iii-1)+1) = 1;
            end
            if(imagedata(iii)>0)
                outdemod(4*(iii-1)+2) = 0;
            else
                outdemod(4*(iii-1)+2) = 1;
            end
            if(tmpdata1>0)
                outdemod(4*(iii-1)+3) = 0;
            else
                outdemod(4*(iii-1)+3) = 1;
            end
            if(tmpdata2>0)
                outdemod(4*(iii-1)+4) = 0;
            else
                outdemod(4*(iii-1)+4) = 1;
            end
        end
        
    case 6  %64QAM Ӳ���
          for(iii=1:len)
             tmpdata1 = 4*d2 - abs(realdata(iii)); 
             tmpdata2 = 4*d2 - abs(imagedata(iii));
             tmpdata3 = 2*d2 -abs(tmpdata1);
             tmpdata4 = 2*d2 -abs(tmpdata2);
            if(realdata(iii)>0)
                outdemod(6*(iii-1)+1) = 0;
            else
                outdemod(6*(iii-1)+1) = 1;
            end
            if(imagedata(iii)>0)
                outdemod(6*(iii-1)+2) = 0;
            else
                outdemod(6*(iii-1)+2) = 1;
            end
            if(tmpdata1>0)
                outdemod(6*(iii-1)+3) = 0;
            else
                outdemod(6*(iii-1)+3) = 1;
            end
            if(tmpdata2>0)
                outdemod(6*(iii-1)+4) = 0;
            else
                outdemod(6*(iii-1)+4) = 1;
            end
            if(tmpdata3>0)
                outdemod(6*(iii-1)+5) = 0;
            else
                outdemod(6*(iii-1)+5) = 1;
            end
            if(tmpdata4>0)
                outdemod(6*(iii-1)+6) = 0;
            else
                outdemod(6*(iii-1)+6) = 1;
            end
        end      
         
    case 8  %256QAM Ӳ���
       for(iii=1:len)
             tmpdata1 = 8*d3 - abs(realdata(iii)); 
             tmpdata2 = 8*d3 - abs(imagedata(iii));
             tmpdata3 = 4*d3 -abs(tmpdata1);
             tmpdata4 = 4*d3 -abs(tmpdata2);
             tmpdata5 = 2*d3 -abs(tmpdata3);
             tmpdata6 = 2*d3 -abs(tmpdata4);
            if(realdata(iii)>0)
                outdemod(8*(iii-1)+1) = 0;
            else
                outdemod(8*(iii-1)+1) = 1;
            end
            if(imagedata(iii)>0)
                outdemod(8*(iii-1)+2) = 0;
            else
                outdemod(8*(iii-1)+2) = 1;
            end
            if(tmpdata1>0)
                outdemod(8*(iii-1)+3) = 0;
            else
                outdemod(8*(iii-1)+3) = 1;
            end
            if(tmpdata2>0)
                outdemod(8*(iii-1)+4) = 0;
            else
                outdemod(8*(iii-1)+4) = 1;
            end
            if(tmpdata3>0)
                outdemod(8*(iii-1)+5) = 0;
            else
                outdemod(8*(iii-1)+5) = 1;
            end
            if(tmpdata4>0)
                outdemod(8*(iii-1)+6) = 0;
            else
                outdemod(8*(iii-1)+6) = 1;
            end
            if(tmpdata5>0)
                outdemod(8*(iii-1)+7) = 0;
            else
                outdemod(8*(iii-1)+7) = 1;
            end
            if(tmpdata6>0)
                outdemod(8*(iii-1)+8) = 0;
            else
                outdemod(8*(iii-1)+8) = 1;
            end
        end      
end
 
 
 
 
 
 
 
 
 
 
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
