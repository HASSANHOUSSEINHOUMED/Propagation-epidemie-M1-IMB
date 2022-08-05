clear ; 
close all;

%fonction schema de Heun
function [v] = heun(v0,h,t,f)
 v = [ v0 ];
 for tn = t(1:(end-1))
  vn = v( :, end);
  vtilde = vn +h*f(tn,vn);
  v = [ v , vn+h*(f(tn,vn) + f(tn+h, vtilde))/2 ];
 end
endfunction

%Systeme (*)



function Yp = f1(t,Y)
   a = 0.5;
   b = 1;
   Yp = zeros(size(Y));
   Yp(1) = -Y(1)+ a*Y(2) + Y(1).^2*Y(2);
   Yp(2) = b - a*Y(2) - Y(1).^2*Y(2);
endfunction



  % les constantes 
  b = 0.5;
  a = 0.1;
  h=0.01
  t0 = 0; 
  T = 100;
  N = floor((T-t0)/h); t = linspace(t0,T,N+1);

  Y1 = heun([b;b/a],h,t,@f1);
  
   figure(1) ;
   hold on;
   
    % le champ des directions
    y = -10 : 0.1 : 10 ; 
    [ x1, y1] = meshgrid(y,y) ;
    U = -x1+ a*y1 + x1.^2*y1;
    V = b - a*y1 - x1.^2*y1;
    quiver(x1,y1,U,V,0.5)
    %trapeze
    line([0 0], [0 b/a], "linewidth", 1, "color", "b")
    line([b+b/a 0],[0 0], "linewidth", 1, "color", "b")
    line([b+b/a b], [0 b/a], "linewidth", 1, "color", "b")
    line([0 b], [b/a b/a], "linewidth", 1, "color", "b")
    
    plot( b, b/a-b^2, 'r*' )           % equilibre
    plot(Y1(1,:),Y1(2,:))
    plot(Y1(1,1),Y1(2,1), 'sr')
   
    %Schema 1D
    figure(2)
    tt = linspace(0,T,size(Y1,2));
    hold on;
    plot(tt,[Y1(1,:) ; Y1(1,:)])