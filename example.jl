#Written by Thien K. M. Bui and Cuong Chi Tran

# MATH271 Computational Mathematics, Rob Thompson PSET2
# Winter 2024
# Written by Thien K. M. Bui 
using JuMP, GLPK

#this is for the absolute minimum problem
#where we have to split up the absolute values into 
#different set of constraints
m = Model(GLPK.Optimizer)

@variable(m, x1 >= 0)
@variable(m, x2 >= 0)
@variable(m, x3 >= 0)
@variable(m, x4 >= 0)
@variable(m, x5 >= 0)
@variable(m, x6 >= 0)
@variable(m, x7 >= 0)

@objective(m, Max, 2*x1 + 3*x2 + x3 + 5*x4 + 4*x5 + 6*x6 + 2*x7)

@constraint(m, x1 + x2 + x3 + x4 + x5 + x6 + x7 == 100)
@constraint(m, 2*x1 + 2*x2 + 3*x3 + 2*x4 + x5 + x6 + 4*x7 == 150)
@constraint(m, x1 + 3*x2 + x3 + 2*x4 + 3*x5 + x6 + x7 == 180)
@constraint(m, 3*x1 + x2 + 2*x3 + x4 + 2*x5 +3*x6  + x7 == 200)
@constraint(m, x1 + 2*x2 + x3 + 3*x4 + x5 + 2*x6 + 3*x7  == 220)
@constraint(m, 2*x1 + 2*x2 + 2*x3 + 2*x4 + 2*x5 + 2*x6 + 2*x7  == 250)
@constraint(m, x1 + x2 + 3*x3 + x4 + 3*x5 + 2*x6 + 2*x7  == 270)

print(m)

JuMP.optimize!(m)

println("x1 ", value(x1))
println("x2 ", value(x2))
println("x3 ", value(x3))
println("x4 ", value(x4))
println("x5 ", value(x5))
println("x6 ", value(x6)) 
println("x7 ", value(x7))
