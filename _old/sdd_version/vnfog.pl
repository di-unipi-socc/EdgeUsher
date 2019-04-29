:- use_module(library(lists)).
:- use_module(library(cut)).

placement(Chain, Placement, ServiceRoutes, Threshold) :-
    chain(Chain, Services),
    servicePlacement(Services, Placement, [], Threshold), 
    %write(Prob), write('--'), write(Placement),writenl(' - OK'),
    findall(f(S1, S2, Br), flow(S1, S2, Br), ServiceFlows),
    flowPlacement(ServiceFlows, Placement, ServiceRoutes, Threshold).
    %write(ServiceRoutes),writenl(' - OK').

servicePlacement([], [], _, T).
servicePlacement([S|Ss], [on(S,N)|P], AllocatedHW, Threshold) :-
    service(S, _, HW_Reqs, Thing_Reqs, Sec_Reqs),
    node(N, HW_Caps, Thing_Caps, Sec_Caps),
    HW_Reqs =< HW_Caps,
    thingReqsOK(Thing_Reqs, Thing_Caps),
    secReqsOK(Sec_Reqs, Sec_Caps),
    hwReqsOK(HW_Reqs, N, HW_Caps, AllocatedHW, NewAllocatedHW),
    servicePlacement(Ss, P, NewAllocatedHW, Threshold).

thingReqsOK(T_Reqs, T_Caps) :-
    subset(T_Reqs, T_Caps).

hwReqsOK(HW_Reqs, N, _, [], [(N,HW_Reqs)]).
hwReqsOK(HW_Reqs, N, HW_Caps, [(N,A)|As], [(N,NewA)|As]) :-
    NewA is A + HW_Reqs,
    NewA =< HW_Caps.
    hwReqsOK(HW_Reqs, N, HW_Caps, [(N1,A1)|As], [(N1,A1)|NewAs]) :-
    N \== N1,
    hwReqsOK(HW_Reqs, N, HW_Caps, As, NewAs).

secReqsOK([], _).
secReqsOK([SR|SRs], Sec_Caps) :- subset([SR|SRs], Sec_Caps).

secReqsOK(and(P1,P2), Sec_Caps) :- cut(secReqsOK2(P1, Sec_Caps)), cut(secReqsOK2(P2, Sec_Caps)).
secReqsOK(or(P1,P2), Sec_Caps) :- cut(secReqsOK2(P1, Sec_Caps)); cut(secReqsOK2(P2, Sec_Caps)).

secReqsOK2(1, and(P1,P2), Sec_Caps) :- cut(secReqsOK2(P1, Sec_Caps)), cut(secReqsOK2(P2, Sec_Caps)).
secReqsOK2(2, or(P1,P2), Sec_Caps) :- cut(secReqsOK2(P1, Sec_Caps)); cut(secReqsOK2(P2, Sec_Caps)).
secReqsOK2(3, P, Sec_Caps) :- member(P, Sec_Caps). 
flowPlacement(ServiceFlows, Placement, ServiceRoutes, Threshold) :-
    flowPlacement(ServiceFlows, Placement, [], ServiceRoutes, S2S_Latencies, Threshold),
    maxLatenciesOK(S2S_Latencies).

flowPlacement([], _, ServiceRoutes, ServiceRoutes,[], _).
flowPlacement([SF|SFs], Placement, ServiceRoutes, NewServiceRoutes, [SFLatency|S2S_Latencies], Threshold) :-
    servicePath(SF, Placement, ServiceRoutes, ServiceRoutes2, SFLatency, Threshold),
    flowPlacement(SFs, Placement, ServiceRoutes2, NewServiceRoutes, S2S_Latencies, Threshold).

servicePath(f(S1, S2, _), Placement, ServiceRoutes, ServiceRoutes, s2s_lat(S1,S2,0), Threshold) :-
    subset([on(S1,N),on(S2,N)], Placement).

servicePath(f(S1, S2, Br), Placement, ServiceRoutes, NewServiceRoutes, s2s_lat(S1,S2,PathLatency), Threshold) :-
    subset([on(S1,N1),on(S2,N2)], Placement),
    N1 \== N2,
    path(N1, N2, 3, [], f(S1, S2, Br), PathLatency, ServiceRoutes, NewServiceRoutes, Threshold).

path(N1, N2, Radius, _, f(S1, S2, Br), Lf, ServiceRoutes, NewServiceRoutes, Threshold) :-
    Radius > 0,
    link(N1, N2, Lf, Bf),
    Bf >= Br,
    updateSR(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).

path(N1, N2, Radius, VisitedNodes, f(S1, S2, Br), PathLatency, ServiceRoutes, NewServiceRoutes, Threshold) :-
    Radius > 0,
    link(N1, N3, Lf, Bf), N3 \== N2, \+ member(N3, VisitedNodes),
    Bf >= Br,
    updateSR(N1, N3, Bf, S1, S2, Br, ServiceRoutes, ServiceRoutes2),
    NewRadius is Radius-1,
    path(N3, N2, NewRadius, [N3|VisitedNodes], f(S1, S2, Br), PathLatency2, ServiceRoutes2, NewServiceRoutes,Threshold),
    PathLatency is Lf+PathLatency2.

updateSR(N1, N2, _, S1, S2, Br, [], [(N1, N2, Br,[(S1,S2)])]).
updateSR(N1, N2, Bf, S1, S2, Br, [(N1, N2, Ba, L)|ServiceRoutes], [(N1, N2, NewBa, [(S1,S2)|L])|ServiceRoutes]) :-
    NewBa is Ba+Br,
    NewBa =< Bf.
updateSR(N1, N2, Bf, S1, S2, Br, [(X, Y, Ba, L)|ServiceRoutes], [(X, Y, Ba, L)|NewServiceRoutes]) :-
    N1 \== X,
    N2 \== Y,
    updateSR(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).

maxLatenciesOK(S2S_Latencies) :-
    forall(maxLatency(Chain, RequiredLatency), checkLat(Chain, RequiredLatency, S2S_Latencies)).

checkLat(Chain, RequiredLatency, S2S_Latencies) :-
    chainLatency(Chain, S2S_Latencies, Latency),
    Latency =< RequiredLatency.

chainLatency([S], _, S_Service_Time):-
    service(S, S_Service_Time, _, _, _).

chainLatency([S1,S2|RestOfChain], S2S_Latencies, Latency) :-
    member(s2s_lat(S1,S2,Lf), S2S_Latencies),
    service(S1, S1_Service_Time, _, _, _),
    chainLatency([S2|RestOfChain], S2S_Latencies, Latency2),
    Latency is S1_Service_Time+Lf+Latency2.

forall(A, B) :-
\+((A,\+B)).
