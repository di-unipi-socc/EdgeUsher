chain(ucdavis_cctv, [
    cctv_driver1,
    feature_extr1,
    short_term_analytics1,
    alarm_driver1,
    video_compression,
    storage,
    long_term_analytics
   ]).

   service(cctv_driver1, 2,  0.5, [ video10 ], anti_tampering).
   service(feature_extr1, 5,  0.5, [], and(anti_tampering, or(obfuscated_storage, encrypted_storage))).
   service(short_term_analytics1, 2,  0.5, [], and(anti_tampering, and(access_control, or(obfuscated_storage, encrypted_storage)))).
   service(alarm_driver1, 2,  0.5, [ alarm1 ], [ access_control, host_IDS]).
   service(video_compression, 5, 3, [], [pki, firewall, host_IDS]).
   service(storage, 50, 10, [], [backup, pki]).
   service(long_term_analytics, 50, 2, [], and(anti_tampering, and(access_control, or(obfuscated_storage, encrypted_storage)))).

   flow(cctv_driver1, feature_extr1, 8).
   flow(feature_extr1, short_term_analytics1, 5).
   flow(short_term_analytics1, alarm_driver1, .5).
   flow(feature_extr1, video_compression, 5).
   flow(long_term_analytics, short_term_analytics1, 1).

   flow(video_compression, storage, 5).
   flow(storage, long_term_analytics, 3).
   maxLatency([cctv_driver1, feature_extr1, short_term_analytics1, alarm_driver1], 50).


