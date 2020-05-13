clear           % limpa variáveis e funções da memória (RAM)
clc             % limpa a tela
close all;      % Fecha as janelas figuras abertas

legenda(1) = [""];
legenda(2) = [""];
legenda(3) = [""];
legenda(4) = [""];
legenda(5) = [""];
legenda(6) = [""];
legenda(7) = [""];
% cor = ['rbkgcmy'];
% linha = ['.'];

% Abre caixa de dialogo para escolher o numero de arquivos a serem lidos
Nr_imagens = inputdlg('Gerar relatório de quantas imagens?');
Nr_imagens = str2double(Nr_imagens);

% Abre caixa de dialogo para escolher o arquivo
for i = 1 : Nr_imagens
    tipo='.tif';
    [file,path] = uigetfile(tipo);
    if isequal(file,0)
        disp('User selected Cancel');
    else
        disp(['User selected ', fullfile(path,file)]);
    end
    nome_arq = fullfile(file);
    nome_arq = erase(nome_arq,tipo);
%    arquivo = fullfile(path,nome_arq);
    arquivo = fullfile(path) + "resultados\" + fullfile(nome_arq);

    arquivo_save = convertStringsToChars(arquivo + ".mat");
    load(arquivo_save);
    

    
    % Legenda
    legenda(i) = convertCharsToStrings(nome_arq);
    % Mostra figuras e desenha o gráfico de entropia da imagem
    arquivo = fullfile(path,file);
    
    % Junta Imagens
    A = imread(arquivo);
    tamanho = size (A);
    espaco = 5;

     if i == 1
         img_grande = zeros((tamanho(1)*Nr_imagens + espaco*Nr_imagens),(tamanho(2)*7 + espaco*7),'uint8');
         img_grande(:) = 255;
     end
    
    % Imagem original
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2))+espaco)-tamanho(2))) = A(x,y);
        end
    end

    % Segmento B
    A = imread(arquivo_b);
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2)*2)+espaco*2)-tamanho(2))) = A(x,y);
        end
    end
    
    % Segmento C
    A = imread(arquivo_c);
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2)*3)+espaco*3)-tamanho(2))) = A(x,y);
        end
    end    

    % Segmento D
    A = imread(arquivo_d);
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2)*4)+espaco*4)-tamanho(2))) = A(x,y);
        end
    end    
    
    % Segmento E
    A = imread(arquivo_e);
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2)*5)+espaco*5)-tamanho(2))) = A(x,y);
        end
    end    
    
    % Segmento F
    A = imread(arquivo_f);
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2)*6)+espaco*6)-tamanho(2))) = A(x,y);
        end
    end    
    
    % Segmento G
    A = imread(arquivo_g);
    for x = 1 : tamanho(1)
    	for y = 1 : tamanho(2)
            img_grande(((x+(tamanho(1)*i)+espaco*i)-tamanho(1)),((y+(tamanho(2)*7)+espaco*7)-tamanho(2))) = A(x,y);
        end
%          
    end    
    figure(7),
    imshow(img_grande);


   
    for b = 1 : 6
        figure(b);
        if b == 1
            figure(b+10);
            distancia_m = zeros(1,tamanho(1),'uint8');
            distancia_n = zeros(1,tamanho(1),'uint8');
            for t = 2 : tamanho(1)
                distancia_n(t) = distancia_x_b(t);
                distancia_m(t) = distancia_y_b(t);
            end
            hold on;
            plot(distancia_n,distancia_m,'.');

            xlabel('Eixo x', 'Color', 'b')
            ylabel('Eixo Y', 'Color', 'b')
            title('Distância - Segmento B', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5));
            grid on
            
            figure(b);
            subplot(4,1,1)
             hold on
             plot (entropia_b_q );
             xlabel('Quadrantes', 'Color', 'b')
             ylabel('Entropia', 'Color', 'b')
             title('Entropia por Quadrante - Segmento B', 'Color', 'r')
             %legend('Por Quadrante','Ordenado pela Entropia')
             grid on
            
            subplot(4,1,2)
            if i > 1
                hold on
            end
            plot (entropia_b_q_o );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia Ordenada Crescentemente - Segmento B', 'Color', 'r')
            grid on
            
            subplot(4,1,3); 
            if i > 1
                hold on
            end
            semilogy(distancia_x_b );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo x', 'Color', 'r');

            subplot(4,1,4); 
            if i > 1
                hold on
            end
            semilogy(distancia_y_b );    
            xlabel('Distância', 'Color', 'b')
            ylabel('Quantidade', 'Color', 'b')
            title('Distancia dos pixels no eixo y', 'Color', 'r')
            
            %Calcula X0
            for k = 1 : length(entropia_b_q_o)
                if entropia_b_q_o(k) > 0
                    resultados(i,b,1) = k;
                    break
                end
            end
            % Calculo de X0-Xf
            % resultados(2,i) = entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i));
            % resultados(3,i) = (entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i)))/entropia_b_q_o(resultados(1,i));
            resultados(i,b,2) = length(entropia_b_q_o)-resultados(i,b,1);
            resultados(i,b,3) = (length(entropia_b_q_o)-resultados(i,b,1))/resultados(i,b,1);
            resultados(i,b,4) = 0;
            for k = 1 : length(entropia_b_q_o)
                for l = 0: 0.01  : entropia_b_q_o(k)
                    resultados(i,b,4) = resultados(i,b,4)+1;
                end
            end
            distancia_med(i,b,1) = distancia_med_x_b;
            distancia_med(i,b,2) = distancia_med_y_b;
            

        elseif b == 2
            figure(b+10);
            distancia_m = zeros(1,tamanho(1),'uint8');
            distancia_n = zeros(1,tamanho(1),'uint8');
            for t = 2 : tamanho(1)
                distancia_n(t) = distancia_x_c(t);
                distancia_m(t) = distancia_y_c(t);
            end
            hold on
            plot(distancia_n,distancia_m,'.')

            xlabel('Eixo x', 'Color', 'b')
            ylabel('Eixo Y', 'Color', 'b')
            title('Distância - Segmento C', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5));
            grid on
            
            figure(b);
            subplot(4,1,1)
            if i > 1
                hold on
            end
            plot (entropia_c_q );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia por Quadrante - Segmento C', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5))
            grid on
            
            subplot(4,1,2)
            if i > 1
                hold on
            end
            plot (entropia_c_q_o );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia Ordenada Crescentemente - Segmento C', 'Color', 'r')
            grid on
                        
            subplot(4,1,3); 
            if i > 1
                hold on
            end
            semilogy(distancia_x_c );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo x', 'Color', 'r');

            subplot(4,1,4); 
            if i > 1
                hold on
            end
            semilogy(distancia_y_c );    
            xlabel('Distância', 'Color', 'b')
            ylabel('Quantidade', 'Color', 'b')
            title('Distancia dos pixels no eixo y', 'Color', 'r')

            %Calcula X0
            for k = 1 : length(entropia_b_q_o)
                if entropia_c_q_o(k) > 0
                    resultados(i,b,1) = k;
                    break
                end
            end
            % Calculo de X0-Xf
            % resultados(2,i) = entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i));
            % resultados(3,i) = (entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i)))/entropia_b_q_o(resultados(1,i));
            resultados(i,b,2) = length(entropia_c_q_o)-resultados(i,b,1);
            resultados(i,b,3) = (length(entropia_c_q_o)-resultados(i,b,1))/resultados(i,b,1);
            resultados(i,b,4) = 0;
            for k = 1 : length(entropia_c_q_o)
                for l = 0: 0.01  : entropia_c_q_o(k)
                    resultados(i,b,4) = resultados(i,b,4)+1;
                end
            end
            distancia_med(i,b,1) = distancia_med_x_c;
            distancia_med(i,b,2) = distancia_med_y_c;
            
        elseif b == 3
            figure(b+10);
            distancia_m = zeros(1,tamanho(1),'uint8');
            distancia_n = zeros(1,tamanho(1),'uint8');
            for t = 2 : tamanho(1)
                distancia_n(t) = distancia_x_d(t);
                distancia_m(t) = distancia_y_d(t);
            end
            hold on
            plot(distancia_n,distancia_m,'.')

            xlabel('Eixo x', 'Color', 'b')
            ylabel('Eixo Y', 'Color', 'b')
            title('Distância - Segmento D', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5));
            grid on
            
            figure(b);
            subplot(4,1,1)
            if i > 1
                hold on
            end
            plot (entropia_d_q );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia por Quadrante - Segmento D', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5),legenda(6),legenda(7))
            grid on
            
            subplot(4,1,2)
            if i > 1
                hold on
            end
            plot (entropia_d_q_o );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia Ordenada Crescentemente - Segmento D', 'Color', 'r')
            grid on
                                    
            subplot(4,1,3); 
            if i > 1
                hold on
            end
            semilogy(distancia_x_d );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo x', 'Color', 'r');

            subplot(4,1,4); 
            if i > 1
                hold on
            end
            semilogy(distancia_y_d );    
            xlabel('Distância', 'Color', 'b')
            ylabel('Quantidade', 'Color', 'b')
            title('Distancia dos pixels no eixo y', 'Color', 'r')
            %Calcula X0
            for k = 1 : length(entropia_b_q_o)
                if entropia_d_q_o(k) > 0
                    resultados(i,b,1) = k;
                    break
                end
            end
            % Calculo de X0-Xf
            % resultados(2,i) = entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i));
            % resultados(3,i) = (entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i)))/entropia_b_q_o(resultados(1,i));
            resultados(i,b,2) = length(entropia_d_q_o)-resultados(i,b,1);
            resultados(i,b,3) = (length(entropia_d_q_o)-resultados(i,b,1))/resultados(i,b,1);
            resultados(i,b,4) = 0;
            for k = 1 : length(entropia_d_q_o)
                for l = 0: 0.01  : entropia_d_q_o(k)
                    resultados(i,b,4) = resultados(i,b,4)+1;
                end
            end
            distancia_med(i,b,1) = distancia_med_x_d;
            distancia_med(i,b,2) = distancia_med_y_d;
        elseif b == 4
            figure(b+10);
            distancia_m = zeros(1,tamanho(1),'uint8');
            distancia_n = zeros(1,tamanho(1),'uint8');
            for t = 2 : tamanho(1)
                distancia_n(t) = distancia_x_e(t);
                distancia_m(t) = distancia_y_e(t);
            end
            hold on
            plot(distancia_n,distancia_m,'.')
            
            xlabel('Eixo x', 'Color', 'b')
            ylabel('Eixo Y', 'Color', 'b')
            title('Distância - Segmento E', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5));
            grid on
            
            figure(b);
            subplot(4,1,1)
            if i > 1
                hold on
            end
            plot (entropia_e_q );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia por Quadrante - Segmento E', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5),legenda(6),legenda(7))
            grid on
            
            subplot(4,1,2)
            if i > 1
                hold on
            end
            plot (entropia_e_q_o );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia Ordenada Crescentemente - Segmento E', 'Color', 'r')
            grid on
                        
            subplot(4,1,3); 
            if i > 1
                hold on
            end
            semilogy(distancia_x_e );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo x', 'Color', 'r');

            subplot(4,1,4); 
            if i > 1
                hold on
            end
            semilogy(distancia_y_e );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo y', 'Color', 'r');
            %Calcula X0
            for k = 1 : length(entropia_b_q_o)
                if entropia_e_q_o(k) > 0
                    resultados(i,b,1) = k;
                    break
                end
            end
            % Calculo de X0-Xf
            % resultados(2,i) = entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i));
            % resultados(3,i) = (entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i)))/entropia_b_q_o(resultados(1,i));
            resultados(i,b,2) = length(entropia_e_q_o)-resultados(i,b,1);
            resultados(i,b,3) = (length(entropia_e_q_o)-resultados(i,b,1))/resultados(i,b,1);
            resultados(i,b,4) = 0;
            for k = 1 : length(entropia_e_q_o)
                for l = 0: 0.01  : entropia_e_q_o(k)
                    resultados(i,b,4) = resultados(i,b,4)+1;
                end
            end
            distancia_med(i,b,1) = distancia_med_x_e;
            distancia_med(i,b,2) = distancia_med_y_e;
        elseif b == 5
            figure(b+10);
            distancia_m = zeros(1,tamanho(1),'uint8');
            distancia_n = zeros(1,tamanho(1),'uint8');
            for t = 2 : tamanho(1)
                distancia_n(t) = distancia_x_f(t);
                distancia_m(t) = distancia_y_f(t);
            end
            hold on
            plot(distancia_n,distancia_m,'.')
            
            xlabel('Eixo x', 'Color', 'b');
            ylabel('Eixo Y', 'Color', 'b');
            title('Distância - Segmento F', 'Color', 'r');
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5));
            grid on
            
            figure(b);
            subplot(4,1,1)
            
            if i > 1
                hold on
            end
            plot (entropia_f_q );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia por Quadrante - Segmento F', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5),legenda(6),legenda(7));
            grid on
            
            subplot(4,1,2)
            if i > 1
                hold on
            end
            plot (entropia_f_q_o );
            xlabel('Quadrantes', 'Color', 'b');
            ylabel('Entropia', 'Color', 'b');
            title('Entropia Ordenada Crescentemente - Segmento F', 'Color', 'r');
            grid on
                        
            subplot(4,1,3); 
            if i > 1
                hold on
            end
            semilogy(distancia_x_f );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo x', 'Color', 'r');

            subplot(4,1,4); 
            if i > 1
                hold on
            end
            semilogy(distancia_y_f );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo y', 'Color', 'r');
            %Calcula X0
            for k = 1 : length(entropia_b_q_o)
                if entropia_f_q_o(k) > 0
                    resultados(i,b,1) = k;
                    break
                end
            end
            % Calculo de X0-Xf
            % resultados(2,i) = entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i));
            % resultados(3,i) = (entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i)))/entropia_b_q_o(resultados(1,i));
            resultados(i,b,2) = length(entropia_f_q_o)-resultados(i,b,1);
            resultados(i,b,3) = (length(entropia_f_q_o)-resultados(i,b,1))/resultados(i,b,1);
            resultados(i,b,4) = 0;
            for k = 1 : length(entropia_f_q_o)
                for l = 0: 0.01  : entropia_f_q_o(k)
                    resultados(i,b,4) = resultados(i,b,4)+1;
                end
            end
            distancia_med(i,b,1) = distancia_med_x_f;
            distancia_med(i,b,2) = distancia_med_y_f;
            
        elseif b == 6
            figure(b+10);
            distancia_m = zeros(1,tamanho(1),'uint8');
            distancia_n = zeros(1,tamanho(1),'uint8');
            for t = 2 : tamanho(1)
                distancia_n(t) = distancia_x_g(t);
                distancia_m(t) = distancia_y_g(t);
            end
            hold on
            plot(distancia_n,distancia_m,'.')
            
            xlabel('Eixo x', 'Color', 'b')
            ylabel('Eixo Y', 'Color', 'b')
            title('Distância - Segmento G', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5));
            grid on
            
            figure(b);
            subplot(4,1,1)
            if i > 1
                hold on
            end
            plot (entropia_g_q );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia por Quadrante - Segmento G', 'Color', 'r')
            legend(legenda(1),legenda(2),legenda(3),legenda(4),legenda(5),legenda(6),legenda(7));
            grid on
            
            subplot(4,1,2)
            if i > 1
                hold on
            end
            plot (entropia_g_q_o );
            xlabel('Quadrantes', 'Color', 'b')
            ylabel('Entropia', 'Color', 'b')
            title('Entropia Ordenada Crescentemente - Segmento G', 'Color', 'r')
            grid on
                        
            subplot(4,1,3); 
            if i > 1
                hold on
            end
            semilogy(distancia_x_g );    
            xlabel('Distância', 'Color', 'b');
            ylabel('Quantidade', 'Color', 'b');
            title('Distancia dos pixels no eixo x', 'Color', 'r');

            subplot(4,1,4); 
            if i > 1
                hold on
            end
            semilogy(distancia_y_g );    
            xlabel('Distância', 'Color', 'b')
            ylabel('Quantidade', 'Color', 'b')
            title('Distancia dos pixels no eixo y', 'Color', 'r')
            %Calcula X0
            for k = 1 : length(entropia_b_q_o)
                if entropia_g_q_o(k) > 0
                    resultados(i,b,1) = k;
                    break
                end
            end
            % Calculo de X0-Xf
            % resultados(2,i) = entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i));
            % resultados(3,i) = (entropia_b_q_o(length(entropia_b_q_o))-entropia_b_q_o(resultados(1,i)))/entropia_b_q_o(resultados(1,i));
            resultados(i,b,2) = length(entropia_g_q_o)-resultados(i,b,1);
            resultados(i,b,3) = (length(entropia_g_q_o)-resultados(i,b,1))/resultados(i,b,1);
            resultados(i,b,4) = 0;
            for k = 1 : length(entropia_g_q_o)
                for l = 0: 0.01  : entropia_g_q_o(k)
                    resultados(i,b,4) = resultados(i,b,4)+1;
                end
            end
%            resultados(i,b,4) = area_g;
            distancia_med(i,b,1) = distancia_med_x_g;
            distancia_med(i,b,2) = distancia_med_y_g;
        end
    end
end

% Gravando resultados em arquivo
nn = fullfile(path) + "resultados\resultados.txt"
arq = fopen(nn,'w');

fprintf(arq,'\nSegmento\tImagem\t\t\tX_{0}\tXf-X_0\t\t(Xf-X_0)/X_0\tArea\tArea/(Xf-X_0)/X_0\tDist Med x\tDist Med y');
fprintf(arq,'\n------------------------------------------------------------------------------------------------------------------');
for b=1:6
    for i=1:Nr_imagens
        fprintf(arq,'\n');
        if i == round (Nr_imagens/2)
            fprintf(arq,'%d', b);
        else
            fprintf(' \t\t');
        end
        fprintf(arq,'\t\t\t%s', legenda(i));
        fprintf(arq,'\t\t%d', resultados(i,b,1));
        fprintf(arq,'\t\t\t%d', resultados(i,b,2));
        fprintf(arq,'\t\t\t%4.2f', resultados(i,b,3));
        fprintf(arq,'\t\t\t%4.2f', resultados(i,b,4));
        fprintf(arq,'\t\t%6.2f', ((resultados(i,b,4)/(resultados(i,b,3)))));
        fprintf(arq,'\t\t%4.2f', distancia_med(i,b,1));
        fprintf(arq,'\t\t%4.2f', distancia_med(i,b,2));
    end
fprintf(arq,'\n------------------------------------------------------------------------------------------------------------------');
end
fprintf(arq,'\nX0 = Primeiro quadrante com entropia não nula (após ordenação)');
fprintf(arq,'\nXf = Quadrante com maior entropia (após ordenação)');
fprintf(arq,'\nArea = Area do gráfico entropia, ordenada por quadrantes (x=0 até x=entropia - com variação de 0.01)');
fprintf(arq,'\Dist Med x = Distância média dos pixels no eixo x');
fprintf(arq,'\Dist Med y = Distância média dos pixels no eixo y');
fclose(arq);
    
% maximiza janelas das figuras

for i=1:6
    set(figure(i), 'Toolbar', 'figure', 'Menu', 'none');
    frame_h = get(handle(gcf),'JavaFrame');
    set(frame_h,'Maximized',1);
    arquivo = fullfile(path,nome_arq);
    arquivo_fig = convertStringsToChars(fullfile(path)+"resultados\" + "figura_" + i + tipo);
    diretorio = convertStringsToChars(fullfile(path)+"resultados\");
    if ~exist(diretorio, 'dir')
       mkdir(diretorio);
       convertStringsToChars( "Criou pasta "+ fullfile(path)+"resultados\")
    end
    saveas(gcf,arquivo_fig);
    set(frame_h,'Maximized',1);

    set(figure(i+10), 'Toolbar', 'figure', 'Menu', 'none');
    frame_h = get(handle(gcf),'JavaFrame');
    set(frame_h,'Maximized',1);
    arquivo_fig = convertStringsToChars(fullfile(path)+"resultados\" + "figura_" + (i+10) + tipo);
    saveas(gcf,arquivo_fig);
    set(frame_h,'Maximized',1);
end
set(figure(7), 'Toolbar', 'none', 'Menu', 'none');
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);
arquivo_fig = convertStringsToChars(fullfile(path)+"resultados\" + "figura_7" + tipo);
saveas(gcf,arquivo_fig);
set(frame_h,'Maximized',1);

