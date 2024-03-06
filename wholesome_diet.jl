#wholesome diet problem from M&G (section 2.1)
#Written by Thien K. M. Bui and Cuong Chi Tran

using JuMP, GLPK

#this is for the bad diet problem
primal = Model(GLPK.Optimizer)

@variable(primal, x1 >= 0)
@variable(primal, x2 >= 0)
@variable(primal, x3 >= 0)

@objective(primal, Min, 0.75*x1 + 0.5*x2 + 0.15*x3)

@constraint(primal, 35x1 + 0.5x2 + 0.5x3 >= 0.5)
@constraint(primal, 60x1 + 300x2 + 10x3 >= 15)
@constraint(primal, 30x1 + 20x2 + 10x3 >= 4)

print(primal)

JuMP.optimize!(primal)
println("Objective value: ", objective_value(primal), "\n")
println("x1 ", value(x1))
println("x2 ", value(x2))
println("x3 ", value(x3))


#this is the dual
dual = Model(GLPK.Optimizer)

@variable(dual, y1 >= 0)
@variable(dual, y2 >= 0)
@variable(dual, y3 >= 0)

@objective(dual, Max, 0.5y1 + 15y2 + 4y3)

@constraint(dual, 35y1 + 60y2 + 30y3 <= 0.75)
@constraint(dual, 0.5y1 + 300y2 + 20y3 <= 0.5)
@constraint(dual, 0.5y1 + 10y2 + 10y3 <= 0.15)

print(dual)

JuMP.optimize!(dual)

println("Objective value: ", objective_value(dual), "\n")
println("y1 ", value(y1))
println("y2 ", value(y2))
println("y3 ", value(y3))