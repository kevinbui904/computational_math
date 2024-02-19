using LinearAlgebra

function simplex_tableau(A, b, c, Basis)
    # INPUT (add in inputs of correct sizes, as specified below) (Example included)
    # A: m rows * n columns matrix, n >= m preferably
    # b: m elements vector
    # c: n elements vector
    # Basis: # m elements basis, make sure to write the column indices in order of smallest to largest
    # With all input entered, execute the code. for example, in VS Code, click the topright triangle symbol

    # DATA SELECTION (Leave this alone)
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

    # OUTPUT (Leave this alone)
    println("Basis B: ", Basis)
    println("p = ", p)
    println("Q = ")
    display(Q) #pretty printing display
    println("z0 = ", z0)
    println("r = ", r)

end


A = [
    1 0 0 -2 -9 1 9; 
    0 1 0 1/3 1 -1/3 -2; 
    0 0 1 2 3 -1 -12
    ]

b = [0; 0; 2]
c = [0; 0; 0; 2; 3; -1; -12]
B = [1, 4, 6] #2, 5, 6, 7

simplex_tableau(A, b, c, B)