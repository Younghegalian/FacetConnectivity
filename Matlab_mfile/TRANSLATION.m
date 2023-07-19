function New_V = TRANSLATION(V)

Min_h = 0;

min_x =min(min( V(:,1,:) ) );
min_y =min(min( V(:,2,:) ) );
min_z =min(min( V(:,3,:) ) );

P = [-min_x, -min_y, -min_z + Min_h];

New_V = V + P;

end %fucntion