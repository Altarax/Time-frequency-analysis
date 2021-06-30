% ========================================================================== %
% ========== Fonctions cr�ant un signal � partir d'un signal audio ========= %
% ========================================================================== %

% OBJECTIF 
% A partir d'un signal audio plus ou moins long, cr�er un autre signal
% plus petit pour faire l'analyse temps-fr�quence.

% INPUTS
% Premi�rement on utilise la fonctgion get_audio_signal pour r�cup�rer
% le signal contenu dans le fichier. Cette fonction va renvoyer � la fonction
% plot_new_signal, Fe et y. Ensuite, la fonction gui_menu cr�e simplement
% une IHM pour rentrer les valeurs des intervales ainsi que de la fen�tre,
% valeurs qui seront utilis�es en entr�es dans la fonction plot_new_signal.
% Cette derni�re appelle ensuite la fonction analyse qui est LA fonction
% principale avec en entr�es, le nouveau signal cr�e, son temps et les
% param�tres de la fen�tre.

% OUTPUTS
% plot    : graphiques de l'analyse temps-fr�quence, du nouveau signal et
%           des hammings.

% CALLED FUNCTION
% analyse : permet de faire l'analyse temps-fr�quence du nouveau signal

% TO-DO

1;

function [y, Fs] = get_audio_signal
   
  pkg load signal;
  [y, Fs] = audioread('signal_3octaves.wav');
  y = y(:,1);
        
endfunction;

% ========================================================================== %
% ============= Cr�ation des GUI d'affichage des courbes =================== %
% ========================================================================== %

function gui_menu 
  global dlg
  dlg = figure('name','Application', 'menubar','none', 'numbertitle','off');
  
  % Afficher la fen�tre au milieu de l'�cran
  screen_size = get(0,'screensize') ;               
  screen_center = screen_size(3:4)/2 ;              
  dialog_size = [1000 800] ;                        
  dialog_pos = screen_center - dialog_size/2 ;
  set(dlg, 'position',[dialog_pos dialog_size], 'color',[.96, .64, .38]);
  
  main;
  
endfunction;

function main
  global dlg;
  
  % Nettoyer la fen�tre
  clf(dlg);
  
  % Cr�er les panels et les zones de textes
  hp  = uipanel('title','Cr�er le nouveau signal', 'position',[.02 .034 .96 .94],
    'fontsize',16, 'backgroundcolor',[0.15, 0.27, 0.33], 'foregroundcolor', [.96, .64, .38], 'highlightcolor', [.96, .64, .38]);
  
  uicontrol('style','text', 'string', 'Intervale T1', 'units','normalized', 'position',[.15 .85 .16 .06], 'fontsize', 15, 'fontweight', 'bold', 'backgroundcolor', [0.16, 0.62, 0.56]);
  t1_min = uicontrol('style','edit', 'string','min', 'units','normalized', 'position',[.06 .78 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  t1_max = uicontrol('style','edit', 'string','max', 'units','normalized', 'position',[.24 .78 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);

  uicontrol('style','text', 'string', 'Intervale T2', 'units','normalized', 'position',[.69 .85 .16 .06], 'fontsize', 15, 'fontweight', 'bold', 'backgroundcolor', [0.16, 0.62, 0.56]);
  t2_min = uicontrol('style','edit', 'string','min', 'units','normalized', 'position',[.60 .78 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  t2_max = uicontrol('style','edit', 'string','max', 'units','normalized', 'position',[.78 .78 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  
  uicontrol('style','text', 'string', 'Intervale T3', 'units','normalized', 'position',[.15 .55 .16 .06], 'fontsize', 15, 'fontweight', 'bold', 'backgroundcolor', [0.16, 0.62, 0.56]);
  t3_min = uicontrol('style','edit', 'string','min', 'units','normalized', 'position',[.06 .48 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  t3_max = uicontrol('style','edit', 'string','max', 'units','normalized', 'position',[.24 .48 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);

  uicontrol('style','text', 'string', 'Intervale T4', 'units','normalized', 'position',[.69 .55 .16 .06], 'fontsize', 15, 'fontweight', 'bold', 'backgroundcolor', [0.16, 0.62, 0.56]);
  t4_min = uicontrol('style','edit', 'string','min', 'units','normalized', 'position',[.60 .48 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  t4_max = uicontrol('style','edit', 'string','max', 'units','normalized', 'position',[.78 .48 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  
  uicontrol('style','text', 'string', 'Taille de la fen�tre (%)', 'units','normalized', 'position',[.11 .3 .24 .06], 'fontsize', 15, 'fontweight', 'bold', 'backgroundcolor', [0.16, 0.62, 0.56]);
  W_l = uicontrol('style','edit', 'string','0', 'units','normalized', 'position',[.15 .23 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
  
  uicontrol('style','text', 'string', 'Incr�ment de la fen�tre (%)', 'units','normalized', 'position',[.63 .3 .28 .06], 'fontsize', 15, 'fontweight', 'bold', 'backgroundcolor', [0.16, 0.62, 0.56]);
  W_s = uicontrol('style','edit', 'string','0', 'units','normalized', 'position',[.69 .23 .16 .06], 'fontweight', 'bold', 'backgroundcolor', [0.91, 0.77, 0.42]);
    
  % Cr�er le boutton pour plot plus rapidement (param�tre du PDF)
  faster_plot_button = uicontrol ("style", "pushbutton",
                                  "units","normalized",
                                  "string","Analyse (param�tres rapides)",
                                  "position",[0.35 0.65 0.30 0.06],
                                  'fontsize',15, 'backgroundcolor',[0.91, 0.44, 0.32], 'fontweight','bold',
                                  'callback', {@plot_new_signal, 0.5, 0.51, 1.04, 1.08, 2.78, 2.8, 4.38, 4.42, 25, 5, 1});
  
  % Cr�er le boutton pour plot
  plot_button = uicontrol ("style", "pushbutton",
                                  "units","normalized",
                                  "string","Analyse",
                                  "position",[0.39 0.1 0.20 0.06],
                                  'fontsize',15, 'backgroundcolor',[0.91, 0.44, 0.32], 'fontweight','bold',
                                  'callback', {@plot_new_signal, t1_min, t1_max, t2_min, t2_max, t3_min, t3_max, t4_min, t4_max, W_l, W_s, 0});
  
endfunction;

function plot_new_signal(h, e, varargin)
  global dlg;
  
  % Permet d'avoir la diff�rence entre les param�tres directement rentr�s ou non
  mode = varargin{11}
  
  if mode == 0
    % R�cup�rer toutes les valeurs des intervales
    t1_min = str2num(get(varargin{1}, 'string'));
    t1_max = str2num(get(varargin{2}, 'string'));
    t2_min = str2num(get(varargin{3}, 'string'));
    t2_max = str2num(get(varargin{4}, 'string'));
    t3_min = str2num(get(varargin{5}, 'string'));
    t3_max = str2num(get(varargin{6}, 'string'));
    t4_min = str2num(get(varargin{7}, 'string'));
    t4_max = str2num(get(varargin{8}, 'string'));
    
    % R�cup�rer les valeurs des param�tres de la fen�tre
    W_l = str2num(get(varargin{9}, 'string'));
    W_s = str2num(get(varargin{10}, 'string'));
    
   else
    % R�cup�rer toutes les valeurs des intervales
    t1_min = varargin{1};
    t1_max = varargin{2};
    t2_min = varargin{3};
    t2_max = varargin{4};
    t3_min = varargin{5};
    t3_max = varargin{6};
    t4_min = varargin{7};
    t4_max = varargin{8};
    
    % R�cup�rer les valeurs des param�tres de la fen�tre
    W_l = varargin{9};
    W_s = varargin{10};
   endif
  
  % Clear la fen�tre
  clf(dlg); 
   
  % R�cup�rer le signal total du fichier 
  [y, Fe] = get_audio_signal;
  y = y.';
  
  % Cr�er son vecteur temps initial
  N = length(y);
  t = 0:1/Fe:(N-1)*1/Fe;
  
  % Trouver les index qui nous int�ressent
  t1 = find(t >= t1_min & t <= t1_max);
  t2 = find(t >= t2_min & t <= t2_max);
  t3 = find(t >= t3_min & t <= t3_max);
  t4 = find(t >= t4_min & t <= t4_max);

  indexes = [t1 t2 t3 t4];
  
  % Cr�er le nouveau signal
  new_y = y(indexes);
  
  % Cr�er le vecteur temps du nouveau signal
  N = length(new_y);
  new_t = 0:1/Fe:(N-1)*1/Fe;
     
  % Analyse temps fr�quence
  analyse(new_t, new_y, Fe, W_l, W_s);
  
endfunction;

gui_menu;