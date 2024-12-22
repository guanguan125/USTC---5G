function [] = NR_ReSourceData(tb_data,imagrxpath)
tbsize = length(tb_data);
tb_width = 300;%����ԴͼƬ����ͬ���
tb_height = 0;%����ԴͼƬ����tbsize��С�ò�ͬ�ĸ߶�
switch tbsize
    case 8456 % 300*28 = 8400     
        tb_height = 28;
    case 16896 % 300*56 = 16800   
        tb_height = 56;
    case 10504 % 300*35 = 10500    
        tb_height = 35;
    case 21000 % 300*70 = 21000     
        tb_height = 70;
    case 19464 % 300*64 = 19200   
        tb_height = 64;
    case 38936 % 300*129 =38700   
        tb_height = 129;
    case 37896 % 300*126 =37800      
        tb_height = 126;
    case 75792 % 300*250 =75000
        tb_height = 250;
    otherwise
        disp('error tbsize' );
end

img_data_len = tb_width * tb_height; %ͼƬ���ݳ���

% ='C:\Users\ES-SW\Desktop\5Gphysicallayerlink\01 TeacherVersion\MatlabCode\rx_img.bmp'
tb_data = tb_data(1,1:img_data_len); %��ȡͼƬ����
rx_img_data = (reshape(tb_data,tb_width,tb_height))';%��������תΪ��������
imwrite(rx_img_data,imagrxpath,'bmp');%д��ͼƬ

end

