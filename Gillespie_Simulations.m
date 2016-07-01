function Gillespie_miRNA(mi, p, r, K_r, K_p, K_mi,  K_t, Y_r, Y_p, Y_mi, h, n, V)
% Function to be used for Gillespie Simulations of the miRNA gene regulations
% Make a_0 as the sum of all possible a_k's
Mi(1) = mi;
t_mi(1) = 0;
R(1) = r;
t_r(1) = 0;
P(1) = p;
t_p(1) = 0;
for i = 1 : n+1
% Defining Various a_k values. Since the changes are t
a_1 = (K_p*(R(i)(t)))/V;
a_2 = K_r/V
a_3 = K_mi/V
a_4 = (K_t*(R(i)(t)*Mi(i)(t)))/V
a_5 = (Y_r*R(i)(t))/V
a_6 = (Y_mi*Mi(i)(t))/V
a_7 = (Y_p*(P(i)(t)))/V

a_0 = K_p*(R(i)(t)) + K_r + K_mi + K_t*(R(i)(t)*Mi(i)(t)) + Y_r*R(i)(t) + Y_mi*Mi(i)(t) + Y_p*(P(i)(t));
% Choosing a Exponential Random variable to choose after what time reaction should take place
Tau = exprand(1/(a_0));

% Chossing a Random Variable between 0 and 1 in order to choose which reaction
%should take place

A =  rand;
% Now Applying Gillespie Simulations for the Problem by considering the reactions according to
% Algorithm.
% The mRNA is Converted into Protien
if ( 0 <= A < a_1/a_0)
  P(i+1) = P(i) + 1;
  t_p(i+1) = t_p(i) + Tau;

% Formation of mRNA from DNA
elseif( a_1/a_0 <= A < (a_1+a_2)/a_0)
  R(i+1) = R(i) + 1;
  t_r(i+1) = t_r(i) + Tau;

% Formation of miRNA
elseif( ((a_1+a_2)/a_0 <= A < (a_1+a_2+a_3)/a_0)


% Formation of
elseif((a_1+a_2+a_3)/a_0 <= A < (a_1+a_2+a_3+a_4)/a_0)






end
