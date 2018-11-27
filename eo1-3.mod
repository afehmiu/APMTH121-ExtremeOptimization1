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
param w;

var X {b in B};
var L_t;
var L_c;
var Q {i in R, j in C};
var BC {0 .. 8};

minimize Objective: (d_t - L_t) + (L_c - d_c) + w * sum {k in 0 .. 8} BC[k];

subject to Nonnegativity {b in B}: X[b] >= 0;

subject to AdjTumor: d_t - L_t >= 0;

subject to AdjCritical: L_c - d_c >= 0;

subject to Critical {i in R, j in C}: Cr[i, j] * Q[i, j] <= L_c * Cr[i, j];

subject to Tumor {i in R, j in C}: Tm[i, j] * Q[i, j] >= L_t * Tm[i, j];

subject to Amount {i in R, j in C}: Q[i, j] = sum {b in B} I[b, i, j] * X[b];

subject to Border0: BC[0] = sum {i in 2 .. N-1, j in 2 .. M-1} (1 - (prod {a in i-1 .. i+1, b in j-1 .. j+1} (1 - Cr[a, b]))) * (1 - Cr[i, j]) * (1 - Tm[i, j]) * Q[i, j];

subject to Border1: BC[1] = sum {j in 2 .. M-1} (1 - (prod {a in 1 .. 2, b in j-1 .. j+1} (1 - Cr[a, b]))) * (1 - Cr[1, j]) * (1 - Tm[1, j]) * Q[1, j];

subject to Border2: BC[2] = sum {i in 2 .. N-1} (1 - (prod {a in i-1 .. i+1, b in M-1 .. M} (1 - Cr[a, b]))) * (1 - Cr[i, M]) * (1 - Tm[i, M]) * Q[i, M];

subject to Border3: BC[3] = sum {j in 2 .. M-1} (1 - (prod {a in N-1 .. N, b in j-1 .. j+1} (1 - Cr[a, b]))) * (1 - Cr[N, j]) * (1 - Tm[N, j]) * Q[N, j];

subject to Border4: BC[4] = sum {i in 2 .. N-1} (1 - (prod {a in i-1 .. i+1, b in 1 .. 2} (1 - Cr[a, b]))) * (1 - Cr[i, 1]) * (1 - Tm[i, 1]) * Q[i, 1];

subject to Border5: BC[5] = (1 - (prod {a in 1 .. 2, b in 1 .. 2} (1 - Cr[a, b]))) * (1 - Cr[1, 1]) * (1 - Tm[1, 1]) * Q[1, 1];

subject to Border6: BC[6] = (1 - (prod {a in 1 .. 2, b in M-1 .. M} (1 - Cr[a, b]))) * (1 - Cr[1, M]) * (1 - Tm[1, M]) * Q[1, M];

subject to Border7: BC[7] = (1 - (prod {a in N-1 .. N, b in M-1 .. M} (1 - Cr[a, b]))) * (1 - Cr[N, M]) * (1 - Tm[N, M]) * Q[N, M];

subject to Border8: BC[8] = (1 - (prod {a in N-1 .. N, b in 1 .. 2} (1 - Cr[a, b]))) * (1 - Cr[N, 1]) * (1 - Tm[N, 1]) * Q[N, 1];