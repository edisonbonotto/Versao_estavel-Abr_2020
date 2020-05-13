% Calcula a entropia a cada pixel, varrendo a imagem, e retorna o grafico gerado
% Versão: 1.00
function entropia = entropia_V1_00(arquivo)

    % Ler imagem
    A = imread(arquivo);
    A(1,1)=0;

    % figure(1); imshow(A);
    % http://www.ic.uff.br/~aconci/entropia.PDF
    tamanho = size (A);
    total = tamanho(1) * tamanho(2);
    prob_branco = 0;
    branco = 0;
    S_1 = zeros(1,total);
    a=1;

    % Calculo da entropia a cada iteração...
    for x = 1: tamanho(1)
        for y = 1: tamanho(2)
            if A(x,y) > 0
                branco = branco + 1  ;
            end
            prob_branco = (branco / a );
            S_1(a) = - prob_branco * log2 (prob_branco) - (1 - prob_branco) * log2 (1 - prob_branco);
            if isnan(S_1(a))
                S_1(a) = 0 ;
            end
            S_1(a);
            a= a+1 ;
        end
    end
    entropia = S_1;
    
    E = entropy(A);
    fprintf('Entropia do Sistema: %f\n',E);

