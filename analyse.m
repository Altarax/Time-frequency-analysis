% ========================================================================== %
% ================== Fonction analyse fréquence-temps ====================== %
% ========================================================================== %

% OBJECTIF 
% A partir d'un signal d'entrée, créer son analyse fréquence-temps et
% l'afficher.

% INPUTS
% t         :  Vecteur temps du signal
% Signal    :  Signal à analyser
% Fe        :  Fréquence d'échantillonnage
% W_s       :  Incrément de la fenêtre en pourcentage du signal
% W_l       :  Taille de la fenêtre en pourcentage du signal

% OUTPUTS
% Plots     : des fenêtres de hamming décâlées et de l'analyse du signal

% CALLED FUNCTION

% TO-DO

function analyse(t, Signal, Fe, W_l, W_s)
   
  % Taille du signal
  N = length(Signal);
  
  figure('name', 'Signal initial', 'NumberTitle','off');
  plot(t, Signal);
  axis([0 t(end)]);
  title("Signal initial");
  xlabel("Temps (s)");
  ylabel("Y(x)");
    
  % Création du vecteur de fréquence
  df = 1/(t(end)-t(1));
  f = -Fe/2:df:-Fe/2+(N-1)*df;
  
  % ==============================================
  % ===== Algorithme analyse temps-fréquence =====
  % ==============================================
  
  % Taille de la fenêtre
  Nh = round(W_l*N/100);
  
  % Création fenêtre de hamming et un vecteur de 0
  ham = hamming(Nh);  
  ham = [ham;zeros(N-Nh,1)];     
  ham = ham.';                     
  z = zeros(1, N);
  
  % Trouver l'indice au point max de ham (à utiliser dans la boucle)
  max_ham = find(ham == max(ham));
    
  % Les variables to
  to_min = floor(Nh/2)+1;
  to_max = N-floor(Nh/2)-1;
  to_step = round(W_s*N/100);
   
  % Boucle pour créer le nouveau signal
  figure('name', 'Fenêtres de hamming', 'NumberTitle','off');
  title("Fenêtre de Hamming décalées");
  xlabel("Temps (s)");
  ylabel("Fenêtres");
  
  % Création de la barre de loading et de sa variable de comptage
  load_bar = waitbar(0,'Please wait...');
  total_steps = to_max;
  
  inc = 1;
  hold on;
  for to = to_min:to_step:to_max
    
    ham_shifted = [z(1:to-max_ham+1) ham];
    ham_shifted(end-to+max_ham:end) = [];
    
    plot(ham_shifted, "linewidth", 2);
       
    S(1:length(ham_shifted), inc) = abs(fftshift(fft(ham_shifted.*Signal))).^2;
    
    % Incrémentations
    waitbar(to/total_steps);
    inc++;
        
  endfor
    
  % Fermer la barre de load
  close(load_bar);

  % Afficher l'analyse temps-fréquence             
  figure(1);
  imagesc(t, f, S); 
  colorbar;
    
  axis([0 t(end) 0 f(end)]);
  title("Evolution de la fréquence par rapport au temps");
  xlabel("Temps (s)");
  ylabel("Fréquence (Hz)");
  set(gca, 'Ydir', 'normal');
      
endfunction;