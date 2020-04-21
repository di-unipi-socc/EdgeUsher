servicePlacement(FId,NId):- service(FId, HWReqs),
                            node(NId, HWCaps), 
                            hwReqsOK(HWReqs, HWCaps).
hwReqsOK(HWReqs, HWCaps) :- HWCaps >= HWReqs.

service(feature_extr, 5).
node(studentCenter, 8).
node(briggsHall, 2).

query(servicePlacement(X,Y)).