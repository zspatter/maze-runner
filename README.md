# maze-runner
Simple Prolog program that finds a path through a maze (shortest path problem). This script outputs the both the path (sequence of nodes) and the total weight of the entire path. The first entries' output will be the shortest path, but latter paths will increase in weight incrmentally. This ensures the output is the most efficient path first, then gradually increase the cummulative weight of latter entries.

This script requires a graph represented with paths in the format `pway(<node1>, <node2>, <weight>).` It also requires a query containing both a source and destination node to solve the maze. These nodes will represent the startpoint and endpoint of the maze respectively. If the querried nodes are disconnected (no path connects the nodes), the result will be false.

## What I Learned:
- Prolog syntax
- How to effectively use predicates to model complex tasks
- How to represent data structures in Prolog
- How to represent a graph using dictionaries
- How to traverse undirected graphs
- How to avoid visiting the same node multiple times (preventing cycles)

### Usage: 
```Prolog
solve(<start point>, <end point>, Path, Weight)
```
