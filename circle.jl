#Use this script to find the maximal radius of a circle centered at (s_1, s_2) bounded by the constraint equations

#Largest Disk in a Convex Polygon Problem
#Understanding and Using Linear Programming 
using JuMP, GLPK

circle = Model(GLPK.Optimizer)

@variable(circle, s_1)
@variable(circle, s_2)
@variable(circle, r)

@objective(circle, Max, r)
# s_1 = 4 #Just for testing we specified the center
# s_2 = 2

#for internal use of script
a_1 = (-1/3)
b_1 = 6
@constraint(circle, (s_2 - a_1*s_1 - b_1)/
(sqrt(a_1*a_1 + 1)) <= -r )


a_2 = 1/3 
b_2 = 2
@constraint(circle, (s_2 - a_2*s_1 - b_2) / (sqrt(a_2*a_2 + 1)) <= -r)

a_3 = 0 #because of this line, our s_2 is always equal to r, but that's a special feature!
b_3 = 0
@constraint(circle, (s_2 - a_3*s_1 - b_3) / (sqrt(a_3*a_3+1)) >= r)

a_4 = 7 
b_4 = -70
@constraint(circle, (s_2 - a_4*s_1 - b_4) / (sqrt(a_4*a_4 + 1)) >= r)

print(circle)

JuMP.optimize!(circle)
println("Optimal Solutions:")
println("R = ", objective_value(circle))
println("s_1 = ", value(s_1))
println("s_2 = ", value(s_2))
