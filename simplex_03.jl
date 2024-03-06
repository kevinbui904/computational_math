#Written by Thien K. M. Bui, Cuong Chi Tran, and Albert Jing
using LinearAlgebra

#printing the tableau
function pretty_tableau(xB, xN, r, Q, p, z0)
    row_count = size(xB)[1]+1 #the +1 is for the z row
    for i in 1:row_count 
        if i < row_count
            #print the basic vars
            print("x_",xB[i], " = ", p[i]) #x_1 = 1 
            for j in 1:size(xN)[1]
                if Q[i,j] != 0
                    if Q[i,j] > 0
                        print(" + ", round(Q[i,j], sigdigits = 3), "x_", xN[j])
                    else
                        print(" - ", round(abs(Q[i,j]), sigdigits = 3), "x_", xN[j])
                    end
                else
                    print("\t  ")
                end
            end
        else
            #print z row
            print("  z = ", z0[1])
            for j in 1:size(xN)[1]
                if r[j] != 0
                    if r[j] > 0
                        print(" + ", round(r[j], sigdigits=3), "x_", xN[j])
                    else
                        print(" - ", round(abs(r[j]), sigdigits=3), "x_", xN[j])
                    end
                else
                    print("       ")
                end
            end
        end
        println()
    end
    println()
end


#compute tableau components
function tableau_components(A, b, c, Basis)
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
    return p, Q, z0, r, N
end

function simplex_tableau(A, b, c, Basis, rule)
    # INPUT (add in inputs of correct sizes, as specified below) (Example included)
    # A: m rows * n columns matrix, n >= m preferably
    # b: m elements vector
    # c: n elements vector
    # Basis: # m elements basis, make sure to write the column indices in order of smallest to largest
    # With all input entered, execute the code. for example, in VS Code, click the topright triangle symbol


    # DATA SELECTION (Leave this alone)
    m, n = size(A)
    
    if size(b) != size(Basis) 
        println("b and Basis must be of the same size.>>>>> ","b: ", size(b)[1], " Basis: ", size(Basis)[1])
        exit()
    elseif size(b)[1] != m
        println("b must be of dimension m, A is an m x n matrix >>>>> ","b: ", size(b)[1], " m: ", m)
        exit()

    elseif size(c)[1] != n
        println("c must be of dimension n, A is an m x n matrix>>>>> ","c: ", size(c)[1], " n: ", n)
        exit()
    end

    #######Instantiations
    r = [11] #instantiation variable
    p = 11
    Q = 11
    z0 = 11
    N = 11
    print_initial = 1

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

        # p, Q, z0, r, N = tableau_components(A, b, c, Basis)

        if print_initial == 1
            println("Initial Tableau")
            pretty_tableau(Basis, N, r, Q, p, z0) 
            print_initial = 0
        else 
            pretty_tableau(Basis, N, r, Q, p, z0) 
        end

        if rule == 1  #Dantzig's rule (largest entry in r)
            in_index = findmax(r)[2] #findmax returns the maximal (val, index)
        elseif rule == 2 #Bland's rule (smallest index in r)
            in_index = 1
        elseif rule == 3 #random
            in_index = rand(collect(1:length(r)))
        else
            println("Please choose a valid rule: 1 for Dantzig's, 2 for Bland's")
        end
        Q_i = Q[:, in_index] #column of Q corresponding with the largest index in r
        negative_indices = findall(x -> x < 0, Q_i)
        normalized_constraints = [] #p[negative_indices] / Q_i[negative_indices]
        
        if size(negative_indices)[1] > 0
            for index in negative_indices
                if Q_i[index] != 0
                    push!(normalized_constraints, (p[index] / -Q_i[index], index))
                end
            end
            tightest_constraint_index = findmin(normalized_constraints)[1][2] #the smallest of the normalized constraint is the strictest
            if r[in_index] > 0
                println("x_", N[in_index], " in, x_", Basis[tightest_constraint_index], " out")   
                Basis[tightest_constraint_index] = N[in_index] 
                Basis = sort(Basis; alg=QuickSort)
            else
                println("pivoting x_", N[in_index], " does not improve objective.")
            end
        else 
            println("WE DONE")
        end
    end

    ##DISPLAY FINAL HERE
    # OUTPUT (Leave this alone)
    println("\n")
    println("Optimal BFP: ")
    #pretty printing x_bar
    matching_index = 1
    for i in 1:n
        if i in Basis
            println("\tx",i, " = ", p[matching_index])
            matching_index += 1 
        else ##add a zero
            println("\tx",i, " = 0.0")
        end
    end
    println("Optimal Objective Value = ", z0)
end


#look at pset4, problem 4.3
A = [
    -1 -1 1 0 0;
    0 1 0 1 0;
    1 -2 0 0 1
]
b = [-1; 2; 1]
c = [1; 1; 0; 0; 0]
B = [1, 2, 4]


########PSET6
# A = [
#     1 0 0 -2 -9 1 9; 
#     0 1 0 1/3 1 -1/3 -2; 
#     0 0 1 2 3 -1 -12
#     ]

# b = [0; 0; 2]
# c = [0; 0; 0; 2; 3; -1; -12]
# B = [1, 4, 6] #2, 5, 6, 7
# B = [1, 2, 3]


#Wholesome and Cheap Diet from book
A = [
    35 60 30 1 0 0;
    0.5 300 20 0 1 0;
    0.5 10 10 0 0 1
]
b = [0.75; 0.5; 0.15]

c = [0.5; 15; 4; 0; 0; 0]

B = [4,5,6]
simplex_tableau(A, b, c, B, 1)