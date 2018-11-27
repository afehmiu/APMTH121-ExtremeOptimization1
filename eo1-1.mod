param N;
param M;
param A;

set R = {1 .. N};
set C = {1 .. M};
set B = {1 .. A};

param d_c;
param d_t;
param I {b in B, i in R, j in C};
param Cr {i in R, j in C};
param Tm {i in R, j in C};

var X {b in B};

maximize Objective: sum {i in R, j in C} (Tm[i, j] - Cr[i, j]) * (sum {b in B} I[b, i, j]);

subject to Nonnegativity {b in B}: X[b] >= 0;

subject to Critical {i in R, j in C}: Cr[i, j] * (sum {b in B} I[b, i, j] * X[b]) <= d_c * Cr[i, j];

subject to Tumor {i in R, j in C}: Tm[i, j] * (sum {b in B} I[b, i, j] * X[b]) >= d_t * Tm[i, j];
