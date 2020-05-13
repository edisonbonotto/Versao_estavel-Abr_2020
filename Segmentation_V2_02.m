% Versão: 2.02
% Em construção...
% 13/05/2020

clear           % limpa variáveis e funções da memória (RAM)
clc             % limpa a tela
close all;      % Fecha as janelas figuras abertas
load mtlb;

% Abre caixa de dialogo para escolher o arquivo
tipo='.tif';
[file,path] = uigetfile(tipo);
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end
nome_arq = fullfile(file);
nome_arq = erase(nome_arq,tipo);
arquivo = fullfile(path,file);

% Ler imagem
A = imread(arquivo);

% Transforma imagem em 256 tons de cinza
if (size(A,3) == 3)
    A = rgb2gray(A);
end

% Processando o histograma
figure(1), histogram(A,256);
[pixelCounts] = imhist (A);



% Teste de co-ocorrencia
[glcm, SI] = graycomatrix (A, 'NumLevels' , 256, 'GrayLimits' , [])
figure(40), imshow(glcm);
% Pause




% Subvetor (N_elementos,passo,inicial) (n_elmentos-inicial)
A_1 = max(pixelCounts(110:-1:85));
A_2 = max(pixelCounts(120:-1:110)); 
A_3 = max(pixelCounts(133:-1:120));
A_4 = max(pixelCounts(146:-1:133)); 

for x = 1: 256
    if pixelCounts(x) == A_1
        c1 = x;
        hold on
        plot(c1,A_1,'--*');
    end
    if pixelCounts(x) == A_2
        d1 = x;
        hold on
        plot(d1,A_2,'--*');
    end
    if pixelCounts(x) == A_3
        e1 = x;
        hold on
        plot(e1,A_3,'--*');
    end
    if pixelCounts(x) == A_4
        f1 = x;
        hold on
        plot(f1,A_4,'--*');
    end
end
fprintf('Picos do histrograma nas faixas: %d ,%d, %d e %d\n',c1,d1,e1,f1);

figure(2), imshow(A);

% Nomear imagens de saidas
% arquivo = fullfile(path,nome_arq);
arquivo = fullfile(path) + "resultados\";
% Verifica se existe  pasta resultados
if ~exist(arquivo, 'dir')
   mkdir(arquivo);
   convertStringsToChars( "Criou pasta "+ fullfile(path)+"resultados\")
end
arquivo = fullfile(path) + "resultados\" + fullfile(nome_arq);

arquivo_a = convertStringsToChars(arquivo + "-Seg_A" + tipo);
arquivo_b = convertStringsToChars(arquivo + "-Seg_B" + tipo);
arquivo_c = convertStringsToChars(arquivo + "-Seg_C" + tipo);
arquivo_d = convertStringsToChars(arquivo + "-Seg_D" + tipo);
arquivo_e = convertStringsToChars(arquivo + "-Seg_E" + tipo);
arquivo_f = convertStringsToChars(arquivo + "-Seg_F" + tipo);
arquivo_g = convertStringsToChars(arquivo + "-Seg_G" + tipo);

% Nomear as imagens do grafico da entropia (saidas)
arquivo_a_e = convertStringsToChars(arquivo + "-Seg_A-Entrop" + tipo);
arquivo_b_e = convertStringsToChars(arquivo + "-Seg_B-Entrop" + tipo);
arquivo_c_e = convertStringsToChars(arquivo + "-Seg_C-Entrop" + tipo);
arquivo_d_e = convertStringsToChars(arquivo + "-Seg_D-Entrop" + tipo);
arquivo_e_e = convertStringsToChars(arquivo + "-Seg_E-Entrop" + tipo);
arquivo_f_e = convertStringsToChars(arquivo + "-Seg_F-Entrop" + tipo);
arquivo_g_e = convertStringsToChars(arquivo + "-Seg_G-Entrop" + tipo);

% Nomear as imagens do grafico da entropia por quadrantes(saidas)
arquivo_a_e_q = convertStringsToChars(arquivo + "-Seg_A-Entrop_Q" + tipo);
arquivo_b_e_q = convertStringsToChars(arquivo + "-Seg_B-Entrop_Q" + tipo);
arquivo_c_e_q = convertStringsToChars(arquivo + "-Seg_C-Entrop_Q" + tipo);
arquivo_d_e_q = convertStringsToChars(arquivo + "-Seg_D-Entrop_Q" + tipo);
arquivo_e_e_q = convertStringsToChars(arquivo + "-Seg_E-Entrop_Q" + tipo);
arquivo_f_e_q = convertStringsToChars(arquivo + "-Seg_F-Entrop_Q" + tipo);
arquivo_g_e_q = convertStringsToChars(arquivo + "-Seg_G-Entrop_Q" + tipo);


% Inicializar matrizes
tamanho = size (A);
B = zeros(tamanho,'uint8');
C = zeros(tamanho,'uint8');
E = zeros(tamanho,'uint8');
F = zeros(tamanho,'uint8');
G = zeros(tamanho,'uint8');
D = zeros(tamanho,'uint8');

% Segmentação
% Valores originais: B=<=85; C=100~110; D=133~146; E=120~133; F=>170
aa = 0;
for x = 1: tamanho(1)
    for y = 1: tamanho(2)
        
        % Seleção B (Poros)
        % ok
        if A(x,y) <= c1-23
            B(x,y) = 255;
        end

        % Segmentação imagem C - > 108
        % ok
        if (A(x,y) > (c1-23)) && (A(x,y) <= (c1+5))
                C(x,y) = 255;
        end
        
               
        % Segmentação imagem D - > 116
        % ok
        if A(x,y) > (d1-3) && A(x,y) <= (d1+3)
            D(x,y) = 255;
        end
 
        % Segmentação imagem E - Centro 140
        % Testando        
        if A(x,y) > (e1-5) && A(x,y) <= (e1+5)
            E(x,y) = 255;
        end
        
        % Segmentação imagem F - Centro 126
        % ok
        if A(x,y) > (f1-6) && A(x,y) <= 190
            F(x,y) = 255;
        end
      
        
        % Segmentação imagem G - > 170
        % ok
        if A(x,y) > (190)
            G(x,y) = 255;
        end
        
    end
end

%figure(3), imshow(A);
%figure(1), imshow(B);
%figure(51), imshow(C);
%figure(6), imshow(D);
%figure(7), imshow(E);
%figure(1), imshow(G);

% Ajuste e gravação imagem B (Poros)
figure(4), imshow(B);
imwrite(B,arquivo_b);

% Ajuste e gravação imagem C
% se = strel('cube',6);
% C = imdilate(C,se);
% se = strel('cube',8);
% C = imerode (C,se);

se = strel('cube',2);
C = imdilate(C,se);
se = strel('cube',2);
C = imerode (C,se);
% Retira os poros e a imagem mais clara (Grande chance de estarem corretas)
for x = 1: tamanho(1)
    for y = 1: tamanho(2)
        if B(x,y) > 0 || G(x,y)
            C(x,y) = 0;
        end
    end
end
figure(5), imshow(C);
imwrite(C,arquivo_c);


% Ajuste imagem D
% Retira  a imagem C
for x = 1: tamanho(1)
    for y = 1: tamanho(2)
        if (C(x,y) > 0)
            D(x,y) = 0;
        end
    end
end
% se = strel('cube',6);
% D = imdilate(D,se);
% se = strel('cube',8);
% D = imerode (D,se);

se = strel('cube',2);
D = imdilate(D,se);
se = strel('cube',2);
D = imerode (D,se);
% Retira os poros e a imagem C
for x = 1: tamanho(1)
    for y = 1: tamanho(2)
        if (B(x,y) > 0) || (C(x,y) > 0)
            D(x,y) = 0;
        end
    end
end

figure(6), imshow(D);
imwrite(D,arquivo_d); 

% Ajuste imagem E
se = strel('cube',2);
E = imerode (E,se);
se = strel('cube',2);
E = imdilate(E,se);
figure(7), imshow(E);
imwrite(E,arquivo_e);     

% Ajuste imagem F
% ok
% se = strel('cube',2);
% F = imerode (F,se);
% se = strel('cube',3);
% F = imdilate(F,se);
se = strel('cube',2);
F = imerode (F,se);
se = strel('cube',2);
F = imdilate(F,se);
figure(8), imshow(F);
imwrite(F,arquivo_f);     

% Ajuste imagem F
se = strel('cube',2);
%F = imdilate(F,se);
se = strel('cube',3);
%F = imerode (F,se);
figure(9), imshow(G);
imwrite(G,arquivo_g); 

% Pause

% Chama função para calculo da entropia - Imagem B
entropia_b = Entropia_V1_00(arquivo_b);
% Mostra gráfico
figure(10); plot(entropia_b);

% Chama função para calculo das distancias eixos x e y - Imagem B
[distancia_x_b,distancia_y_b,distancia_med_x_b,distancia_med_y_b] = Distancia_V1_01(arquivo_b, tamanho);

% Grava no disco o gráfico
% saveas(gcf,arquivo_b_e)

% Chama função para calculo da entropia - Imagem C
entropia_c = Entropia_V1_00(arquivo_c);
% Mostra gráfico
figure(11); plot(entropia_c);
% Chama função para calculo das distancias eixos x e y - Imagem C
[distancia_x_c,distancia_y_c,distancia_med_x_c,distancia_med_y_c] = Distancia_V1_01(arquivo_c, tamanho);


% Grava no disco o gráfico
% saveas(gcf,arquivo_c_e)

% Chama função para calculo da entropia - Imagem D
entropia_d = Entropia_V1_00(arquivo_d);
% Mostra gráfico
figure(12); plot(entropia_d);

% Chama função para calculo das distancias eixos x e y - Imagem D
[distancia_x_d,distancia_y_d,distancia_med_x_d,distancia_med_y_d] = Distancia_V1_01(arquivo_d, tamanho);

% Grava no disco o gráfico
% saveas(gcf,arquivo_d_e)

% Chama função para calculo da entropia - Imagem E
entropia_e = Entropia_V1_00(arquivo_e);
% Mostra gráfico
figure(13); plot(entropia_e);
% Chama função para calculo das distancias eixos x e y - Imagem E
[distancia_x_e,distancia_y_e,distancia_med_x_e,distancia_med_y_e] = Distancia_V1_01(arquivo_e, tamanho);

% Grava no disco o gráfico
% saveas(gcf,arquivo_e_e)

% Chama função para calculo da entropia - Imagem F
entropia_f = Entropia_V1_00(arquivo_f);
% Mostra gráfico
figure(14); plot(entropia_f);
% Chama função para calculo das distancias eixos x e y - Imagem F
[distancia_x_f,distancia_y_f,distancia_med_x_f,distancia_med_y_f] = Distancia_V1_01(arquivo_f, tamanho);

% Grava no disco o gráfico
% saveas(gcf,arquivo_f_e)

% Chama função para calculo da entropia - Imagem G
entropia_g = Entropia_V1_00(arquivo_g);
% Mostra gráfico
figure(15); plot(entropia_g);
% Chama função para calculo das distancias eixos x e y - Imagem G
[distancia_x_g,distancia_y_g,distancia_med_x_g,distancia_med_y_g] = Distancia_V1_01(arquivo_g, tamanho);

% Grava no disco o gráfico
% saveas(gcf,arquivo_g_e)


% Chama função para calculo da entropia POR QUADRANTES- Imagem B
entropia_b_q = Entropia_quadrante_V1_00(arquivo_b, tamanho);
% Mostra gráfico
figure(16); plot(entropia_b_q);
% Ordena Entropia dos quadrantes e Mostra gráfico
entropia_b_q_o = sort(entropia_b_q);
figure(17); plot(entropia_b_q_o);



% Chama função calculo da equação da curva da entropia
% [x,t]=equacao_entropia(entropia_b_q_o)





% Grava no disco o gráfico
% saveas(gcf,arquivo_b_e_q)

% Chama função para calculo da entropia POR QUADRANTES- Imagem C
entropia_c_q = Entropia_quadrante_V1_00(arquivo_c, tamanho);
% Mostra gráfico
figure(18); plot(entropia_c_q);
% Ordena Entropia dos quadrantes e Mostra gráfico
entropia_c_q_o = sort(entropia_c_q);
figure(19); plot(entropia_c_q_o);
% Grava no disco o gráfico
% saveas(gcf,arquivo_c_e_q)

% Chama função para calculo da entropia POR QUADRANTES- Imagem D
entropia_d_q = Entropia_quadrante_V1_00(arquivo_d, tamanho);
% Mostra gráfico
figure(20); plot(entropia_d_q);
% Ordena Entropia dos quadrantes e Mostra gráfico
entropia_d_q_o = sort(entropia_d_q);
figure(21); plot(entropia_d_q_o);
% Grava no disco o gráfico
% saveas(gcf,arquivo_d_e_q)

% Chama função para calculo da entropia POR QUADRANTES- Imagem E
entropia_e_q = Entropia_quadrante_V1_00(arquivo_e, tamanho);
% Mostra gráfico
figure(22); plot(entropia_e_q);
% Ordena Entropia dos quadrantes e Mostra gráfico
entropia_e_q_o = sort(entropia_e_q);
figure(23); plot(entropia_e_q_o);
% Grava no disco o gráfico
% saveas(gcf,arquivo_e_e_q)

% Chama função para calculo da entropia POR QUADRANTES- Imagem F
entropia_f_q = Entropia_quadrante_V1_00(arquivo_f, tamanho);
% Mostra gráfico
figure(24); plot(entropia_f_q);
% Ordena Entropia dos quadrantes e Mostra gráfico
entropia_f_q_o = sort(entropia_f_q);
figure(25); plot(entropia_f_q_o);
% Grava no disco o gráfico
% saveas(gcf,arquivo_f_e_q)

% Chama função para calculo da entropia POR QUADRANTES- Imagem G
entropia_g_q = Entropia_quadrante_V1_00(arquivo_g, tamanho);
% Mostra gráfico
figure(26); plot(entropia_g_q);
% Ordena Entropia dos quadrantes e Mostra gráfico
entropia_g_q_o = sort(entropia_g_q);
figure(27); plot(entropia_g_q_o);
% Grava no disco o gráfico
% saveas(gcf,arquivo_g_e_q)

arquivo_save = convertStringsToChars(arquivo + ".mat");

% Salva variaveis
save(arquivo_save,'entropi*','distanci*','arquivo','arquivo_b','arquivo_c','arquivo_d','arquivo_e','arquivo_f','arquivo_g')

set(figure(1), 'Toolbar', 'none', 'Menu', 'none');
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);
arquivo_fig = convertStringsToChars(fullfile(path)+"resultados\" + nome_arq + "Histograma" + tipo);
saveas(gcf,arquivo_fig);
set(frame_h,'Maximized',1);
