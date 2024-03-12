using JuMP
import HiGHS
using Plots

n = 10;
Q = rand(2,n);
pnts = [Q[:,i] for i = 1:n]
pdp = [Q[:,i]'*Q[:,i] for i = 1:n];

model = Model(HiGHS.Optimizer)


@variable(model, x[1:n] >= 0)  # Weights for each point
@objective(model, Min, x' * Q' * Q * x - sum(x[j] * pdp[j] for j in 1:n))
@constraint(model, sum(x[i] for i = 1:n) == 1)

optimize!(model)

xstar = value.(x)
opt = objective_value(model)

t = range(0, stop=2π, length=100)
rad = sqrt(-opt)
cen = Q*xstar
xc1 = cen[1] .+ rad*cos.(t)
xc2 = cen[2] .+ rad*sin.(t)

plot(Q[1,:], Q[2,:], xlims=(-0.2, 1.2), ylims=(-0.2, 1.2), seriestype=:scatter, label="random points", aspect_ratio=1.0)
ball = plot!(xc1, xc2, label="enclosing ball")
display(ball)
readline()
