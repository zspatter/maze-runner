edge(a,b,1).
edge(a,c,1).
edge(a,d,1).
edge(b,e,1).
edge(c,e,1).
edge(c,f,1).
edge(d,f,1).
edge(f,g,1).
edge(g,e,1).
edge(e,a,1).

path(Source, Destination, Weight) :- edge(Source, Destination, Weight).
path(Source, Destination, Weight) :- edge(Source, Destination, Weight).

% Wrapping predicate for finding shortest path.
%%%% fsp(+Start, +End, +MaxLength, -Path, -TotalLength) :-
fsp(Start, End, Path, TotalLength) :-
	lowestLengthFP(Start, End, 1, 1000, Path, TotalLength).

% Is true if the length of a path is equal to the current value stored in
% RequiredLength. This equals to the path with the lowest length.
lowestLengthFP(Start, End, RequiredLength, _, Path, TotalLength) :-
	fp(Start, End, Path, RecursiveLength),
	RequiredLength =:= RecursiveLength,
	TotalLength is RecursiveLength.

% This predicate increments the RequiredLength value when there's no path found
% (by the previous predicate) whose length equals the value of RequiredLength.
% RequiredLength is incremented so that the "floor" (to which the lowest path
% length is compared) is raised.
lowestLengthFP(Start, End, RequiredLength, MaxLength, Path, TotalLength) :-
	RequiredLength < MaxLength,
	NewReqLength is RequiredLength + 1,
	lowestLengthFP(Start, End, NewReqLength, MaxLength, Path, TotalLength).

% Wrapping predicate for finding path.
fp(Start, End, Path, TotalLength) :-
	findPath(Start, End, [Start], Path, TotalLength).

% Actual pathfinding.
%%%% findPath(+Start, +End, +PathSoFar, -Path, -TotalLength)

% End found.
findPath(Previous, End, PathSoFar, Path, TotalLength) :-
	edge(Previous, End, TotalLength),
	append(PathSoFar, [End], Path).

% General recursive case.
findPath(Start, End, PathSoFar, Path, TotalLength) :-
	edge(Start, Next, Length),
    not(member(Next, PathSoFar)),
	append(PathSoFar, [Next], NewPath),
	findPath(Next, End, NewPath, Path, RecursiveLength),
	TotalLength is Length + RecursiveLength.

