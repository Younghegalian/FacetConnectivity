function centroid = Clouding(stlcoords,overh_ang,Patch_area,Sat)


    for i = 1:length(overh_ang)
        if overh_ang(i,1) >= Sat
            ovh(i,1) = 180;
        else
            ovh(i,1) = overh_ang(i,1);
        end
 ce(i,1) = mean( stlcoords(i,1,:) );
 ce(i,2) = mean( stlcoords(i,2,:) );
 ce(i,3) = mean( stlcoords(i,3,:) );
 ce(i,4) = ovh(i,1);
 ce(i,5) = Patch_area(i,1);
%  ce(i,6) = Seg_idx(i,1);
    end
% ce = [mean( stlcoords(:,1,:) ), mean( stlcoords(:,2,:) ), mean( stlcoords(:,3,:) ), overh_ang(:,1), Patch_area(:,1)];
centroid = ce;

x = ce(:,1);
y = ce(:,2);
z = ce(:,3);
ov = ce(:,4);

% figure('Color',[1 1 1])
% scatter3(x,y,z,10,ov,'filled')    % draw the scatter plot
% 
% axis equal tight
% view(-45,45)
% grid on
% 
% xlabel('X-Direction')
% ylabel('Y-Direction')
% zlabel('Z-Direction')
% caxis([0 40]);
% 
% cb = colorbar; % create and label the colorbar
% colormap (flipud(jet));
% cb.Label.String = 'Overhang angle';

end
