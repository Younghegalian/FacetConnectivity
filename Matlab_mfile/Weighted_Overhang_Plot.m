function [hpat, OVHA] = Weighted_Overhang_Plot(stlcoords,overh_ang, N_weight, Sat)

list_size = length(N_weight);
OVHA = zeros(list_size,1);

for i = 1 : list_size
    
    if N_weight(i,1) ~= 0
        
        OVHA(i,1) = N_weight(i,1);
        
    else
        
        OVHA(i,1) = overh_ang(i,1);
        
    end
    
end


% AMAP = min(0.5,(abs(OVHA-Sat)/Sat)+0.5);
AMAP = max(0.2,abs(OVHA-max(OVHA))/max(OVHA));


figure4 = figure('Color',[1 1 1],'units', 'normalized', 'pos',[0.5 0.04 0.4 0.4]);
axes4 = axes('Parent',figure4);
set(axes4,'FontSize',12,'FontWeight','bold');


xco = squeeze( stlcoords(:,1,:) )';
yco = squeeze( stlcoords(:,2,:) )';
zco = squeeze( stlcoords(:,3,:) )';

[hpat] = patch(xco,yco,zco,OVHA,'EdgeColor','none','FaceAlpha','flat','FaceVertexAlphaData',AMAP);
%     [hpat] = patch(xco,yco,zco,OVHA,'EdgeColor','none');
% [hpat] = patch(xco,yco,zco,overh_ang,'FaceColor','flat');
% [hpat] = patch(xco,yco,zco,overh_ang,'FaceColor','interp');

colormap (flipud(jet(18)));

% colorbar('FontSize',25,'location','west')
caxis([min(OVHA) Sat]);
cb = colorbar('location','east'); % create and label the colorbar
cb.Label.String = 'Overhang angle(Degree)';

axis equal tight

view(-45,45)
grid on



title('Weighted surface normal angle(Overhang angle)');
xlabel('X-direction (mm)');
ylabel('Y-direction (mm)');
zlabel('Build direction (mm)');



end % function