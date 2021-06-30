% ========================================================================== %
% =================== Fonction cr�ant un signal chirp ====================== %
% ========================================================================== %

% OBJECTIF 
% A partir de donn�es d'entr�e, cr�er un signal "chirp"

% INPUTS
% Fs        :  Fr�quence d'�chantillonage
% L         :  Taille du vecteur temps
% Fo        :  Fr�quence du signal
% a         :  Amplitude du signal
% W_s       :  Incr�ment de la fen�tre en pourcentage du signal
% W_l       :  Taille de la fen�tre en pourcentage du signal

% OUTPUTS

% CALLED FUNCTION
% analyse : analyse fr�quence-temps du signal

function chirp(Fs, L, Fo, a, W_s, W_l)
    
  % Cr�ation du vecteur temps
  dt = 1/Fs;
  t = 0:dt:L;
  
  % Cr�ation du signal
  Chirp_Signal = exp(j*2*pi*(Fo*t+a*t.^2));
  
  % Colormap (pour des jolies couleurs)
  colormap("jet");
          
  % Analyse temps-fr�quence
  analyse(t, Chirp_Signal, Fs, W_s, W_l);
  
endfunction;