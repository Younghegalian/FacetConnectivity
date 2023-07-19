function [hpat,AMAP] = Overhang_PlotSTL(stlcoords,overh_ang,Sat)

AMAP = max(0.2,abs(overh_ang-max(overh_ang))/max(overh_ang));

figure2 = figure('Color',[1 1 1],'units', 'normalized', 'pos',[0.5 0.5 0.4 0.4]);
% pos : [left, bottom, width, height]
axes2 = axes('Parent',figure2);
set(axes2,'FontSize',12,'FontWeight','bold');

xco = squeeze( stlcoords(:,1,:) )';
yco = squeeze( stlcoords(:,2,:) )';
zco = squeeze( stlcoords(:,3,:) )';

[hpat] = patch(xco,yco,zco,overh_ang,'EdgeColor','none','FaceAlpha','flat','FaceVertexAlphaData',AMAP);
% [hpat] = patch(xco,yco,zco,overh_ang,'EdgeColor','none','FaceColor','cyan','FaceAlpha','flat','FaceVertexAlphaData',AMAP);

% [hpat] = patch(xco,yco,zco,overh_ang,'FaceColor','flat');
% [hpat] = patch(xco,yco,zco,overh_ang,'FaceColor','interp');

colormap (flipud(jet(18)));

% colorbar('FontSize',25,'location','west')
caxis([0 Sat]);
cb = colorbar('location','east'); % create and label the colorbar
cb.Label.String = 'Surface normal angle(Degree)';

axis equal tight


view(-45,45)
grid on

title('Surface nomal angle');
xlabel('X-direction (mm)');
ylabel('Y-direction (mm)');
zlabel('Build direction (mm)');

end % function
