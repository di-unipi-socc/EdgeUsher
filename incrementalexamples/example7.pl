:- use_module(library(lists)).

placement(Chain, Placement, ServiceRoutes, THw, TQoS) :-
    chain(Chain, Services),
    subquery(servicePlacement(Services, Placement), PHw),
    PHw >= THw,
    flowPlacement(Placement, ServiceRoutes, TQoS).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
servicePlacement(Services, Placement) :-
    servicePlacement(Services, Placement, []).

servicePlacement([], [], _).
servicePlacement([S|Ss], [on(S,N)|P], AllocatedHW) :-
    service(S, _, HW_Reqs, Thing_Reqs, Sec_Reqs),
    node(N, HW_Caps, Thing_Caps, Sec_Caps),
    HW_Reqs =< HW_Caps,
    thingReqsOK(Thing_Reqs, Thing_Caps),
    secReqsOK(Sec_Reqs, Sec_Caps),
    hwReqsOK(HW_Reqs, HW_Caps, N, AllocatedHW, NewAllocatedHW),
    servicePlacement(Ss, P, NewAllocatedHW).

thingReqsOK(T_Reqs, T_Caps) :- subset(T_Reqs, T_Caps).

secReqsOK([SR|SRs], Sec_Caps) :- subset([SR|SRs], Sec_Caps).
secReqsOK(and(P1,P2), Sec_Caps) :- secReqsOK(P1, Sec_Caps), secReqsOK(P2, Sec_Caps).
secReqsOK(or(P1,P2), Sec_Caps) :- secReqsOK(P1, Sec_Caps); secReqsOK(P2, Sec_Caps).
secReqsOK(P, Sec_Caps) :- atom(P), member(P, Sec_Caps).

hwReqsOK(HW_Reqs, _, N, [], [(N,HW_Reqs)]).
hwReqsOK(HW_Reqs, HW_Caps, N, [(N,A)|As], [(N,NewA)|As]) :-
    HW_Reqs + A =< HW_Caps, NewA is A + HW_Reqs.
hwReqsOK(HW_Reqs, HW_Caps, N, [(N1,A1)|As], [(N1,A1)|NewAs]) :-
    N \== N1, hwReqsOK(HW_Reqs, HW_Caps, N, As, NewAs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flowPlacement(Placement, ServiceRoutes, TQoS) :-
    findall(flow(S1, S2, Br), flow(S1, S2, Br), ServiceFlows),
    flowPlacement(ServiceFlows, Placement, [], ServiceRoutes, [], S2S_latencies, TQoS),
    maxLatency(LChain, RequiredLatency),   %hp: only one maxLatency def
    latencyOK(LChain, RequiredLatency, S2S_latencies).

flowPlacement([], _, SRs, SRs, Lats, Lats, TQoS).
flowPlacement([flow(S1, S2, _)|SFs], P, SRs, NewSRs, Lats, NewLats, TQoS) :-
        subset([on(S1,N), on(S2,N)], P),
        flowPlacement(SFs, P, SRs, NewSRs, [(S1,S2,0)|Lats], NewLats, TQoS). 
flowPlacement([flow(S1, S2, Br)|SFs], P, SRs, NewSRs, Lats, NewLats, TQoS) :-
        subset([on(S1,N1), on(S2,N2)], P),
        N1 \== N2,
        subquery(path(N1, N2, 2, [], Path, 0, Lat), PQoS),
        PQoS >= TQoS,
        update(Path, Br, S1, S2, SRs, SR2s),
        flowPlacement(SFs, P, SR2s, NewSRs, [(S1,S2,Lat)|Lats], NewLats, TQoS). 

 path(N1, N2, Radius, Path, [(N1, N2, Bf)|Path], Lat, NewLat) :-
    Radius > 0,
    link(N1, N2, Lf, Bf),
    NewLat is Lat + Lf.

 path(N1, N2, Radius, Path, NewPath, Lat, NewLat) :-
    Radius > 0,
    link(N1, N12, Lf, Bf), N12 \== N2, \+ member((N12,_,_,_), Path),
    NewRadius is Radius-1,
    Lat2 is Lat + Lf,
    path(N12, N2, NewRadius, [(N1, N12, Bf)|Path], NewPath, Lat2, NewLat).

update([],_,_,_,SRs,SRs).
update([(N1, N2, Bf)|Path], Br, S1, S2, SRs, NewSRs) :-
    updateOne((N1, N2, Bf), Br, S1, S2, SRs, SR2s),
    update(Path, Br, S1, S2, SR2s, NewSRs).

updateOne((N1, N2, Bf), Br, S1, S2, [], [(N1, N2, Br, [(S1,S2)])]) :-
    Br =< Bf.
updateOne((N1, N2, Bf), Br, S1, S2, [(N1, N2, Bass, S2Ss)|SR], [(N1, N2, NewBa, [(S1,S2)|S2Ss])|SR]) :- 
    Br =< Bf-Bass, NewBa is Br+Bass.
updateOne((N1, N2, Bf), Br, S1, S2, [(X, Y, Bass, S2Ss)|SR], [(X, Y, Bass, S2Ss)|NewSR]) :-
    (N1 \== X; N2 \== Y),
    updateOne((N1, N2, Bf), Br, S1, S2, SR, NewSR).

latencyOK(LChain, RequiredLatency, S2S_latencies) :-
    chainLatency(LChain, S2S_latencies, 0, ChainLatency),
    ChainLatency =< RequiredLatency.

chainLatency([S], _, Latency, NewLatency) :-
    service(S, S_Service_Time, _, _, _),
    NewLatency is Latency + S_Service_Time.
chainLatency([S1,S2|LChain], S2S_latencies, Latency, NewLatency) :-
    member((S1,S2,Lf), S2S_latencies),
    service(S1, S1_Service_Time, _, _, _),
    Latency2 is Latency+S1_Service_Time+Lf,
    chainLatency([S2|LChain], S2S_latencies, Latency2, NewLatency).
chain(ucdavis_cctv, [cctv_driver, feature_extr, lw_analytics]).

service(cctv_driver, 2, 1, [ video1 ], or(anti_tampering,access_control)).
service(feature_extr, 5, 3, [], and(access_control, or(obfuscated_storage, encrypted_storage))). 
service(lw_analytics, 10, 5, [], and(access_control, and(host_IDS, or(obfuscated_storage,encrypted_storage)))).

flow(cctv_driver, feature_extr, 15).                        
flow(feature_extr, lw_analytics, 8).
maxLatency([cctv_driver, feature_extr, lw_analytics], 50).

0.2::node(parkingServices, 2, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]);
0.8::node(parkingServices, 1, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

0.2::node(westEntry, 2, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]);
0.8::node(westEntry, 1, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

0.2::node(lifeSciences, 8, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);
0.8::node(lifeSciences, 4, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.2::node(firePolice, 16, [video2, alarm1], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);
0.8::node(firePolice, 8, [video2, alarm1], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.98::link(parkingServices, westEntry, 15, 70).
0.98::link(westEntry, parkingServices, 15, 70).
0.98::link(parkingServices, lifeSciences, 15, 70).
0.98::link(lifeSciences, parkingServices, 15, 70).
0.98::link(westEntry, firePolice, 15, 70).
0.98::link(firePolice, westEntry, 15, 70).

query(placement(ucdavis_cctv,P,R,0.9,0.9)).
