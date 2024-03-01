#  In this script we find the (mixed) Nash equilibrium
#  for the dice-off game:
#  A picks x between 1 to 6
#  B picks y between 1 to 6
#  If x = y      : draw
#  If |x-y| = 1  : 2 points to player with smaller number
#  If |x-y| >= 2 : 1 point to player with bigger number



# load in packages
using JuMP, GLPK

###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
a = Model(GLPK.Optimizer)


# Declaring variables
# Note here that x0 is unconstrained in the problem.
@variable(a, x0)
@variable(a, x1 >= 0)
@variable(a, x2 >= 0)
@variable(a, x3 >= 0)
@variable(a, x4 >= 0)
@variable(a, x5 >= 0)
@variable(a, x6 >= 0)

# Setting the objective
@objective(a, Max, x0)

# Adding constraints M'x - 1x0 >=0 and sum(x) == 1
@constraint(a, constraint1,     - 2*x2 + x3 + x4 + x5 + x6 - x0 >= 0)
@constraint(a, constraint2,  2*x1    - 2*x3 + x4 + x5 + x6 - x0 >= 0)
@constraint(a, constraint3, -x1 + 2*x2    - 2*x4 + x5 + x6 - x0 >= 0)
@constraint(a, constraint4, -x1 - x2 + 2*x3    - 2*x5 + x6 - x0 >= 0)
@constraint(a, constraint5, -x1 - x2 - x3 + 2*x4    - 2*x6 - x0 >= 0)
@constraint(a, constraint6, -x1 - x2 - x3 - x4 + 2*x5      - x0 >= 0)
@constraint(a, constraint7,  x1 + x2 + x3 + x4 + x5 + x6      == 1)

# Printing the prepared optimization model
print(a)

# Solving the optimization problem
JuMP.optimize!(a)

# Print the information about the optimum.
# We don't print x0 because it's just the value of the objective
println(" \n PRIMAL \n ")
println("Objective value: ", objective_value(a), "\n")
println("Optimal solution:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("x3 = ", value(x3))
println("x4 = ", value(x4))
println("x5 = ", value(x5))
println("x6 = ", value(x6), "\n")

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
