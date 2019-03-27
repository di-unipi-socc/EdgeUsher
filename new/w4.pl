:- use_module(library(lists)).
:- consult('test5').
query(place(C,P,L)).
    
place(Chain, Placement, ServiceRoutes) :-
    chain(OpC, Chain, Services),
    placeServices(OpC, Services, Placement),
    findall(f(S1, S2, Br), flow(S1, S2, Br), ServiceFlows),
    placeFlows(ServiceFlows, Placement, ServiceRoutes),
    writenl(Placement),
    writenl(ServiceRoutes).

placeServices(OpC, Services, Placement) :-
    placeServices(OpC, Services, Placement, []).

placeServices(_, [], [], _).
placeServices(OpC,[S|Ss], [on(S,N)|P], AllocatedHW) :-
    service(S, HW_Reqs, T_Reqs, T_Proc, Sec_Reqs),
    node(N, OpN, HW_Caps, T_Caps),
    checkThingReqs(T_Reqs, T_Caps),
    HW_Reqs =< HW_Caps,
    trusts2(OpC, OpN),
    checkHWReqs(HW_Reqs, N, HW_Caps, AllocatedHW, NewAllocatedHW),
    checkSecReqs(Sec_Reqs, N),
    placeServices(OpC, Ss, P, NewAllocatedHW).

checkSecReqs([], N).
checkSecReqs([SR|SRs], N) :-
    secProp(N, SR),
    checkSecReqs(SRs, N).

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
    placeFlows(ServiceFlows, Placement, [], ServiceRoutes, S2SLatencies),
 %   writenl(S2SLatencies),
    checkMaxLatencies(S2SLatencies).

placeFlows([], _, ServiceRoutes, ServiceRoutes,[]).
placeFlows([SF|SFs], Placement, ServiceRoutes, NewServiceRoutes, [SFLatency|S2SLatencies]) :-
    findPath(SF, Placement, ServiceRoutes, ServiceRoutes2, SFLatency),
    placeFlows(SFs, Placement, ServiceRoutes2, NewServiceRoutes, S2SLatencies).


%assumo per ora che ci sia una sola maxlatency/2 p.e. maxlatency([s1,s2,s3],4).

checkMaxLatencies(S2SLatencies):-
    forall(maxlatency(Chain, RequiredLatency), checkLatencies(Chain, RequiredLatency, S2SLatencies)).

checkLatencies(Chain, RequiredLatency, S2SLatencies):-
    %maxlatency(Chain, RequiredLatency), 
    computeLatency(Chain, S2SLatencies, FeaturedLatency),
    write('Chain latency computed: '), writenl(FeaturedLatency),
    FeaturedLatency =< RequiredLatency,
    writenl('OK').

computeLatency([S], _, 0). %TODO: Capire se vogliamo considerare T_Proc anche per l'ultimo servizio!
computeLatency([S1,S2|RestOfChain], S2SLatencies, FeaturedLatency) :-
    member(s2slat(S1,S2,Lf), S2SLatencies),
    service(S1, _, _, T_Proc, _),
    computeLatency([S2|RestOfChain], S2SLatencies, FeaturedLatency2),
    FeaturedLatency is Lf+T_Proc+FeaturedLatency2.

findPath(f(S1, S2, Br), Placement, ServiceRoutes, ServiceRoutes, s2slat(S1,S2,0)) :-
    subset([on(S1,N),on(S2,N)], Placement).

findPath(f(S1, S2, Br), Placement, ServiceRoutes, NewServiceRoutes, s2slat(S1,S2,PathLatency)) :-
    subset([on(S1,N1),on(S2,N2)], Placement),
    N1 \== N2,
    path(N1, N2, 3, [], f(S1, S2, Br), Placement, PathLatency, ServiceRoutes, NewServiceRoutes).
%    PathLatency =< Lr.

path(N1, N2, Radius, VisitedNodes, f(S1, S2, Br), Placement, Lf, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N2, Lf, Bf),
 %   Lf =< Lr,
    Bf >= Br,
    update(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).

path(N1, N2, Radius, VisitedNodes, f(S1, S2, Br), Placement, PathLatency, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N3, Lf, Bf), N3 \== N2, \+ member(N3, VisitedNodes),
 %   Lf =< Lr,
    Bf >= Br,
    update(N1, N3, Bf, S1, S2, Br, ServiceRoutes, ServiceRoutes2),
    NewRadius is Radius-1,
    path(N3, N2, NewRadius, [N3|VisitedNodes], f(S1, S2, Br), Placement, PathLatency2, ServiceRoutes2, NewServiceRoutes),
    PathLatency is Lf+PathLatency2.

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% UTILS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
forall(A, B) :- \+((A,\+B)).