clear
clc

filename = 'column_3C.dat'; 
base = readtable(filename); 

X = base{:,1:6}'; 
D = onehotencode(categorical(base{:,7}),2)'; 

% A cada execução, nova permutação de dados e novo treinamento da rede
% neural

% Iniciando um vetor de acuracias com zero que será preenchido a cada
% execução. 
acuracias = zeros(1, 10);

for i = 1:10
    % Gerar uma permutação aleatória das amostras
    perm = randperm(size(X, 2));
    
    % Separar as amostras em dois conjuntos, um para treino e outro para teste
    % 0.7 é o valor que indica o hold-out onde 70% dos valores são para teste
    tamanho_treino = floor(size(X, 2) * 0.7); 
    
    % Amostras de entrada, atributos analisados. 
    X_treino = X(:, perm(1:tamanho_treino));
    X_teste = X(:, perm(tamanho_treino + 1:end));
    
    % Amostras de saída, classificações. 
    D_treino = D(:, perm(1:tamanho_treino));
    D_teste = D(:, perm(tamanho_treino + 1:end));
    
    net = feedforwardnet(10)
        net = train(net, X_treino, D_treino);
        net.trainParam.showWindow = false; 
       
        previsao = net(X_teste);

        [teste, indicesPrevisao] = max(previsao);

        [teste2, indicesTeste] = max(D_teste); 

        acertos = sum(indicesTeste == indicesPrevisao); 

        acuracia = acertos/length(D_teste); 

        % Adicione a acurácia atual ao vetor de acurácias
        acuracias(i) = acuracia;
end

% Calcule a média das acurácias
acuracia_media = mean(acuracias) * 100;

% Imprima a acurácia média
fprintf('A acurácia média é: %.2f%%\n', acuracia_media);