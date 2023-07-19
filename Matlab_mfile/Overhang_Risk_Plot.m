function [hpat,cmap] = Overhang_Risk_Plot(stlcoords,overh_ang)

idx_size = length(overh_ang);

figure3 = figure('Color',[1 1 1],'units', 'normalized', 'pos',[0.1 0.04 0.4 0.4]);
% pos : [left, bottom, width, height]
axes3 = axes('Parent',figure3);
set(axes3,'FontSize',12,'FontWeight','bold');


xco = squeeze( stlcoords(:,1,:) )';
yco = squeeze( stlcoords(:,2,:) )';
zco = squeeze( stlcoords(:,3,:) )';

for i = 1:idx_size
    if overh_ang(i,1) > 0
        cmap(i,1) = 0.5;
    else
        cmap(i,1) = 1;
    end
end
% ,'FaceAlpha','flat','FaceVertexAlphaData',max(0.2,cmap)
[hpat] = patch(xco,yco,zco,overh_ang,'EdgeColor','none','Facealpha','flat','FaceVertexAlphaData',cmap,'AlphaDataMapping','none');

% [hpat] = patch(xco,yco,zco,overh_ang,'FaceColor','flat');
% [hpat] = patch(xco,yco,zco,overh_ang,'FaceColor','interp');

colormap (flipud(cool(2)));

cb = colorbar('location','southoutside','Ticks',[0,1],'TickLabels',{'Risk','Safe'},'location','east'); % create and label the colorbar
cb.Label.String = 'Risk Region';

axis equal tight

view(-45,45)
grid on

title('Build risk area');
xlabel('X-direction (mm)');
ylabel('Y-direction (mm)');
zlabel('Build direction (mm)');

end % function