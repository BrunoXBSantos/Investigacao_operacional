param N_paletes;  
param N_niveis;
param N_rack;    # numero de racks usadas
param HMaxRack;  # altura maxima de uma rack

set P := {i in 1..N_paletes}; # P representa Paletes
set N := {j in 1..N_niveis};  # N representa niveis
set R := {k in 1..N_rack};

param Palete {i in P, j in 1..4};   # Referência	Altura	Largura	Taxa de Utilização	
param Nivel {i in N, j in 1..3};    # Acessibilidade	Largura	nºrack

var x{i in P, j in N}, binary;
var Hr{k in R}>=0;

# alt corresponde a altura de cada nível
var alt { j in N}, >=0; 
# des corresponde ao desperdicio de cada nivel
var des { i in P}, >=0;

var auxFO1, >=0;
var auxFO2, >=0;

#FO tempo total
#minimize TempoTotal : sum {i in P, j in N} Palete[i,4] * Nivel[j,1]* x[i,j];
#FO desperdicio
minimize ValorDesperd: sum {i in P} des[i];

s.t. AfetarPalete {i in P}: sum {j in N} x[i,j]=1;
s.t. OcuparNivel {j in N}: sum {i in P} Palete[i,3]*x[i,j]<=Nivel[j,2];
s.t. RestricaoAlt {i in P, j in N}: alt[j] >= Palete[i,2] * x[i,j];
s.t. Desperd {i in P, j in N} : x[i,j]=1 ==> des[i]=alt[j]-Palete[i,2];

s.t. calcFO1: auxFO1=sum {i in P, j in N} Palete[i,4] * Nivel[j,1]* x[i,j];
s.t. calcFO2: auxFO2=sum {i in P} des[i];

s.t. AlturaRack{ k in R}: Hr[k]=sum{j in N : Nivel[j,3]=k} alt[j];
s.t. AlturaRack1{ k in R}: Hr[k] <= HMaxRack;

s.t. calcMO: auxFO1 <= 65000; 
