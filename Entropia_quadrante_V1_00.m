% Versão: 1.00
% Calcula a entropia por quadrantes da imagem
% Calcula a entropia a cada pixel, varrendo a imagem a cada quadrante, e retorna o grafico gerado

function entropia = Entropia_quadrante_V1_00(arquivo, tamanho)
    
% Definição do número e do tamanho dos quadrantes
Nr_quadrantes = 20;
tam_quadrante_x =  ceil(tamanho(1)/Nr_quadrantes);
tam_quadrante_y =  ceil(tamanho(2)/Nr_quadrantes);
Entropia = zeros(100);

% Ler imagem
A = imread(arquivo);

a=1;
t = 1;
total = tam_quadrante_x * tam_quadrante_y;


% Teste
B = A;
for k = 1: tam_quadrante_x : tamanho(1)
    for x = 1: tamanho(2)
         if A(k,x) == 255
             B(k,x) = 0;
         else
            B(k,x) = 255;
         end
    end
end
for l = 1: tam_quadrante_y : tamanho(2)
    for z = 1: tamanho(1)
        if A(z,l) == 255
            B(z,l) = 0;
        else
            B(z,l) = 255;
        end
    end
end
figure(35), imshow(A);   
imshow(B);      


% Calculo da entropia, a cada iteração, dentro do quadrante
for k = 1: Nr_quadrantes
    for l = 1: Nr_quadrantes
        
        
        prob_branco = 0;
        branco = 0;
        
        S_1 = 0;
        x_1 = ((k * tam_quadrante_x) - tam_quadrante_x)+1;
        y_1 = ((l * tam_quadrante_y) - tam_quadrante_y)+1;
        for x = x_1 : min((x_1 + tam_quadrante_x),tamanho(1))
            for y = y_1 : min((y_1 + tam_quadrante_y),tamanho(2))
%                B(x,y) = 255; 
                if A(x,y) > 0
                    branco = branco + 1  ;
                end
                prob_branco = (branco / a );
                S_1 = - prob_branco * log2 (prob_branco) - (1 - prob_branco) * log2 (1 - prob_branco);
                if isnan(S_1)
                    S_1 = 0 ;
                end
                S_1;
                a= a+1 ;
            end
        end
        entropia(t) = S_1;
        t=t+1;
    end
end
%figure(15), imshow(B);
%     E = entropy(A);
%     fprintf('Entropia do Sistema: %f\n',E);

