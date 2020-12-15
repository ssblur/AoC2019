# Day 6

## Language

I'm not terribly familiar with [Go](https://golang.org/), having never written in it and only compiling projects made using it but it seemed interesting so I decided to give it a go.

## Implementation

Part 1 recursively and dynamically builds a depth map, then adds all values from the map together for the answer.

Part 2, less dynamically, builds two depth poles directly from you and Santa down to the root node. Then, it finds your latest common ancestor, and subtracts it from the depth of the nodes both of you orbit. Finally, adding them together produces your solution, as it is always equal to the number of nodes you would have traversed.