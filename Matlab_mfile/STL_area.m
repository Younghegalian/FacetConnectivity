function [area] = STL_area(stlcoords)

cof = squeeze( stlcoords(:,:,1) );
cos = squeeze( stlcoords(:,:,2) );
cot = squeeze( stlcoords(:,:,3) );
xco = squeeze( stlcoords(:,1,:) )';
yco = squeeze( stlcoords(:,2,:) )';
zco = squeeze( stlcoords(:,3,:) )';
% [hpat] = patch(xco,yco,zco,'r','EdgeColor','none');

a = cos - cof;
b = cot - cof;
c = cross(a, b, 2);

%% Output
area = 1/2 * sqrt(sum(c.^2, 2));

%% plot
figure1 = figure('Color',[1 1 1],'units', 'normalized', 'pos',[0.1 0.5 0.4 0.4]);
axes1 = axes('Parent',figure1);
set(axes1,'FontSize',12,'FontWeight','bold');

% pos : [left, bottom, width, height]
[hpat] = patch(xco,yco,zco,area,'EdgeColor','none');
colormap (flipud(jet(18)));

cb = colorbar('location','east'); % create and label the colorbar
cb.Label.String = 'Facet area (mm^2)';

axis equal tight

view(-45,45)
grid on

title('Facet area');
xlabel('X-direction (mm)');
ylabel('Y-direction (mm)');
zlabel('Build direction (mm)');

end

