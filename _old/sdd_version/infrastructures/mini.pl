node(n1, 2, [], [p1]).
node(n2, 0, [], []).
node(n3, 3, [], [p2]).

link(n1, n2, 5, 10).
link(n2, n1, 5, 10).
link(n2, n3, 5, 10).
link(n3, n2, 5, 10).
