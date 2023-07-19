function Patch_Contact_list = Contact_Patch_OVH(stlcoords)

% ex) vertices = stlcoords2
% use) Patch_Contact_list = Contact_Patch(stlcoords2)
%%

P1 = stlcoords(:,:,1);
P2 = stlcoords(:,:,2);
P3 = stlcoords(:,:,3);

size = length(stlcoords);
Patch_Contact_list = zeros(size,4); %메모리 공간 할당

loop = 1;

waitbar_h = waitbar(0,'Process . . . ');

for i = 1:size
    %%
    TargetP = P1;
    A = find( P1(:,1)==TargetP(i,1) & P1(:,2)==TargetP(i,2) & P1(:,3)==TargetP(i,3) );
    B = find( P2(:,1)==TargetP(i,1) & P2(:,2)==TargetP(i,2) & P2(:,3)==TargetP(i,3) );
    C = find( P3(:,1)==TargetP(i,1) & P3(:,2)==TargetP(i,2) & P3(:,3)==TargetP(i,3) );
    
    index_patch1 = vertcat(A,B,C); %행렬 합치기 // 한 점에서 연결된 patch index
    % index_patch1 = sort(index_patch1);
    % sort(index_patch) %꼭 필요하지는 않음 // 오름 차순 정렬
    
    %%
    TargetP = P2;
    A = find( P1(:,1)==TargetP(i,1) & P1(:,2)==TargetP(i,2) & P1(:,3)==TargetP(i,3) );
    B = find( P2(:,1)==TargetP(i,1) & P2(:,2)==TargetP(i,2) & P2(:,3)==TargetP(i,3) );
    C = find( P3(:,1)==TargetP(i,1) & P3(:,2)==TargetP(i,2) & P3(:,3)==TargetP(i,3) );
    
    index_patch2 = vertcat(A,B,C);
    % index_patch2 = sort(index_patch2);
    
    %%
    TargetP = P3;
    A = find( P1(:,1)==TargetP(i,1) & P1(:,2)==TargetP(i,2) & P1(:,3)==TargetP(i,3) );
    B = find( P2(:,1)==TargetP(i,1) & P2(:,2)==TargetP(i,2) & P2(:,3)==TargetP(i,3) );
    C = find( P3(:,1)==TargetP(i,1) & P3(:,2)==TargetP(i,2) & P3(:,3)==TargetP(i,3) );
    
    index_patch3 = vertcat(A,B,C);
    
    %%
    INT1 = intersect(index_patch1,index_patch2); %교집합으로 중복점 2개 추출
    INT2 = intersect(index_patch2,index_patch3);
    INT3 = intersect(index_patch3,index_patch1);
    
    DIF1 = setdiff(INT1,i); %차집합으로 탐색하는 i제거하고 하나의 값 저장
    DIF2 = setdiff(INT2,i);
    DIF3 = setdiff(INT3,i);
    
    Patch_Contact_list(loop,:) = [i,DIF1, DIF2, DIF3];
    
    
    if rem(loop,10) == 0
        %         X = ['Contact Processing ',num2str(100*loop/size),' %'];
        %         disp(X);
        waitbar(loop/size, waitbar_h)
    end
    
    
    loop = loop+1;

end

close(waitbar_h);
clearvars waitbar_h;

end %end fucn.