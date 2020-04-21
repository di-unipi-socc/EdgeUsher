:-use_module(library(lists)).

servicePlacement(FId,NId):- service(FId, HWReqs, TReqs),
                            node(NId, HWCaps, TCaps), 
                            hwReqsOK(HWReqs, HWCaps),
                            thingsReqsOK(TReqs, TCaps).
hwReqsOK(HWReqs, HWCaps) :- HWCaps >= HWReqs.
thingsReqsOK(TReqs, TCaps):- subset(TReqs, TCaps).

service(feature_extr, 1, [video1]).
node(parkingServices, 2, [video1]).
node(briggsHall, 2, []).

query(servicePlacement(X,Y)).