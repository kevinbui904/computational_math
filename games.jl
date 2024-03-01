#  In this script we find the (mixed) Nash equilibrium
#  for the monkey vs rabbit rock/paper/scissors game.

# load in packages
using JuMP, GLPK

###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
m = Model(GLPK.Optimizer)


# Declaring variables
# Note here that x0 is unconstrained in the problem.
@variable(m, x0)
@variable(m, x1 >= 0)
@variable(m, x2 >= 0)
@variable(m, x3 >= 0)

# Setting the objective
@objective(m, Max, x0)

# Adding constraints M'x - 1x0 >=0 and sum(x) == 1
@constraint(m, constraint1,       x2 - x3 - x0 >= 0)
@constraint(m, constraint2, -x1      + x3 - x0 >= 0)
@constraint(m, constraint3,  x1 + x2 + x3      == 1)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
# We don't print x0 because it's just the value of the objective
println(" \n PRIMAL \n ")
println("Objective value: ", objective_value(m), "\n")
println("Optimal solution:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("x3 = ", value(x3), "\n")

###  SOLVING THE DUAL PROBLEM

# Preparing an optimization model
md = Model(GLPK.Optimizer)


# Declaring variables
# Note y0 is unconstrained.

@variable(md, y0)
@variable(md, y1 >= 0)
@variable(md, y2 >= 0)

# Setting the objective
@objective(md, Min, y0)

# Adding constraints My - 1y0 <= 0, sum(y) == 1
@constraint(md, constraint1,      - y2 - y0 <= 0)
@constraint(md, constraint2,   y1      - y0 <= 0)
@constraint(md, constraint3,  -y1 + y2 - y0 <= 0)
@constraint(md, constraint4,   y1 + y2      == 1)

# Printing the prepared optimization model
print(md)

# Solving the optimization problem
JuMP.optimize!(md)

# Print the information about the optimum.
println(" \n DUAL \n ")
println("Objective value: ", objective_value(md), "\n")
println("Optimal solution:")
println("y1 = ", value(y1))
println("y2 = ", value(y2), "\n")
