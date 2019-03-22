% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here

pway(a, b, 3)
pway(a, c, 1)
pway(a, e, 4)
pway(a, i, 2)

% pway(b, a, 3)
pway(b, d, 2)
pway(b, e, 3)
pway(b, g, 9)
pway(b, h, 10)
pway(b, i, 4)

% pway(c, a, 1)
pway(c, d, 2)
pway(c, f, 4)
pway(c, g, 3)

% pway(d, b, 2)
% pway(d, c, 2)
pway(d, f, 8)
pway(d, j, 4)

% pway(e, a, 4)
% pway(e, b, 3)
pway(e, h, 3)
pway(e, i, 4)

% pway(f, c, 4)
% pway(f, d, 8)
pway(f, i, 8)
pway(f, j, 2)

% pway(g, b, 9)
% pway(g, c, 3)
pway(g, h, 2)
pway(g, j, 5)

% pway(h, b, 10)
% pway(h, e, 3)
% pway(h, g, 2)
pway(h, i, 4)

% pway(i, a, 2)
% pway(i, b, 4)
% pway(i, e, 4)
% pway(i, f, 8)
% pway(i, h, 4)

% pway(j, d, 4)
% pway(j, f, 2)
% pway(j, g, 5)

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
*/