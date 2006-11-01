distance_map = [1 1
                1 2
                2 4
                3 5
                2 0.5
                3 3
                4 1
                5 3
                3 6
                4 7
                6 7
                7 6 
                5 5
                5 4
                6 2
                7 1];
for i=1:16
    temp(i,1:8)=dec2bin(distance_map(i,1),8);
    temp(i,9:16)=dec2bin(distance_map(i,2),8);
end