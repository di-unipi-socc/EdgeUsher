:-use_module(library(lists)).

servicePlacement(FId,NId):- service(FId, HWReqs, TReqs, SecReqs),
                            node(NId, HWCaps, TCaps, SecCaps), 
                            hwReqsOK(HWReqs, HWCaps),
                            thingsReqsOK(TReqs, TCaps),
                            secReqsOK(SecReqs, SecCaps).

hwReqsOK(HWReqs, HWCaps) :- HWCaps >= HWReqs.

thingsReqsOK(TReqs, TCaps):- subset(TReqs, TCaps).

secReqsOK([], _).                  
secReqsOK([SR|SRs], Sec_Caps)   :- subset([SR|SRs], Sec_Caps).
secReqsOK(and(P1,P2), Sec_Caps) :- secReqsOK(P1, Sec_Caps), 
                                   secReqsOK(P2, Sec_Caps).
secReqsOK(or(P1,P2), Sec_Caps)  :- secReqsOK(P1, Sec_Caps); 
                                   secReqsOK(P2, Sec_Caps).
secReqsOK(P, Sec_Caps) :- atom(P), member(P, Sec_Caps).

service(cctv_driver, 1, [video1], or(anti_tampering, access_control)).

node(parkingServices, 2, [video1], [authentication, anti_tampering, wireless_security, obfuscated_storage]).
node(parkingServices2, 4, [video1], [authentication, wireless_security, obfuscated_storage]).
query(servicePlacement(X,Y)).