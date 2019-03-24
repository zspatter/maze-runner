:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
:- dynamic(reversePath/2).
 
% makes edges behave as undirected
path(Source, Destination, Weight) :- pway(Destination, Source, Weight).
path(Source, Destination, Weight) :- pway(Source, Destination, Weight).
 
% if path is less than the currently stored path, replace it
shorterPath([H|Path], Weight) :-		       
	reversePath([H|_], W), !, Weight < W,          
	retract(reversePath([H|_], _)),
	assert(reversePath([H|Path], Weight)).

% store new path
shorterPath(Path, Weight) :-		       
	assert(reversePath(Path, Weight)).
 
% traverses each unvisited adjacent node then compares weight to current minimum weight
% shortest path and weight are updated, then traverse to adjacent
traverse(Source, Path, Weight) :-		    
	path(Source, T, W),		    
	not(memberchk(T, Path)),	    
	shorterPath([T, Source|Path], Weight + W), 
	traverse(T, [Source|Path], Weight + W).	    
 
% removes solutions and traverses from original source
traverse(Source) :-
	retractall(reversePath(_,_)),           
	traverse(Source, [], 0).              
traverse(_).
 
% finds all weights, once the destination is reached, path and distance are reported
solve(Source, Destination) :-
    format('Finding the shortest path between node ~w (source) and node ~w (destination):\n', [Source, Destination]),
	traverse(Source),                   
	reversePath([Destination|ReversePath], Weight)->        
	  reverse([Destination|ReversePath], Path),   
	  CumulativeWeight is round(Weight),
	  format('\tShortest path is ~w with distance ~w = ~w\n\n',
	       [Path, Weight, CumulativeWeight]);
	format('\tThere is no route from ~w to ~w\n', [Source, Destination]).

% sample graph
pway(a, b, 3).
pway(a, c, 1).
pway(a, e, 4).
pway(a, i, 2).
pway(b, d, 2).
pway(b, e, 3).
pway(b, g, 9).
pway(b, h, 10).
pway(b, i, 4).
pway(c, d, 2).
pway(c, f, 4).
pway(c, g, 3).
pway(d, f, 8).
pway(d, j, 4).
pway(e, h, 3).
pway(e, i, 4).
pway(f, i, 8).
pway(f, j, 2).
pway(g, h, 2).
pway(g, j, 5).
pway(h, i, 4).

% sample queries
?- solve(b, j).
?- solve(a, c).
 