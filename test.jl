using LinearAlgebra


function compute_tableau(A, b, c, Basis)
    m, n = size(A)
    AB = A[:, Basis]
    M = []
    for i in 1:n
        push!(M,i)
    end
    N = setdiff(M, Basis)
    AN = A[:, N]
    cT = transpose(c)
    cTB = cT[:, Basis]
    cN = c[N,:]
    # cTN = cT[:, N]
    # cN = transpose(cTN)
    
    # CALCULATION (Leave this alone)
    Q = -inv(AB) * AN
    p = inv(AB) * b
    z0 = (cTB * inv(AB)) * b
    r = cN - transpose((cTB * inv(AB)) * AN)
    return p, Q, z0, r
end

A = [
    -1 -1 1 0 0;
    0 1 0 1 0;
    1 -2 0 0 1
]
b = [-1; 2; 1]
c = [1; 1; 0; 0; 0]
B = [1, 2, 4]


p, Q, z0, r = compute_tableau(A,b,c,B)
println(p, Q, z0, r)