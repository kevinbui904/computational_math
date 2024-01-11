using JuMP, GLPK

problem =  Model(GLPK.Optimizer)

@variable(problem, x_i >= 0)
@variable(problem, x_ii >= 0)

@objective(problem, Min, x_i + x_ii)

@constraint(problem, constraint1, x_i + 3*x_ii <= 9.0)
@constraint(problem, constraint2, -2x_i + x_ii <= -5.0)
@constraint(problem, constraint3, x_i + 2*x_ii >= 8.0)

print(problem)


JuMP.optimize!(problem)

println("Maximized solutions:")
objective_value(problem)

println("x_1 = ", value(x_i))
println("x_2 = ", value(x_ii))