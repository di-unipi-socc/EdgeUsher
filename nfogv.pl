:- use_module(library(lists)).
%:- use_module('helpers.py').


placement([], []).
placement([C|Cs], [p(C, N)|Goal]) :-
    node(N, Op, HCaps, T),
    service(C, HReqs, TReqs),
    HCaps - HReqs >= 0,
    placement(Cs, Goal).

query(placement([s1], P)).


link(X, X, 0, 10000). %
link2(X, Y, L, B) :-
    link(X, Z, Lxz, Bxz),
    link(Z, Y, Lzy, Bzy),
    L is Lxz + Lzy,
    B is min(Bxz, Bzy).


%%%% calls


chain(c1, [s1, s2]).

service(s1, 5, [thing1]).
service(s2, 3, []).
service(s3, 3, []).
flow(s1, s2, 30, 4).
flow(s2, s3, 100, 2).

node(n, opA, 8, [thing1]).
node(m, opB, 4, [thing2]).
node(cloud, opC, 100000, []).

link(n, m, 10, 12).
link(m, n, 10, 12).
link(m, cloud, 60, 8).
link(cloud, m, 90, 8).


%%%%%%%%%
% Utils
%%%%%%%%%

forall(G, C) :- not((G, not(C))).

del(X, [X|L], L).
del(X, [Y|L], [Y|L1]) :-
    del(X, L, L1).

