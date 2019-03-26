/* Zachary Patterson
 * Prolog Maze Runner
 * 2019-04-02
 * CSCI-311
 */

:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% ensures the graph behaves as undirected (pway can be traversed in either direction)
path(Source, Destination, Weight) :- pway(Source, Destination, Weight) ; pway(Destination, Source, Weight).

% finds shortest paths incrementally. 
% Arbitrary ceiling of 250 is set for the weight.
solve(Source, Destination, Path, Weight) :-
    format('Finding paths from ~w to ~w:\n\n', [Source, Destination]),
    searchForSpecifiedWeight(Source, Destination, 0, 250, Path, Weight).
    
% finds paths with a cummulative weight equal to that of CurrentWeight
searchForSpecifiedWeight(Source, Destination, CurrentWeight, _, Path, CummulativeWeight) :-
	pfWrapper(Source, Destination, Path, RecursiveWeight),
    CurrentWeight =:= RecursiveWeight,
    CummulativeWeight is RecursiveWeight.

% increments the CurrentWeight variable if there is no path with a length of CurrentWeight
% (gradually increases the cummulative weight of a path being searched for)
searchForSpecifiedWeight(Source, Destination, CurrentWeight, MaxWeight, Path, CummulativeWeight) :-
    CurrentWeight < MaxWeight,
    IncrementedWeight is CurrentWeight + 1,
    searchForSpecifiedWeight(Source, Destination, IncrementedWeight, MaxWeight, Path, CummulativeWeight).

% wrapper predicate adds a path (list) containing just the Source.
% (this adds an additional (default) parameter which allows pathFinder to be called).
% Each time this wrapper is called, a blank list is created with the source (root) of the path
% where additional connection will be appended (later)
pfWrapper(Source, Destination, Path, CummulativeWeight) :-
    pathFinder(Source, Destination, [Source], Path, CummulativeWeight).

% destination reached (breaks the recursive call)
pathFinder(Previous, Destination, CurrentPath, Path, CummulativeWeight) :-
    pway(Previous, Destination, CummulativeWeight),
    append(CurrentPath, [Destination], Path).

% recursive search which prevents cycles with the not(member(...)...) clause
pathFinder(Source, Destination, CurrentPath, Path, CummulativeWeight) :-
    path(Source, Next, Weight),
    not(member(Next, CurrentPath) ; member(Destination, CurrentPath)),
    append(CurrentPath, [Next], NewPath),
    pathFinder(Next, Destination, NewPath, Path, RecursiveWeight),
    CummulativeWeight is Weight + RecursiveWeight.
 
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
% ?- solve(b, j, Path, Weight).
% ?- solve(a, c, Path, Weight).