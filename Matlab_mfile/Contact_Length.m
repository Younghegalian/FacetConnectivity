function EdgeLength = Contact_Length(stlcoords, Patch_Contact_list)

size = length(Patch_Contact_list);

L = zeros(size, 4);
L(:,1) = Patch_Contact_list(:,1);

for i = 1:size
    
    A = squeeze(stlcoords(i,:,:))';
    for j = 1:3
        B = squeeze(stlcoords(Patch_Contact_list(i,j+1),:,:))';
        G = intersect(A,B,'rows');
        L(i,1+j) = norm(G(1,:) - G(2,:));
    end
end


EdgeLength = L;

end