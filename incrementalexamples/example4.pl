:-use_module(library(lists)).

placement(Chain, Placement) :-
    chain(Chain, Services),
    servicePlacement(Services, Placement, []).

servicePlacement([], [], _).
servicePlacement([S|Ss], [on(S,N)|P], AllocatedHW) :-
    service(S, HW_Reqs, Thing_Reqs, Sec_Reqs),
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


chain(ucdavis_cctv, [cctv_driver, feature_extr, lw_analytics]).

service(cctv_driver, 1,[video1],
  or(anti_tampering,access_control)).
service(feature_extr, 3,[],
  and(access_control,or(obfuscated_storage,encrypted_storage))).
service(lw_analytics, 5,[],
  and(access_control,and(host_IDS,or(obfuscated_storage,encrypted_storage)))).

node(parkingServices, 1, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).
node(westEntry, 1, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]).
node(lifeSciences, 4, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).
node(firePolice, 8, [video2, alarm1], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

query(placement(C,P)).