function tbsize = calc_tbsize(module_type,prb_num)
% ����prb_numΪ100����50��module_typeΪQPSK��16QAM��64QAM��256QAM4�����������8�����

switch module_type
    case 1
        if prb_num==50
            tbsize = 8456; %���ݹ�ʽ����õ�
        else
            tbsize = 16896; %���ݹ�ʽ����õ�
        end
    case 2
        if prb_num==50
            tbsize = 10504; %���ݹ�ʽ����õ�
        else
            tbsize = 21000; %���ݹ�ʽ����õ�
        end
    case 3
        if prb_num==50
            tbsize = 19464; %���ݹ�ʽ����õ�
        else
            tbsize = 38936; %���ݹ�ʽ����õ�
        end
    case 4
        if prb_num==50
            tbsize = 37896; %���ݹ�ʽ����õ�
        else
            tbsize = 75792; %���ݹ�ʽ����õ�
        end
    case 5
        disp('module type is worng' );
end
end