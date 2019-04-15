:- use_module(library(lists)).

% placement(Chain, Placement, ServiceRoutes) - determines a Placement and corresponding ServiceRoutes for a VNF Chain;
%   Checks all IoT, hardware, security, bandwidth and latency requirements of Chain.
%   Fails if no valid placement exists.
placement(Chain, Placement, ServiceRoutes) :-
    chain(Chain, Services),
    servicePlacement(Services, Placement),
    writenl(Placement),
    findall(f(S1, S2, Br), flow(S1, S2, Br), ServiceFlows),
    flowPlacement(ServiceFlows, Placement, ServiceRoutes).

% servicePlacement(Services, Placement) - helper predicate.
servicePlacement(Services, Placement) :-
    servicePlacement2(Services, Placement, []).

% servicePlacement2(Services, Placement, AllocatedHW) - exploits backtracking to determine a Placement for all Services in a VNF chain;
%   Checks IoT, hardware, and security requirements of each service.
%   If multiple services are deployed to the same node, it checks cumulative hardware requirements.
servicePlacement2([], [], _).
servicePlacement2([S|Ss], [on(S,N)|P], AllocatedHW) :-
    service(S, _, HW_Reqs, Thing_Reqs, Sec_Reqs),
    node(N, HW_Caps, Thing_Caps, Sec_Caps),
    HW_Reqs =< HW_Caps,
    hwReqsOK(HW_Reqs, N, HW_Caps, AllocatedHW, NewAllocatedHW),
    secReqsOK(S, Sec_Reqs, Sec_Caps),
    thingReqsOK(Thing_Reqs, Thing_Caps),
    servicePlacement2(Ss, P, NewAllocatedHW).


% thingReqsOK(T_Reqs, T_Caps) - checks if T_Reqs ⊆ T_Caps, i.e. if all IoT requirements are satisfied by the available Things.
thingReqsOK(T_Reqs, T_Caps) :-
    subset(T_Reqs, T_Caps).

% hwReqsOK(HW_Reqs, N, HW_Caps, AllocatedHWOld, AllocatedHWNew) -  checks cumulative hardware requirements;
%   If more than one service is deployed to the same node it sums
%   all services requirements in terms of hardware H_Reqs and checks them against
%   the available resources HW_Caps. Returns update allocation if it succeeds.
%   Fails if available resources are not enough.
hwReqsOK(HW_Reqs, N, _, [], [(N,HW_Reqs)]).
hwReqsOK(HW_Reqs, N, HW_Caps, [(N,A)|As], [(N,NewA)|As]) :-
    NewA is A + HW_Reqs,
    NewA =< HW_Caps.
hwReqsOK(HW_Reqs, N, HW_Caps, [(N1,A1)|As], [(N1,A1)|NewAs]) :-
    N \== N1,
    hwReqsOK(HW_Reqs, N, HW_Caps, As, NewAs).

% secReqsOK(S, Sec_Reqs, SecCaps) - checks security requirements of service S;
%   if a complex securityPolicy is available, it checks if it holds,
%   otherwise simply checks if Sec_Reqs ⊆ SecCaps.
secReqsOK(S, Sec_Reqs, SecCaps) :-
    securityPolicy(S, SecCaps); % should be specified by the user
    subset(Sec_Reqs, SecCaps). % default behaviour

% flowPlacement(ServiceFlows, Placement, ServiceRoutes) - determine valid ServiceRoutes for the ServiceFlows a placed VNF chain;
%   Checks bandwidth requirements and maxLatency requirements specified on service paths.
%   Fails if no valid route exists.
flowPlacement(ServiceFlows, Placement, ServiceRoutes) :-
    flowPlacement(ServiceFlows, Placement, [], ServiceRoutes, S2S_Latencies),
    maxLatenciesOK(S2S_Latencies).

% flowPlacement(ServiceFlows, Placement, ServiceRoutes) - updates ServiceRoutes when a path is found for ServiceFlows.   
flowPlacement([], _, ServiceRoutes, ServiceRoutes,[]).
flowPlacement([SF|SFs], Placement, ServiceRoutes, NewServiceRoutes, [SFLatency|S2S_Latencies]) :-
    servicePath(SF, Placement, ServiceRoutes, ServiceRoutes2, SFLatency),
    flowPlacement(SFs, Placement, ServiceRoutes2, NewServiceRoutes, S2S_Latencies).

% servicePath(ServiceFlow, Placement, Route, NewRoute, PathLatency) - determines a valid Route for a given ServiceFlow between two services;
%   Succeeds if S1, S2 are placed on the same node, or
%   if there exists a path (i.e. route) of length at most 5 between their deployment nodes.
servicePath(f(S1, S2, _), Placement, ServiceRoutes, ServiceRoutes, s2s_lat(S1,S2,0)) :-
    subset([on(S1,N),on(S2,N)], Placement).
servicePath(f(S1, S2, Br), Placement, ServiceRoutes, NewServiceRoutes, s2s_lat(S1,S2,PathLatency)) :-
    subset([on(S1,N1),on(S2,N2)], Placement),
    N1 \== N2,
    path(N1, N2, 2, [], f(S1, S2, Br), PathLatency, ServiceRoutes, NewServiceRoutes).

% path(N1, N2, Radius, VisitedNs, f(S1, S2, Br), Lf, ServiceRoutes, NewServiceRoutes) - looks for a path between nodes N1 and N2;
%   Paths can be at most of lenght Radius.
%   Checks cumulative bandwidth requirements when multiple services communicate over the same links.
%   Fails if no path exists.
path(N1, N2, Radius, _, f(S1, S2, Br), Lf, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N2, Lf, Bf),
    Bf >= Br,
    updateSR(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).
path(N1, N2, Radius, VisitedNodes, f(S1, S2, Br), PathLatency, ServiceRoutes, NewServiceRoutes) :-
    Radius > 0,
    link(N1, N3, Lf, Bf), N3 \== N2, \+ member(N3, VisitedNodes),
    Bf >= Br,
    updateSR(N1, N3, Bf, S1, S2, Br, ServiceRoutes, ServiceRoutes2),
    NewRadius is Radius-1,
    path(N3, N2, NewRadius, [N3|VisitedNodes], f(S1, S2, Br), PathLatency2, ServiceRoutes2, NewServiceRoutes),
    PathLatency is Lf+PathLatency2.

% updateSR(N1, N2, _, S1, S2, Br, [], [(N1, N2, Br,[(S1,S2)])]) - updates ServiceRoutes. 
updateSR(N1, N2, _, S1, S2, Br, [], [(N1, N2, Br,[(S1,S2)])]).
updateSR(N1, N2, Bf, S1, S2, Br, [(N1, N2, Ba, L)|ServiceRoutes], [(N1, N2, NewBa, [(S1,S2)|L])|ServiceRoutes]) :- 
    NewBa is Ba+Br,
    NewBa =< Bf.
updateSR(N1, N2, Bf, S1, S2, Br, [(X, Y, Ba, L)|ServiceRoutes], [(X, Y, Ba, L)|NewServiceRoutes]) :-
    N1 \== X,
    N2 \== Y,
    updateSR(N1, N2, Bf, S1, S2, Br, ServiceRoutes, NewServiceRoutes).

% maxLatenciesOK(S2S_Latencies) - checks if all maxLatency requirements of a chain are satisfied.
%   S2S_Latencies contains the latency of determined service-to-service routes.
%   It also considers the processing time of each service.
maxLatenciesOK(S2S_Latencies) :-
    findall(maxlat(Chain, RequiredLatency), maxlatency(Chain, RequiredLatency), L),
    maxLatenciesOK(L, S2S_Latencies).
    
maxLatenciesOK([],_).
maxLatenciesOK([maxlat(Chain,RequiredLatency)|L], S2S_Latencies) :-
    chainLatency(Chain, S2S_Latencies, Latency),
    Latency =< RequiredLatency,
    maxLatenciesOK(L, S2S_Latencies).

chainLatency([S], _, S_Service_Time):-
    service(S, S_Service_Time, _, _, _).

chainLatency([S1,S2|RestOfChain], S2S_Latencies, Latency) :-
    member(s2s_lat(S1,S2,Lf), S2S_Latencies),
    service(S1, S1_Service_Time, _, _, _),
    chainLatency([S2|RestOfChain], S2S_Latencies, Latency2),
    Latency is S1_Service_Time+Lf+Latency2.