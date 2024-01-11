# GLPK is our linear programming solver.
using JuMP, GLPK

# Preparing the model
diet = Model(GLPK.Optimizer)

# The variables are the amount of each food item, in kg
@variable(diet, carrot >= 0)
@variable(diet, cabbage >= 0)
@variable(diet, pickle >= 0)

# Objective is to minimize cost
# Coefficients are the cost of each food item in dollars per kg
@objective(diet, Min, 0.75*carrot + 0.5*cabbage + 0.15*pickle)

# Adding constraints
@constraint(diet, constraint1, 35*carrot + 0.5*cabbage + 0.5*pickle >= 0.5)
@constraint(diet, constraint2,  60*carrot + 300*cabbage + 10*pickle >=15)
@constraint(diet, constraint3,  30*carrot + 20*cabbage + 10*pickle >= 4)


# Printing the prepared optimization model
print(diet)

# Solving the optimization problem
JuMP.optimize!(diet)

# Printing the optimal solutions obtained
println("Optimal Solutions:")
println("Total cost = ", objective_value(diet))
println("carrot = ", value(carrot))
println("cabbage = ", value(cabbage))
println("pickle = ", value(pickle))

