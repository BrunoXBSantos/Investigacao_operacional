param N_paletes;

param N_niveis;

set P := {i in 1..N_paletes};
set N := {j in 1..N_niveis};

param Palete {i in P, j in 1..4};
param Nivel {i in N, j in 1..2};

var x{i in P, j in N}, binary;

minimize TempoTotal : sum {i in P, j in N} Palete[i,4] * Nivel[j,1]* x[i,j];

s.t. AfetarPalete {i in P}: sum {j in N} x[i,j]=1;
s.t. OcuparNivel {j in N}: sum {i in P} x[i,j]<=1;