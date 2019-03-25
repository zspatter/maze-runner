# maze-runner
Simple Prolog program that finds a path through a maze (shortest path problem). This script outputs the both the path (sequence of nodes) and the total weight of the entire path. The first entry output will be the shortest path, but later paths will increase in weight incrmentally. This should output the most efficient path first, then gradually increase the cummulative weight of later entries.

This script requires a graph represented with paths `pway(<node1>, <node2>, <weight>).` It requires a query containing a source ad destination node to solve the maze.

## What I Learned:
- Prolog syntax
- How to effectively use predicates to model complex tasks
- How to represent data structures in Prolog
- How to represent a graph using dictionaries
- How to traverse undirected graphs
- How to avoid visiting the same node multiple times (preventing cycles)

### Usage: 
`solve(<start point>, <end point>, Path, Weight)`
