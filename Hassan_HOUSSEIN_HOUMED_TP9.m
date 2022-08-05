clear ; 
close all;
phi = @(x) 0.333*x.^3 + x - (2.5);
x_I= fsolve(phi,1);
y_I = -2*x_I + 3/2;
figure(2) ;
   hold on;
%isoclines
x = linspace(-10,10)
plot(x, (x.^3)./3 - x - 1, 'r',x, -2.*x + 3/2, 'r');

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

    mu = 10;
    %mu = 30;

function Yp = f1(t,Y)
   
   Yp = zeros(size(Y));
   Yp(1) = Y(2) - (1/3)*Y(1).^3 + Y(1) - 1;
   Yp(2) = -Y(1) - 0.5* Y(2) + 0.75;
endfunction



  % les constantes 
  h=0.01
  t0 = 0; 
  T = 60;
  %T = 100;
  N = floor((T-t0)/h); t = linspace(t0,T,N+1);

  Y1 = heun([0;2],h,t,@f1);
  
   figure(1) ;
   hold on;
   
    % le champ des directions
    y = -5 : 0.1 : 5 ; 
    [ x1, y1] = meshgrid(y,y) ;
    U = y1 - (x1.^3)./3 + x1 - 1;
    V = -x1 -(0.5).*y1 + 0.75 ;
    quiver(x1,y1,U,V,0.5)
    %isoclines
    x = linspace(0,5)
    plot( 0.466221, 0.567559, 'r*' )           % equilibre
    plot(Y1(1,:),Y1(2,:))
    plot(Y1(1,1),Y1(2,1), 'sr')
   
    %Schema 1D
    figure(3)
    tt = linspace(0,T,size(Y1,2));
    hold on;
    plot(tt,[Y1(1,:) ; Y1(1,:)])