#Math 271 Winter 2024, Professor Rob Thompson
#Pset 1 diet problem
# Writeup can be found here https://www.overleaf.com/project/65998e0035ee43ed3ff80b64

using JuMP, GLPK

diet = Model(GLPK.Optimizer)

#amount of each food Rob should consume
#this is definitely a diet of all time...yikes
@variable(diet, peanut_butter >= 0)
@variable(diet, whole_milk >= 0)
@variable(diet, oats >=0)
@variable(diet, beef >= 0)

#Minimize the cost
#Coefficients are the cost of each food to consume
@objective(diet, Min, 0.8*peanut_butter + 0.20*whole_milk + 0.40*oats + beef) 

#fat intake have to be at most 80g per day
@constraint(diet, max_fat, 16*peanut_butter + 8*whole_milk + 6*oats + 12*beef <= 80)  #For part C, comment this out to see a possible solution
#at most 40g of sugar
@constraint(diet, max_sugar, 3*peanut_butter + 11*whole_milk <= 40)

#Part A, Rob wants at least 200g of daily protein (goodness gracious)
# @constraint(diet, min_protein, 7*peanut_butter+8*whole_milk+12*oats+26*beef >= 200) 

#Part B, reducing protein intakes to 160g
@constraint(diet, min_protein, 7*peanut_butter + 8*whole_milk + 12*oats + 26*beef >= 160) 

#Part C, dude hates fiber, need to impose a cap of 25g daily maximum
@constraint(diet, max_fiber, 2*peanut_butter + 9*oats <= 25)

print(diet) # just for sanity check, I'm logging my objective functions

JuMP.optimize!(diet)

println("Optimal Solutions: \n")
println("Total cost (in dollar) = ", objective_value(diet))
println("Total Protein (g) = ", value(peanut_butter)*7 + value(whole_milk)*8 + value(oats)*12 +value(beef)*26)
println("Total fat (g) = ", value(peanut_butter)*16 + value(whole_milk)*8 + value(oats)*6 +value(beef)*12)
println("Total fiber (g) = ", value(peanut_butter)*2 + value(oats)*9 )
println("Total sugar (g) = ", value(peanut_butter)*3 + value(whole_milk)*11)
println("Peanut butter (g) = ", value(peanut_butter))
println("Whole milk (g) = ", value(whole_milk))
println("Oats (g) = ", value(oats))
println("Beef (g) = ", value(beef))
