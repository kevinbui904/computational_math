# MATH271 Computational Mathematics, Rob Thompson PSET6
# Winter 2024
# Written by Thien K. M. Bui 
using JuMP, GLPK

#this is for the bad diet problem
primal = Model(GLPK.Optimizer)

@variable(primal, x1 >= 0)
@variable(primal, x2 >= 0)

@objective(primal, Min, 0.5*x1 + 0.8*x2)

@constraint(primal, 3x1 >= 6)
@constraint(primal, 2x1 + 4x2 >= 10)
@constraint(primal, 2x1 + 5x2 >= 8)

print(primal)

JuMP.optimize!(primal)
println("Objective value: ", objective_value(primal), "\n")
println("x1 ", value(x1))
println("x2 ", value(x2))

#this is the dual
dual = Model(GLPK.Optimizer)

@variable(dual, y1 >= 0)
@variable(dual, y2 >= 0)
@variable(dual, y3 >= 0)

@objective(dual, Max, 6*y1 + 10*y2 + 8*y3)

@constraint(dual, 3y1 + 2y2 + 2y3 <= 0.5)
@constraint(dual, 4y2 + 5y3 <= 0.8)

print(dual)

JuMP.optimize!(dual)

println("Objective value: ", objective_value(dual), "\n")
println("y1 ", value(y1))
println("y2 ", value(y2))
println("y3 ", value(y3))