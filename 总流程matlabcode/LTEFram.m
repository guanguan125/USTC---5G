function output = LTEFram(input,timestart)

pos = 6737;  %��һ����Ƶ���ŵ�λ�ã�160+2048*3+144*3+1=6737��
if (timestart <=pos)  % ˵���������ӳ��ˣ���Ҫ���ƶ�
    leftpos = pos - timestart;
    output = [input(1,(30720-leftpos+1):30720),input(1,1:(30720-leftpos))];   
else  %˵����������ǰ�ˣ���Ҫ���ƶ�
    rightpos = timestart - pos;
    output = [input(1,rightpos+1:30720),input(1,1:rightpos)];
end

end