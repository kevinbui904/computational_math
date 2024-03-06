using LinearAlgebra

function pretty_tableau(xB, xN, r, Q, p, z0)
    #xB are the basis
    col = size(Q)[2]+2 # +2 is for the p and the xB
    row = size(Q)[1] + 1 # +1 is for the z variable

    table = fill(0.0, col, row)
    table[1,1] = nothing
    
    println(table[:,1])
    # exit()
    for i in 2:row
        
        for j in 2:col
            println(i, j)
            println(table[i, j], "CHECK THIS")
        end
    end
    print(table)
end

xB = [3, 4, 5]
xN = [1,2]

r = [1;1]
Q = [1 -1; -1 0; 0 -1]
p = [1; 3; 2]
z0 = [0]

pretty_tableau(xB, xN, r, Q, p, z0)