:- use_module(library(lists)).
:- consult('test2').
%query(place(C,P,L)).
    
place(Chain, Placement, ServiceRoutes) :-
    chain(Chain, Services),
    placeServices(Services, Placement),
    findall(f(S1, S2, Lr, Br), flow(S1, S2, Lr, Br), ServiceFlows),
    placeFlows(ServiceFlows, Placement, ServiceRoutes),
    writeln(Placement),
    write(ServiceRoutes).

placeServices(Services, Placement) :-
    placeServices(Services, Placement, []).

placeServices([], [], _).
placeServices([S|Ss], [on(S,N)|P], AllocatedHW) :-
    service(S, HW_Reqs, T_Reqs),
    node(N, OpN, HW_Caps, T_Caps),
    checkThingReqs(T_Reqs, T_Caps),
    HW_Reqs =< HW_Caps,
    checkHWReqs(HW_Reqs, N, HW_Caps, AllocatedHW, NewAllocatedHW),
    placeServices(Ss, P, NewAllocatedHW).

checkThingReqs(T_Reqs, T_Caps) :-
    subset(T_Reqs, T_Caps).

checkHWReqs(HW_Reqs, N, HW_Caps, [], [(N,HW_Reqs)]).
checkHWReqs(HW_Reqs, N, HW_Caps, [(N,A)|As], [(N,NewA)|As]) :-
    NewA is A + HW_Reqs,
    NewA =< HW_Caps.
checkHWReqs(HW_Reqs, N, HW_Caps, [(N1,A1)|As], [(N1,A1)|NewAs]) :-
    N \== N1,
    checkHWReqs(HW_Reqs, N, HW_Caps, As, NewAs).

placeFlows(ServiceFlows, Placement, ServiceRoutes) :-
    placeFlows(ServiceFlows, Placement, [], ServiceRoutes).

placeFlows([], _, ServiceRoutes, ServiceRoutes).
placeFlows([SF|SFs], Placement, ServiceRoutes, NewServiceRoutes) :-
    findPath(SF, Placement, ServiceRoutes, ServiceRoutes2),
    placeFlows(SFs, Placement, ServiceRoutes2, NewServiceRoutes).

findPath(f(S1, S2, Lr, Br), Placement, ServiceRoutes, ServiceRoutes) :-
    subset([on(S1,N),on(S2,N)], Placement).

findPath(f(S1, S2, Lr, Br), Placement, ServiceRoutes, NewServiceRoutes) :-
    subset([on(S1,N1),on(S2,N2)], Placement),
    N1 \== N2,
    path(N1, N2, 3, [], f(S1, S2, Lr, Br), Placement, PathLatency, ServiceRoutes, NewServiceRoutes),
    PathLatency =< Lr.

path(N1, N2, Radius, VisitedNodes, f(S1, S2, Lr, Br), Placement, Lf, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N2, Lf, Bf),
    Lf =< Lr,
    Bf >= Br,
    update(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).

path(N1, N2, Radius, VisitedNodes, f(S1, S2, Lr, Br), Placement, PathLatency, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N3, Lf, Bf), N3 \== N2, \+ member(N3, VisitedNodes),
    Lf =< Lr,
    Bf >= Br,
    update(N1, N3, Bf, S1, S2, Br, ServiceRoutes, ServiceRoutes2),
    NewRadius is Radius-1,
    path(N3, N2, NewRadius, [N3|VisitedNodes], f(S1, S2, Lr, Br), Placement, PathLatency2, ServiceRoutes2, NewServiceRoutes),
    PathLatency is Lf+PathLatency2.

update(N1, N2, _, S1, S2, Br, [], [(N1, N2, Br,[(S1,S2)])]).
update(N1, N2, Bf, S1, S2, Br, [(N1, N2, Ba, L)|ServiceRoutes], [(N1, N2, NewBa, [(S1,S2)|L])|ServiceRoutes]) :- 
    NewBa is Ba+Br,
    NewBa =< Bf.
update(N1, N2, Bf, S1, S2, Br, [(X, Y, Ba, L)|ServiceRoutes], [(X, Y, Ba, L)|NewServiceRoutes]) :-
    N1 \== X,
    N2 \== Y,
    update(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).