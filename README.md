# SwarmSim
Graphical Swarm Robotics Simulator based on lua/love.

##Prerequisites
*Lua5.1
*Love0.8

## Engine Description
The Engine is used to simulate multiple Swarms fighting for resources. Modeled on ANT colonies gathering food. ANT's can move only one direction and one step each turn. If they collide with food , they get the food and spawn one child at a random location. If any two ANT's collide , both die. Simulation ends when :
*All food is collected
*Only one ANT colony remains
*30s Timer is over

*All ANTS of a particular colony run the same piece of code [ e.g. bot1, bo2 & bot3 ].*

Sample Code for bots is given , feel free to modify it. ANT's get position of all friends , all remaining food, all enemies  & itself and has to output a move.   
