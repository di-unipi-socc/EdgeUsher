chain(ucdavis_cctv, [
    cctv_driver1,
    feature_extr1,
    lightweight_analytics,
    alarm_driver1,
    wan_optimiser,
    storage,
    long_term_analytics
   ]).

   service(cctv_driver1, 2,  0.5, [ video1 ], or(anti_tampering, access_control)).
   service(feature_extr1, 5, 2, [], and(anti_tampering, or(obfuscated_storage, encrypted_storage)).
   service(lightweight_analytics, 10,  2, [], and(access_control, or(obfuscated_storage, encrypted_storage))).
   service(alarm_driver1, 2,  0.5, [ alarm1 ], [ access_control, host_IDS]).
   service(wan_optimiser, 5, 5, [], [pki, firewall, host_IDS]).
   service(storage, 10, 10, [], [backup, pki]).
   service(long_term_analytics, 40, 8, [], and(access_control, or(obfuscated_storage, encrypted_storage))).

   flow(cctv_driver1, feature_extr1, 20).
   flow(feature_extr1, lightweight_analytics, 8).
   flow(lightweight_analytics, alarm_driver1, .5).
   flow(feature_extr1, wan_optimiser, 20).
   flow(long_term_analytics, lightweight_analytics, 1).

   flow(wan_optimiser, storage, 15).
   flow(storage, long_term_analytics, 50).
   maxLatency([cctv_driver1, feature_extr1, lightweight_analytics, alarm_driver1], 50).


