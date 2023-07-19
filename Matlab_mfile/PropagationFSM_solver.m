function [S, result] = PropagationFSM_solver(EdgeLength, Overhang_list1, Characters, alpha, Patch_area, Patch_Contact_list, Sat_angle, beta)


List_size = length(Overhang_list1);
iter = zeros(List_size, 3);
ini = zeros(List_size,1);

% tic

aa = min(Characters(:, 3));

Overhang_list = Overhang_list1;

for i = 1:List_size
    
    if abs(Characters(i,3) - aa) < 0.1
    Overhang_list(i) = 100;
    end

end

%% initialization


for i = 1:List_size

    P = zeros(3,1);

    for j = 1:3

        if Overhang_list(i) <= Sat_angle && Overhang_list(Patch_Contact_list(i,j+1)) > Sat_angle && Characters(i,3) - 0.01  >= Characters(Patch_Contact_list(i,j+1),3)

            P(j) =  alpha * EdgeLength(i,j+1) * (1 + ((Overhang_list(i,1)* beta) / 45)); % angle interactive propagation

        else

            P(j) = 0;

        end

    end

    ini(i) = Patch_area(i) - sum(P);

    if Overhang_list(i) >= Sat_angle

        iter(i,3) = 1;

    else

        iter(i,3) = 0;

    end

end

iter(:,1) = ini';

% disp('Progressive search algorithm initialized')
% toc

n = 1;

% tic

tol = 3;

result = Patch_area;

%% propagation

while 1

    initial = iter;
    step1 = zeros(List_size, 3);
    step2 = zeros(List_size, 3);
    alert = zeros(List_size, 1);
    temp = zeros(List_size, 3);

    %% propagation of delta

    for i = 1 : List_size


        if iter(i,3) == 0 && iter(i,1) < Patch_area(i,1)

            iter(i,3) = n;

        end

        for j = 1 : 3
                
            if iter(i,1) < 0 && Characters(i,3) <= Characters(Patch_Contact_list(i,j+1),3) && Overhang_list(Patch_Contact_list(i,j+1),1) < Sat_angle && iter(i,3) < iter(Patch_Contact_list(i,j+1),3) 
                
                temp(i,j) = iter(i,1); % propagation nonzero in process
                iter(i,2) = iter(i,2) + 1;
                
            elseif iter(i,1) < 0 && Characters(i,3) <= Characters(Patch_Contact_list(i,j+1),3) && Overhang_list(Patch_Contact_list(i,j+1),1) < Sat_angle && iter(Patch_Contact_list(i,j+1),3) == 0
                
                temp(i,j) = iter(i,1); % propagation nonzero in initial
                iter(i,2) = iter(i,2) + 1;
                
            elseif iter(i,1) < 0 && Overhang_list(Patch_Contact_list(i,j+1),1) < Sat_angle && Characters(i,3) <= Characters(Patch_Contact_list(i,j+1),3)
                
                temp(i,j) = 0; % zero transfer in virtual issues
                iter(i,2) = iter(i,2) + 1;
                
            elseif iter(i,1) < 0
                
                temp(i,j) = 0; % zero transfer in physical issues
                iter(i,2) = iter(i,2) + 1;
                alert(i,1) = alert(i,1) + 1;

            else

                temp(i,j) = 0;

            end

            step1(i,j) = temp(i,j) * EdgeLength(i,j+1);

        end

        %% delta

        for k = 1:3

            if sum(step1(i,:)) == 0

                step2(i,k) = 0;

            else

                step2(i,k) = iter(i,1) * (step1(i,k)/sum(step1(i,:))) * (1 - (((Overhang_list(i,1) - Overhang_list(Patch_Contact_list(i,k+1),1)) * beta) / 45)) ; % angle interactive propagation

            end

        end


        %% invalidate phi after transfer delta

        if iter(i,2) == tol && sum(step2(i,:)) ~= 0 % invalidation/transferred

            result(i,1) = iter(i,1);
            iter(i,1) = 0;
            iter(i,2) = 0;

        elseif iter(i,2) == tol && sum(step2(i,:)) == 0 && alert(i,1) <= 2 % redemption/isolated

            iter(i,3) = 1;
            iter(i,2) = 0;
            alert(i,1) = 0;

        elseif iter(i,2) == tol && sum(step2(i,:)) == 0  % invalidation/elemination

            result(i,1) = iter(i,1);
            iter(i,1) = 0;
            iter(i,2) = 0;

        end

    end

    %% delta accumulation/phi

    for ii = 1 : List_size

        for k = 1 : 3

            iter(Patch_Contact_list(ii,k+1),1) = iter(Patch_Contact_list(ii,k+1),1) + step2(ii,k);

        end


    end


    %% exit solver

    n = n+1;

    if initial(:,1) == iter(:,1)

        break
   
    end


end

% X = ['Progressive search algorithm converged in ',num2str(n),' iterations.'];
% disp(X)
% 
% toc

%% result

for i = 1 : List_size

    if iter(i,1) == 0

        result(i,1) = result(i,1);

    elseif iter(i,1) < Patch_area(i,1)

        result(i,1) = iter(i,1);

    end

end

%% smoothing
% tic
n2 = 1;

while 1

    ini = result;

    for i = 1 : List_size


        if result(i,1) < Patch_area(i) && length(find(result(Patch_Contact_list(i,2:4),1)/Patch_area(Patch_Contact_list(i,2:4) == 1) & Overhang_list(Patch_Contact_list(i,2:4),1) < Sat_angle )) >= 2

            result(i,1) = Patch_area(i); % Effected to none


        elseif result(i,1) > 0 && length(find(result(Patch_Contact_list(i,2:4),1) < 0)) > 1 

            al = NaN(3,1);

            for j = 1 : 3

                if result(Patch_Contact_list(i,j+1),1) < 0

                    al(j,1) = result(Patch_Contact_list(i,j+1),1)/Patch_area(Patch_Contact_list(i,j+1),1);

                end

            end

            result(i,1) = mean(al,'omitnan') * Patch_area(i,1); % None to effected

        end

    end

    n2 = n2 + 1;

    if ini == result

        break

    elseif n2 >= 30
        
        break
        
    end

end

% X = ['Smoothing completed in ',num2str(n2),' iterations.'];
% disp(X)
% toc
%% indexing

N = zeros(List_size,1);
S = zeros(List_size,1);


for i = 1 : List_size

    N(i,1) = result(i,1)/Patch_area(i,1);

    if N(i,1) < 0

        S(i,1) =  Sat_angle; %(abs(N(i,1))/max(abs(N)) + 1) * (Sat_angle)

    elseif N(i,1) > 0 && N(i,1) ~= 1

        S(i,1) = Sat_angle; %(1 - N(i,1)) * (Sat_angle)

    else

        S(i,1) = 0;

    end


end

end % function