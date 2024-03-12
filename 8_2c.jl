using JuMP # Import Libraries
import Ipopt
model_a = Model(Ipopt.Optimizer) 
@variable(model_a, x[1:3]) 
@objective(model_a, Min, x[1]^2 + 2x[2]^2)
@constraint(model_a, x[1] + x[2] + x[3] == 3)
@constraint(model_a, x[1] - 2x[2] == -3)
optimize!(model_a)


# Displaying the optimal solution for problem (a)
println("Optimal solution for problem (a):")
println("x[1] = ", value(x[1]))
println("x[2] = ", value(x[2]))
println("x[3] = ", value(x[3]))
println("Objective value = ", objective_value(model_a))
println()

model_b = Model(Ipopt.Optimizer) 
@variable(model_b, x[1:3]>= 0) 
@objective(model_b, Min, x[1]^2 + 2x[2]^2)
@constraint(model_b, x[1] + x[2] + x[3] == 3)
@constraint(model_b, x[1] - 2x[2] == -3)
optimize!(model_b)


# Displaying the optimal solution for problem (b)
println("Optimal solution for problem (b):")
println("x[1] = ", value(x[1]))
println("x[2] = ", value(x[2]))
println("x[3] = ", value(x[3]))
println("Objective value = ", objective_value(model_b))
println()