# MATH271 Computational Mathematics, Rob Thompson PSET2
# Winter 2024
# Written by Thien K. M. Bui 
using JuMP, GLPK

#after adding Slack variables
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x1 >= 0)
@variable(m, x2 >= 0)
@variable(m, x3 >= 0)
@variable(m, x4 >= 0)

# Setting the objective
@objective(m, Max, x1 - x2)

# Adding constraints
@constraint(m, constraint1, 2*x1 + x2 + x3 == 4)
@constraint(m, constraint2, x2+x4 == 2)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))



# This is before we did the conversion
m2 = Model(GLPK.Optimizer)

# Declaring variables
@variable(m2, x1 >= 0)
@variable(m2, x2 >= 0)

# Setting the objective
@objective(m2, Max, x1 - x2)

# Adding constraints
@constraint(m2, constraint1, 2*x1 + x2 <= 4)
@constraint(m2, constraint2, x2  <= 2)

# Printing the prepared optimization model
print(m2)

# Solving the optimization problem
JuMP.optimize!(m2)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))

