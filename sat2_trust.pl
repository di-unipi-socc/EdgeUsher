:- use_module(library(lists)).
%:- consult('app_mini').
%:- consult('infrastructures/infrastructure2.pl').

query(place(C,P,L)).
    
place(Chain, Placement, ServiceRoutes) :-
    chain(OpC, Chain, Services),
    placeServices(OpC, Services, Placement),
    findall(f(S1, S2, Lr, Br), flow(S1, S2, Lr, Br), ServiceFlows),
    placeFlows(OpC, ServiceFlows, Placement, ServiceRoutes).

placeServices(OpC, Services, Placement) :-
    placeServices(OpC, Services, Placement, []).

placeServices(_, [], [], _).
placeServices(OpC, [S|Ss], [on(S,N)|P], AllocatedHW) :-
    service(S, HW_Reqs, T_Reqs),
    node(N, OpN, HW_Caps, T_Caps),
    trusts2(OpC, OpN),
    checkThingReqs(T_Reqs, T_Caps),
    HW_Reqs =< HW_Caps,
    checkHWReqs(HW_Reqs, N, HW_Caps, AllocatedHW, NewAllocatedHW),
    placeServices(OpC, Ss, P, NewAllocatedHW).

checkThingReqs(T_Reqs, T_Caps) :-
    subset(T_Reqs, T_Caps).

checkHWReqs(HW_Reqs, N, HW_Caps, [], [(N,HW_Reqs)]).
checkHWReqs(HW_Reqs, N, HW_Caps, [(N,A)|As], [(N,NewA)|As]) :-
    NewA is A + HW_Reqs,
    NewA =< HW_Caps.
checkHWReqs(HW_Reqs, N, HW_Caps, [(N1,A1)|As], [(N1,A1)|NewAs]) :-
    N \== N1,
    checkHWReqs(HW_Reqs, N, HW_Caps, As, NewAs).

placeFlows(OpC, ServiceFlows, Placement, ServiceRoutes) :-
    placeFlows(OpC, ServiceFlows, Placement, [], ServiceRoutes).

placeFlows(OpC, [], _, ServiceRoutes, ServiceRoutes).
placeFlows(OpC, [SF|SFs], Placement, ServiceRoutes, NewServiceRoutes) :-
    findPath(OpC, SF, Placement, ServiceRoutes, ServiceRoutes2),
    placeFlows(OpC, SFs, Placement, ServiceRoutes2, NewServiceRoutes).

findPath(OpC, f(S1, S2, Lr, Br), Placement, ServiceRoutes, ServiceRoutes) :-
    subset([on(S1,N),on(S2,N)], Placement).

findPath(OpC, f(S1, S2, Lr, Br), Placement, ServiceRoutes, NewServiceRoutes) :-
    subset([on(S1,N1),on(S2,N2)], Placement),
    N1 \== N2,
    path(OpC, N1, N2, 3, [], f(S1, S2, Lr, Br), Placement, ServiceRoutes, NewServiceRoutes).

path(OpC, N1, N2, Radius, VisitedNodes, f(S1, S2, Lr, Br), Placement, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N2, Lf, Bf),
    checkTrust(OpC, N1, N2),
    Lf =< Lr,
    Bf >= Br,
    update(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).

path(OpC, N1, N2, Radius, VisitedNodes, f(S1, S2, Lr, Br), Placement, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N3, Lf, Bf), N3 \== N2, \+ member(N3, VisitedNodes),
    checkTrust(OpC, N1, N3),
    Lf =< Lr,
    Bf >= Br,
    update(N1, N3, Bf, S1, S2, Br, ServiceRoutes, ServiceRoutes2),
    NewRadius is Radius-1,
    path(OpC, N3, N2, NewRadius, [N3|VisitedNodes], f(S1, S2, Lr, Br), Placement, ServiceRoutes2, NewServiceRoutes).

checkTrust(OpC, N1, N2):-
    node(N1, Op1, _, _),
    node(N2, Op2, _, _),
    trusts2(OpC, Op1),
    trusts2(OpC, Op2).
    
update(N1, N2, _, S1, S2, Br, [], [(N1, N2, Br,[(S1,S2)])]).
update(N1, N2, Bf, S1, S2, Br, [(N1, N2, Ba, L)|ServiceRoutes], [(N1, N2, NewBa, [(S1,S2)|L])|ServiceRoutes]) :- 
    NewBa is Ba+Br,
    NewBa =< Bf.
update(N1, N2, Bf, S1, S2, Br, [(X, Y, Ba, L)|ServiceRoutes], [(X, Y, Ba, L)|NewServiceRoutes]) :-
    N1 \== X,
    N2 \== Y,
    update(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).


trusts(X,X).
trusts2(A,B) :-
    trusts(A,B).
trusts2(A,B) :-
    trusts(A,C),
    trusts2(C,B).

.9::trusts(opC, opZ).
.5::trusts(opZ, op).

chain(opC, chain1, [a,b,c]).
service(a, 10, [t1]).
service(b, 2, []).
service(c, 3, []).
flow(a,b,150,1).
flow(a,c,100,1).

node(n, op, 10, [t2]).
node(m, op, 10, [t1]).
node(v, op, 100, []).
link(n,m, 1, 2).
link(m,n, 1, 2).
link(v,n, 50, 2).
link(n,v, 50, 1).
