function [OV,OVT] = Face_OverhangAngle(stlnormal,Sat)
Z = [0 0 -1];

OVHA_list = zeros(length(stlnormal),1);

for i = 1:length(stlnormal)
    OV(i,:) = (acos( dot(Z,stlnormal(i,:)) / (norm(Z)*norm(stlnormal(i,:))) ) * 180/pi);
    
    if  (acos( dot(Z,stlnormal(i,:)) / (norm(Z)*norm(stlnormal(i,:))) ) * 180/pi) >= Sat %Saturation angle
        OVT(i,:) = 1;
    elseif (acos( dot(Z,stlnormal(i,:)) / (norm(Z)*norm(stlnormal(i,:))) ) * 180/pi) < Sat
        OVT(i,:) = 0;
    end
end
end

