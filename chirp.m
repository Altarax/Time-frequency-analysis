% ========================================================================== %
% =================== Fonction créant un signal chirp ====================== %
% ========================================================================== %

% OBJECTIF 
% A partir de données d'entrée, créer un signal "chirp"

% INPUTS
% Fs        :  Fréquence d'échantillonage
% L         :  Taille du vecteur temps
% Fo        :  Fréquence du signal
% a         :  Amplitude du signal
% W_s       :  Incrément de la fenêtre en pourcentage du signal
% W_l       :  Taille de la fenêtre en pourcentage du signal

% OUTPUTS

% CALLED FUNCTION
% analyse : analyse fréquence-temps du signal

function chirp(Fs, L, Fo, a, W_s, W_l)
    
  % Création du vecteur temps
  dt = 1/Fs;
  t = 0:dt:L;
  
  % Création du signal
  Chirp_Signal = exp(j*2*pi*(Fo*t+a*t.^2));
  
  % Colormap (pour des jolies couleurs)
  colormap("jet");
          
  % Analyse temps-fréquence
  analyse(t, Chirp_Signal, Fs, W_s, W_l);
  
endfunction;