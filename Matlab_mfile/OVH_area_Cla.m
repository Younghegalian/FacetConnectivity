function [RES] = OVH_area_Cla(AREA_IDX,OVHA_IDX,SAT_ANG)
% ------------------------------------------------------------------------
% �Ӱ� ������ ������ �ʰ��ϴ� ������ Facets�� ��ü ���̸� ��ȯ�մϴ�.
% ------------------------------------------------------------------------
% [INPUT]
% AERA_IDX : Facet area ����, READstl�� ���� ȹ���� stlnormal ���Ϳ� ũ�Ⱑ �����մϴ�. 
% OVHA_IDX : ��� stlnormal�� ���� ���� surface normal angle ���� �Դϴ�.
% SAT_ANG : �Ӱ� ������ ���� �Դϴ�.(sat_angle)
% ------------------------------------------------------------------------
% [OUTPUT]
% RES : ��
% ========================================================================
sum_area_tmp = 0;

for i=1:length(AREA_IDX)
    
    if(OVHA_IDX(i) < SAT_ANG)
        sum_area_tmp = sum_area_tmp + AREA_IDX(i);
    end
    
end

RES = sum_area_tmp;

end

