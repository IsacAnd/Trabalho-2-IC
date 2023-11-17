clear
clc

% main
v = rand(1, 3) * (1 - 0) + 0; % gera 3 valores aleatórios entre 0 e 1
n = 0.5; % passo de aprendizagem (arbitrário)
w = calculaPesos(v, n); % retorna para 'w' o vetor de pesos obtido pelo processo de aprendizagem do neurônio

x1 = -1.5:0.1:2; 
x2 = -(w(2)/w(3)) * x1 + (w(1)/w(3)); % definição de valores de x2 a partir da equação do slide

plotarGrafico(x1, x2);

function w = calculaPesos(v, n) % processo de aprendizagem do neurônio
    vp = [0 0 0];
    cont = 0;
    while (cont ~= 6) 
        for x2 = 0:1
            for x3 = 0:1
                x = [-1, x2, x3]; % Vetor de entradas x

                u = v(1) * x(1) + v(2) * x(2) + v(3) * x(3); % cálculo da ativação do neurônio

                y = (u > 0) * 1; % saída do sistema
                d = (x(2) | x(3)) * 1; % saída desejada
                e = d - y; % erro = saída desejada - saída do sistema 

                v = v + n * e * x; % novo vetor de pesos baseado no vetor v passado
            end
        end
        
        if (v == vp) % verificação da parada das iterações 
            cont = cont + 1; % caso os vetores de pesos atual e passado estiverem iguais, adiciona o contador
        else 
            cont = 0; % reinicia o cont caso apareça um erro
        end
                
        vp = v;
    end
    w = v;
end

function plotarGrafico(x1, x2)
    plot(x1, x2, 'r');
    title('Neurônio MP para porta OR');

    hold on;
    plot(0, 0, 'ro');
    plot(0, 1, 'bo');
    plot(1, 0, 'bo');
    plot(1, 1, 'bo');
    escala_x = [-0.5 1.5];
    escala_y = [-0.5 1.5];
    axis([escala_x escala_y]);
    grid on;
    hold off;
end