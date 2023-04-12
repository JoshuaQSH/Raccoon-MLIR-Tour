## Embedding - TensorTrain Compression

```c++
// Pseudocode Forward prop. of TT-Embedding
while S_idx < offsets[m] do
	E_idx = min(offsets[S_idx + B], offsets[m])
	for k = S_idx to E_idx do
	idx[j][k] = i^k_j in Eqn( 4)
	a[k] = &G1[idx[1][k]][0]
	b[k] = &G0[idx[0][k]][0]
	c[k] = &tr0[k][0]
	a[k + B] = &G2[idx[2][k]][0]
	b[k + B] = &tr0[k][0]
	c[k + B] = &tr1[k][0]
end
for j = 0 to (d-2) do
	// Batched GEMM kernel calls
	c[jB : (j + 1)B] = a[jB : (j + 1)B] ∗ b[jB : (j + 1)B]
end
// Reduce embedding rows to output
output[S_idx : E_idx] = SUM(c[j]) // from j=offsets[i] to offsets[i+1]
S_idx = E_idx
end
```

```c++
// Pseudocode Backward prop. of TT-Rec Embeddings
while S_idx < offsets[m] do
	E_idx = min(offsets[S_idx + B], offsets[m])
	// Recompute for tri’s as in Algorithm 1
	for k = S_idx to E_idx do
	idx[j][k] = i^k_j in Eqn(4)
	a0[k] = &G0[idx[0][k]][0]
	b0[k] = &tr0[k][0]
	c0[k] = &tr_G1[k][0]
	a1[k] = &tr0[k][0]
	b1[k] = &G1[idx[1][k]][0]
	c1[k] = &tr_G0[k][0]
	a0[k + B] = &tr0[k][0]
	b0[k + B] = &dx
	c0[k + B] = &tr_G2[k][0]
	a1[k + B] = &dx
	b1[k + B] = &G2[idx[2][k]][0]
	c1[k + B] = &tr0[k][0]
end
for j = d-2 to 0 do
	// Batched GEMM calls to compute ∂Gj
	c0[jB : (j + 1)B] = a0[jB : (j + 1)B] ∗ b0[jB : (j + 1)B]
	// Batched GEMM calls to compute ∂x
	c1[jB : (j + 1)B] = a1[jB : (j + 1)B] ∗ b1[jB : (j + 1)B]
	∂Gj [idx[k]]+ = tr Gj [k]
end
start_idx = end_idx
end
```

```c++
// Sampled Gaussian initialization
for d = 0 to tt-dim do
	Gd =  random.normal(0,1)
	for each entry Gd(i, j, k, l) in Gd do
		while Gd(i, j, k, l) <= 2 do
			Gd(i, j, k, l) = random.normal(0, 1)
	Gd /= pow((sqrc(1/3n)), (1/d))
```
