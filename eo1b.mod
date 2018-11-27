set R = {1 .. N};
set C = {1 .. M};
set B;

param N;
param M;
param I {b in B, i in R, j in C};
param C {i in R, j in C};
param T {i in R, j in C};
param d_c;
param d_t;

var X {b in B};

minimize Objective: sum {i in R, j in C} (T[i, j] - C[i, j]) * (sum {b in B} I[b, i, j]);

subject to Nonnegativity {b in B}: X[b] >= 0;

subject to Critical {i in R, j in C}: C[i, j] * (sum {b in B} I[b, i, j] * X[b]) <= d_c * C[i, j]

subject to Tumor {i in R, j in C}: T[i, j] * (sum {b in B} I[b, i, j] * X[b]) >= d_t * T[i, j]
