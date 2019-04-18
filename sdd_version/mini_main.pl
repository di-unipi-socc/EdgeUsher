:- consult('vnfog').

0.2::node(nodeA, 2, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(nodeA, 1, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).
0.2::node(nodeB, 2, [video2], [authentication, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(nodeB, 1, [video2], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

0.98::link(nodeA, nodeB, 25, 70).
0.98::link(nodeB, nodeA, 25, 70).

chain(ucdavis_cctv, [
    cctv_driver,
    feature_extr
   ]).

   service(cctv_driver, 2,  0.5, [video1], or(anti_tampering, access_control)).
   service(feature_extr, 5, 0.5, [], and(anti_tampering, or(obfuscated_storage, encrypted_storage))).

   flow(cctv_driver, feature_extr, 20).
   flow(feature_extr, cctv_driver, 8).

   maxLatency([cctv_driver, feature_extr], 35).




query(placement(C,P,L,0.9)).


