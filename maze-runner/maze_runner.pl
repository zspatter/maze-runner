:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% makes graph behave as undirected
path(Source, Destination, Weight) :- pway(Source, Destination, Weight) ; pway(Destination, Source, Weight).

% finds shortest paths incrementally. Arbitrary ceiling of 1,000 is set.
solve(Source, Destination, Path, Weight) :-
    verifyCurrentWeight(Source, Destination, 0, 1000, Path, Weight).
    
% finds paths with an overall weight equal to CurrentWeight
verifyCurrentWeight(Source, Destination, CurrentWeight, _, Path, CummulativeWeight) :-
	pfWrapper(Source, Destination, Path, RecursiveWeight),
    CurrentWeight =:= RecursiveWeight,
    CummulativeWeight is RecursiveWeight.

% increments the CurrentWeight variable if there is no path with a length of CurrentWeight
verifyCurrentWeight(Source, Destination, CurrentWeight, MaxWeight, Path, CummulativeWeight) :-
    CurrentWeight < MaxWeight,
    IncrementedWeight is CurrentWeight + 1,
    verifyCurrentWeight(Source, Destination, IncrementedWeight, MaxWeight, Path, CummulativeWeight).

% calls pathFinder while adding a path (list) consisting of just the source node
% this creates a list which will be appended as connections are added
pfWrapper(Source, Destination, Path, CummulativeWeight) :-
    pathFinder(Source, Destination, [Source], Path, CummulativeWeight).

% destination reached
pathFinder(Previous, Destination, CurrentPath, Path, CummulativeWeight) :-
    pway(Previous, Destination, CummulativeWeight),
   % not(member(Previous, CurrentPath)),
    append(CurrentPath, [Destination], Path).

% recursive case
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