#simulation for mixed strategy of the dice roll game


'''
RULE OF GAME:

Let there be two players, A and B, who both pick a number between 1 and 6.
Call these numbers x and y. Here's the rules:

if x = y, draw
if |x-y| = 1, 2 points to players with smaller number
if |x-y| >= 2, 1 point to player with larger number
'''

import random 

def weighted_dice(w = [10,10,10,10,10,50]):
    return random.choices([1,2,3,4,5,6], weights=w)[0]

def main():
    strat1 = [0, 0, 0, 100, 0, 0]
    strat2 = [0, 33, 33, 0, 33, 0]
    
    score1 = 0
    score2 = 0
    
    k = 100000
    
    for i in range(k):
        x = weighted_dice(strat1)
        y = weighted_dice(strat2)
        
        #Rule of the game
        if x == y:
            continue
        
        if abs(x-y) == 1:
            if x < y:
                score1 += 2
            else:
                score2 += 2
        
        if abs(x-y) >= 2:
            if x > y:
                score1 += 1
            else:
                score2 += 1
        
        print(f'Score: {score1}, {score2}, Iteration: {i}', end='\r')
    print(f'Score: {score1}, {score2}, Iteration: {i}')
    print("LAD")

if __name__ == "__main__":
    main()