function [RES] = OVH_area_Cla(AREA_IDX,OVHA_IDX,SAT_ANG)
% ------------------------------------------------------------------------
% 임계 오버행 각도를 초과하는 영역의 Facets의 전체 넓이를 반환합니다.
% ------------------------------------------------------------------------
% [INPUT]
% AERA_IDX : Facet area 벡터, READstl로 부터 획득한 stlnormal 벡터와 크기가 동일합니다. 
% OVHA_IDX : 모든 stlnormal로 부터 계산된 surface normal angle 벡터 입니다.
% SAT_ANG : 임계 오버행 각도 입니다.(sat_angle)
% ------------------------------------------------------------------------
% [OUTPUT]
% RES : 임
% ========================================================================
sum_area_tmp = 0;

for i=1:length(AREA_IDX)
    
    if(OVHA_IDX(i) < SAT_ANG)
        sum_area_tmp = sum_area_tmp + AREA_IDX(i);
    end
    
end

RES = sum_area_tmp;

end

