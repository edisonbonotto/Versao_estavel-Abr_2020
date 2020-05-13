% Versão 1.10
% Calcula a distancia dos pixels no eixo x e y e distancia média
function [distancia_x,distancia_y,distancia_med_x,distancia_med_y] = Distancia_V1_01(arquivo, tamanho)
    A = imread(arquivo);
    distancia_x = zeros(1,tamanho(2));
    distancia_y = zeros(1,tamanho(1));
    distancia_med_x = 0;
    distancia_med_y = 0;
    %Calcula distancia eixo x ;
    for i = 1 : tamanho(1)
        x = 0;
        for j = 1 : tamanho(2)
            x = x+1;
            if A(i,j) > 0
                distancia_x(x) = distancia_x(x) + 1;
                x = 0;
            end
        end
    end
    for i = 1 : tamanho(2)
        distancia_med_x = distancia_med_x + (distancia_x(i)*(i-1));
    end
    distancia_med_x = distancia_med_x / tamanho(2);
    
    %Calcula distancia eixo y
    for i = 1 : tamanho(2)
        x = 0;
        for j = 1 : tamanho(1)
            x = x+1;
            if A(j,i) > 0
                distancia_y(x) = distancia_y(x) + 1;
                x = 0;
            end
        end
    end
    for i = 1 : tamanho(1)
        distancia_med_y = distancia_med_y + (distancia_y(i)*(i-1));
    end
    distancia_med_y = distancia_med_y / tamanho(1);
    

