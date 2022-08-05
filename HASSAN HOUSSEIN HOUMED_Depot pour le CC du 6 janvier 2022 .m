1;


clear ; close all;
function [v] = euler_explicite(v0,h,t,f)
 v = [ v0 ];
 for tn = t(1:(end-1))
  vn = v( :, end);
  v = [ v , vn+h*f(tn, vn) ];
 end
endfunction


%% Le schéma de Heun utilise comme approximation du taux d’accroissement de Y
%% en (t_n,v_n) la moyenne de la méthode d'Euler donc approximation
%% de l'intégrale par methode rectangle à gauche, vtilde
%% avec une approximation de l'intégrale par methode rectangle à droite 
%% donc en t_{n+1}, comme on connait pas v_{n+1} on utilise vtilde.
%% C'est donc une moyenne de pentes qui améliore la qualité du schéma
%% qui devient plus précis.
   
function [v] = heun(v0,h,t,f)
 v = [ v0 ];
 for tn = t(1:(end-1))
  vn = v( :, end);
  vtilde = vn +h*f(tn,vn);
  v = [ v , vn+h*(f(tn,vn) + f(tn+h, vtilde))/2 ];
 end
endfunction


function Yp = f1(t,Y)
   Yp = zeros(size(Y));
   Yp(1) = - Y(2)- Y(1) *(Y(1)^2 + Y(2)^2);
   Yp(2) = Y(1)-Y(2)*(Y(1)^2 + Y(2)^2);
endfunction


% les constantes 
  Y0=[ 0.5; 0.5]
  %  Y0=[ 0.5; 8]
  h=0.01
  %h=0.1
  % h=0.001
  t0 = 0; T = 20.2;
  %T = 60.6;
 
  N = floor((T-t0)/h); t = linspace(t0,T,N+1);
  
  Ye = euler_explicite(Y0,h,t,@f1);
    figure(1) ;
    title("Schéma Euler explicite");
    M = max(Ye(:));                  % pour être sûr de tracer toute la solution
    axis([-M,M,-M,M],'square')
    hold on;
    plot(Ye(1,:),Ye(2,:))
    plot( 0, 0 , style= -3 )  % equilibre
    plot( Ye(1,1) , Ye(2,1), 'sr')     % (x0, y0)

    %% le champ des directions
    y = -M : 0.2 : M ;                % discrétisation axes 1D dans [-M, M]x[-M,M]
    [ yy1, yy2] = meshgrid(y,y) ;     % construction tableau abscisses yy1
    U = - yy2- yy1.*(yy1^2 + yy2^2); %% abscisse du vecteur tangent en (yy1() , yy2() )   
    V = yy1-yy2.*(yy1^2 + yy2^2); %% ordonnée du vecteur tangent
    N = sqrt( U.^2 + V.^2 ) ;
    U = U./N ;
    V = V./N;
    quiver(yy1,yy2,U,V,0.5)


    
  Yh = heun(Y0,h,t,@f1); 
   figure(2) ;
   title("Schéma de Heun");
   M = max(Yh(:));                   % pour être sûr de tracer toute la solution
   axis([-M,M,-M,M],'square')
   hold on;
   plot(Yh(1,:),Yh(2,:))
   plot( 0 , 0, style= -3 )        % equilibre
   plot( Yh(1,1) , Yh(2,1), 'sr')      % (x0, y0)
   quiver(yy1,yy2,U,V,0.5)

   
%% La méthode de Heun est d'ordre 2, la méthode d'Euler d'ordre 1.
%% Pour avoir la même précision dans les trajectoires avec la méthode d'Euler
%% il faut prendre h beaucoup plus petit 

 
