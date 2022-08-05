clear ; close all;   
function [v] = heun(v0,h,t,f)
 v = [ v0 ];
 for tn = t(1:(end-1))
  vn = v( :, end);
  vtilde = vn +h*f(tn,vn);
  v = [ v , vn+h*(f(tn,vn) + f(tn+h, vtilde))/2 ];
 end
endfunction

function [fig] = heun_interactive(h, T, f, xmin, xmax, ymin, ymax)
  
  
  fig = figure
  ax = axes("Units", "Normalized",...
            "Xlim",[xmin, xmax],...
            "Ylim", [ymin, ymax]);
       
    hold on 
    t0 = 0
    N = floor((T - t0)/h);
    t = linspace(t0, T, N+1);
    while(t == 1)
      [x0, y0, button] = ginput(1);
      if button == 3 break end; 
      if x0 >= xmin & x0 <= xmax & y0 >= ymin & y0 <= ymax 
        sol = heun ([x0;y0], h, t, f);
        plot(sol(1,:), sol(2,:), "b")
        sol = heun ([x0;y0], -h, -t, f);
        plot(sol(1,:), sol(2,:), "b")
      end
    end
  endfunction
  
  function Yp = f1(t,Y, K1, K2, alpha12, alpha21, r1, r2)
  
   Yp = zeros(size(Y));
   Yp(1) = r1*Y(1).*(1 - (Y(1) + alpha12*Y(2))/K1) -0.4 ;
   Yp(2) = r2*Y(2).*(1 - (alpha21*Y(1) + Y(2))/K2);
endfunction
  
  K1 = 3;
  K2 = 3;
  alpha12 = 0;
  alpha21 = 0;
  r1 = 1;
  r2 = 1;
 T = 100;
 h = 0.01;
 
 xmin = 0, xmax = 10, ymin = 0, ymax = 10
 
 fig = heun_interactive(h, T,@F, xmin, xmax, ymin, ymax);
title("Question 3")
 
 plot(0, 0, "*r")
 plot(K1, 0, "*r")
 plot(0, K2, "*r")
 
 A = [1 alpha12; alpha21 1]
 if abs(det(A)) > 0.000001
   X = inv(A)*[K1 ; K2 ]
 else
   X = [0 0]'
 end
 if ( X > [0 ; 0 ]) 
    plot(X(1), X(2), "*r")
  end;
   
if (alpha12 == 0 & alpha21 == 0)
  plot([0;K1], [K1;K2], "g")
  plot([K2; K1], [K2;0], "g")  
else
  plot([0;K1], [K1/alpha12;0], "g")
  plot([0; K2/alpha21], [K2;0], "g")  
 end 


function Y=F(X)

%% Paramètres du système
r= [1 0.72 1.53 1.27]';

A=[ 1 1.09 1.52 0 ; ...
    0 1 0.44 1.36 ; ...
    2.33 0 1 0.47; ...
    1.21 0.51 0.35 1];
Y = r.*X.*(1-A*X) ;
endfunction

%% traçons en 3D
function tracer(Y, titre)
	figure;
	title(titre);
	plot3(Y(1,:), Y(2,:), Y(3,:));
endfunction

function [Y] = heun(Y0, h, T, F)
  Y = Y0;
  N = floor(T/h);
  h2 = h/2;
  for n = 1:N
    y1 = Y(:,end);
    y2 = y1 + h*F(y1);
    Y = [Y y1 + h2*(F(y1)+F(y2))];
  end
endfunction

 
r= [1 0.72 1.53 1.27]';

A=[1 1.09 1.52 0 ; ...
0 1 0.44 1.36 ; ...
2.33 0 1 0.47; ...
1.21 0.51 0.35 1];

x_star = inv(A)*ones(4,1)

T = 1800
h = 0.15

Y0 = [0.1 0.3 0.5 0.7]'

Y = heun(Y0, h, T, @F);

size(Y)

tracer(Y, ["pas h=" num2str(h)])

figure

plot(Y')

legend("y1", "y2", "y3", "y4")


