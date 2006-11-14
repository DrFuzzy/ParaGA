clear all;
[x_dec_trans,y_dec_trans] = meshgrid(-5.12:0.04:5.12);
for i=1:size(x_dec_trans,1)
    for j=1:size(y_dec_trans,1)

%% Michalewicz function        
%Z(i,j)=sin(x_dec_trans(i,j))*(sin((x_dec_trans(i,j)^2)/pi))^20 + sin(y_dec_trans(i,j))*(sin((2/pi)*y_dec_trans(i,j)^2))^20;
%% Easom function
%Z(i,j)=(cos(x_dec_trans(i,j)).*cos(y_dec_trans(i,j)))*exp(-((x_dec_trans(i,j)-3)^2+(y_dec_trans(i,j)-3)^2));
%% Griewangk Function
% Z(i,j)=(x_dec_trans(i,j)^2+y_dec_trans(i,j)^2)/4000 - cos(x_dec_trans(i,j))*cos(y_dec_trans(i,j)/sqrt(2))+1;
%% Rastrigin Function
 Z(i,j)=100 - (x_dec_trans(i,j)^2) -(y_dec_trans(i,j)^2) +10*cos(2*pi*x_dec_trans(i,j)) + 10*cos(2*pi*y_dec_trans(i,j));
    end
end
surfc(x_dec_trans, y_dec_trans,Z)
colormap jet
title('\fontsize{14}Rastrigin function F2');
xlabel('x1')
ylabel('x2')
zlabel('F2(x1,x2)')
%% Zhang Zhang functions
clear all
x_dec=0:0.001:1;
for i=1:size(x_dec,2)
Z(i) =abs((1-x_dec(i))*(x_dec(i)^2)*sin(200*pi*x_dec(i)));
Z(i)=((1 - 2*(sin(3*pi*x_dec(i)))^20 + (sin(20*pi*x_dec(i)))^20)^20)/10^6; % Without dividing with 10^6;
end
plot(x_dec,Z)
axis([0 1 0 1.1]);
title('Zhang Zhang function F1');
xlabel('x')
ylabel('F1(x)')