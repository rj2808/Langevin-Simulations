function Gillespie_Simulations(mi, p, r, K_r, K_p, K_mi,  K_t, Y_r, Y_p, Y_mi, V, n)
% Function to be used for Gillespie Simulations of the miRNA gene regulations
% Make a_0 as the sum of all possible a_k's
    tic;
    Mi = zeros(1, n+1);
    R  = zeros(1, n+1);
    P  = zeros(1, n+1);
    t  = zeros(1, n+1);

    Mi(1) = mi;
    R(1) = r;
    P(1) = p;
    t(1) = 0;
    for i = 1 : n+1
            % Defining Various a_k values. Since the changes are t
            a_1 = (K_p*(R(i)));
            a_2 = K_r*V;
            a_3 = K_mi*V;
            a_4 = (K_t*(R(i)*Mi(i)))/V;
            a_5 = (Y_r*R(i));
            a_6 = (Y_mi*Mi(i));
            a_7 = (Y_p*(P(i)));

            a_0 = a_1 + a_2 +a_3 + a_4 +a_5 +a_6 +a_7;
            % Choosing a Exponential Random variable to choose after what time reaction should take place
            Tau = exprnd(1/(a_0));

            % Chossing a Random Variable between 0 and 1 in order to choose which reaction
            %should take place

            A =  rand;
            % Now Applying Gillespie Simulations for the Problem by considering the reactions according to
            % Algorithm.

            % The mRNA is Converted into Protien
            if ( 0 <= A && A < a_1/a_0)
                    P(i+1) = P(i) + 1;
                    Mi(i+1) = Mi(i);
                    R(i+1) = R(i);

            end
            % Formation of mRNA from DNA
            if ( a_1/a_0 <= A && A < (a_1+a_2)/a_0)
                    R(i+1) = R(i) + 1;
                    P(i+1) = P(i);
                    Mi(i+1) = Mi(i);
            end
            % Formation of miRNA
            if ( ((a_1+a_2)/a_0 <= A && A < (a_1+a_2+a_3)/a_0))
                    Mi(i+1) = Mi(i) + 1;
                    P(i+1) = P(i);
                    R(i+1) = R(i);

            end
            % The Regulation Term
            if ((a_1+a_2+a_3)/a_0 <= A && A < (a_1+a_2+a_3+a_4)/a_0)
                    Mi(i+1) = Mi(i) - 1;
                    R(i+1) = R(i) - 1;
                    P(i+1) = P(i);
            end

            % Decay of mRNA
            if ((a_1+a_2+a_3+a_4)/a_0 <= A && A < (a_1+a_2+a_3+a_4+a_5)/a_0)
                    R(i+1) = R(i) - 1;
                    P(i+1) = P(i);
                    Mi(i+1) = Mi(i);

            end
            % Decay of miRNA
            if ((a_1+a_2+a_3+a_4+a_5)/a_0 <= A && A < (a_1+a_2+a_3+a_4+a_5+a_6)/a_0)
                      Mi(i+1) = Mi(i) - 1;
                      R(i+1) = R(i);
                      P(i+1) = P(i);


            end
            % Decay of Protien
            if ((a_1+a_2+a_3+a_4+a_5+a_6)/a_0 <= A && A < 1)
                    P(i+1) = P(i) - 1;
                    Mi(i+1) = Mi(i);
                    R(i+1) = R(i);

            end
            t(i+1) = t(i) + Tau;
    end
% Plotting Graphs
plot(t, P);
xlabel('Time');
ylabel('Protien Number')
figure()

plot(t, Mi)
xlabel('Time')
ylabel('miRNA Number')
figure()

plot(t, R)
xlabel('Time')
ylabel('mRNA Number')
toc
end
