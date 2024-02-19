# MATH271 Computational Mathematics, Rob Thompson PSET2
# Winter 2024
# Written by Thien K. M. Bui 
using JuMP, GLPK

#this is for the absolute minimum problem
#where we have to split up the absolute values into 
#different set of constraints
m = Model(GLPK.Optimizer)

@variable(m, z >= 0)
@variable(m, x1 >= 0)
@variable(m, x2 >= 0)

@objective(m, Min, 2*x1 + 3*z)

@constraint(m, -(x1 +2) + x2 <=5)
@constraint(m, -(x1 +2) - x2 <=5)
@constraint(m, (x1 +2) + x2 <=5)
@constraint(m, (x1 +2) - x2 <=5)

#these are the absolute value constraints for z
@constraint(m, x2 - 10 <= z)
@constraint(m, -(x2 -10) <= z)

print(m)

JuMP.optimize!(m)

println("x1 ", value(x1))
println("x2 ", value(x2))
println("z ", value(z))
