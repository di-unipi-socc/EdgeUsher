:- use_module(library(lists)).
%:- use_module('helpers.py').


enoughHardware(N, HReqs, HCaps, A) :-
    findall(HAlloc, member(a(N, HAlloc), A), L),
    sum_list(L, R),
    HCaps - R >= HReqs.

placement2([], [], [], []).
placement2([C|Cs], [p(C,N)|Ps], [a(N, HReqs)|As], B) :-
    node(N, Op, HCaps, TCaps),
    service(C, HReqs, TReqs),
    forall(member(T, TReqs), member(T, TCaps)), 
    placement2(Cs, Ps, As, B),
    latencySupport(C, N, Ps),
    enoughHardware(N, HReqs, HCaps, As).

    %forall(flow(S1, S, LReq, BReq), flowSupport(S1, N, LReq, BReq, Ps)).
    %forall(flow(S, S1, LReq, BReq), flowSupport(S, N, LReq, BReq, Ps)).

latencySupport(C, N, P) :-
    findall( l( p(C1, M), link2(N, M, L, B)), (flow(C, C1, LReq, BReq), member(p(C1,M), P), link2(N, M, L, B)) , L),
    writenl(L).
    %forall( member( l(p(C1,M), LReq ), L ), ), 
   

flowSupport(S1, N, LReq, BReq, P) :-
    writenl("HEREEEE"),
    findall(p(S1,M), member(p(S1, M), P), T), 
    writenl(T),
    link2(M, N, L, B),
    L =< LReq, 
    B >= BReq.
    %TODO: Enough Bandwidth :)

query(placement2([s1, s2, s3], P, A, B)).


link2(X, X, 0, 10000, []). %
link2(X, Y, L, B, [p(X,Z)|Path]) :-
    link(X, Z, Lxz, Bxz),
    link2(Z, Y, Lzy, Bzy),
    L is Lxz + Lzy,
    B is min(Bxz, Bzy).


%%%% calls


chain(c1, [s1, s2]).

service(s1, 3, [thing1]).
service(s2, 3, [thing2]).
service(s3, 3, []).
flow(s1, s2, 300, 4).
flow(s2, s3, 100, 2).

node(n, opA, 8, [thing1]).
node(m, opB, 8, [thing2]).
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

