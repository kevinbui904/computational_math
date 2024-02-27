#Written by Thien K. M. Bui
# Pset7 Computational Mathematics Winter '24
# Optimization code for Nash Equilibrium with optimal strategy

# load in packages
using JuMP, GLPK

###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
primal = Model(GLPK.Optimizer)


# Declaring variables
# Note here that x0 is unconstrained in the problem.
@variable(primal, x0)
@variable(primal, x1 >= 0)
@variable(primal, x2 >= 0)
@variable(primal, x3 >= 0)

# Setting the objective (PRIMAL)
@objective(primal, Max, x0)

# Adding constraints M'x - 1x0 >=0 and sum(x) == 1
@constraint(primal, constraint1,  -2*x1 + 3*x2 + -4*x3 - x0  >= 0)
@constraint(primal, constraint2,  3*x1 + -4*x2 + 5*x3 - x0  >= 0)
@constraint(primal, constraint3, x1 + x2 + x3  == 1)

# Printing the prepared optimization model
print(primal)

# Solving the optimization problem
JuMP.optimize!(primal)

# Print the information about the optimum.
# We don't print x0 because it's just the value of the objective
println(" \n PRIMAL \n ")
println("Objective value: ", objective_value(primal), "\n")
println("Optimal solution:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("x2 = ", value(x3))



#Setting up the DUAL
dual = Model(GLPK.Optimizer)
@variable(dual, y0)
@variable(dual, y1 >= 0)
@variable(dual, y2 >= 0)

@objective(dual, Min, y0)

@constraint(dual, constraint1, -2*y1 + 3*y2 - y0 <= 0)
@constraint(dual, constraint2, 3*y1 + -4*y2 - y0 <= 0)
@constraint(dual, constraint3, -4*y1 + 5*y2 - y0 <= 0)
@constraint(dual, constraint4, y1 + y2  == 1)
JuMP.optimize!(dual)
print(dual)

println(" \n DUAL \n ")
println("Objective value: ", objective_value(dual), "\n")
println("Optimal solution:")
println("y1 = ", value(y1))
println("y2 = ", value(y2))