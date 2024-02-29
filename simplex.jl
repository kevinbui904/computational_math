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

    #########WRAP THIS IN A FUNCTION TO COMPUTE THE FIRST R
    r = [11]



    #while r_i is not >= 0, for all r_i in r
    while !all(x -> x <= 0, r)
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

        #we're done when all of r is positive
        println("r = ", r)

        #Pivoting rule Dantzig rule
        #We pivot the largest entry in r
        largest_index = findmax(r)[2] #findmax returns the maximal (val, index)
        Q_i = Q[:, largest_index] #column of Q corresponding with the largest index in r    
        negative_indices = findall(x -> x < 0, Q_i)
        normalized_constraints = [] #p[negative_indices] / Q_i[negative_indices]
        
        if size(negative_indices)[1] > 0
            for index in negative_indices
                if Q_i[index] != 0
                    push!(normalized_constraints, (p[index] / -Q_i[index], index))
                end
            end
            tightest_constraint_index = findmin(normalized_constraints)[1][2] #the smallest of the normalized constraint is the strictest
            Basis[tightest_constraint_index] = N[largest_index] 
            Basis = sort(Basis; alg=QuickSort)    
        else 
            println("WE DONE")
        end
    end

end


A = [
    1 0 0 -2 -9 1 9; 
    0 1 0 1/3 1 -1/3 -2; 
    0 0 1 2 3 -1 -12
    ]

b = [0; 0; 2]
c = [0; 0; 0; 2; 3; -1; -12]
B = [1, 4, 6] #2, 5, 6, 7
# B = [1, 2, 3]
simplex_tableau(A, b, c, B)