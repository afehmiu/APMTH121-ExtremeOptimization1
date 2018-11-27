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
var L_t;
var L_c;

minimize Objective: (d_t - L_t) + (L_c - d_c);

subject to Nonnegativity {b in B}: X[b] >= 0;

subject to AdjTumor: d_t - L_t >= 0;

subject to AdjCritical: L_c - d_c >= 0;

subject to Critical {i in R, j in C}: Cr[i, j] * (sum {b in B} I[b, i, j] * X[b]) <= L_c * Cr[i, j];

subject to Tumor {i in R, j in C}: Tm[i, j] * (sum {b in B} I[b, i, j] * X[b]) >= L_t * Tm[i, j];
