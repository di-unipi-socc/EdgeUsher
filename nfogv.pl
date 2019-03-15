:- use_module(library(lists)).
%:- use_module('helpers.py').


searchPlacement(C, P) :-
    placement(C, P),
    forall(node(N,_,_,_), validPlacement(N, P)).

validPlacement(N, P) :-
    node(N, Op, HCaps, TCaps),
    findall(HReqs, member(p(service(C, HReqs, TReqs), node(N, _, _, _)), P), L),
    sum_list(L, R),
    R =< HCaps.

flowSupport(S1, N, LReq, BReq, P) :-
    member(p(service(C, HReqs, TReqs), node(N, _, _, _)), P), 
    link2(M, N, L, B),
    L =< LReq, 
    B >= BReq.

placement([], []).
placement([C|Cs], [p(service(C, HReqs, TReqs), node(N, Op, HCaps, TCaps))|Goal]) :-
    node(N, Op, HCaps, TCaps),
    service(C, HReqs, TReqs),
    forall(member(T, TReqs), member(T, TCaps)), 
    HCaps - HReqs >= 0,
    placement(Cs, Goal).
    
    %member(p(service(S1, _, _), node(M, _, _, _)), Goal),
    %forall(flow(S1, S, LReq, BReq), flowSupport(S1, N, LReq, BReq, P)),
    %forall(flow(S, S1, LReq, BReq), flowSupport(S, N, LReq, BReq, P)).

flowSupport(S1, N, LReq, BReq, P) :-
    member(p(S1,M), P), 
    link2(M, N, L, B),
    L =< LReq, 
    B >= BReq.


query(searchPlacement([s1, s2, s3], P)).


% depth-first search by means of backtracking

% search_bt(Goal,Goal):-
%    goal(Goal).

% search_bt(Current,Goal):-
%    arc(Current,Child),
%    search_bt(Child,Goal).


link2(X, X, 0, 10000). %
link2(X, Y, L, B) :-
    link(X, Z, Lxz, Bxz),
    link(Z, Y, Lzy, Bzy),
    L is Lxz + Lzy,
    B is min(Bxz, Bzy).


%%%% calls


chain(c1, [s1, s2]).

service(s1, 5, [thing1]).
service(s2, 4, [thing2]).
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

