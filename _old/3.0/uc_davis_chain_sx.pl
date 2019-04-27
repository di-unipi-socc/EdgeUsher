chain(ucdavis_cctv, [
    cctv_driver,
    feature_extr,
    lightweight_analytics,
    alarm_driver, 
    wan_optimiser,
    storage,
    video_analytics
   ]).

   service(cctv_driver, 2,  0.5, [ video1 ], or(anti_tampering, access_control)).
   service(feature_extr, 5, 2, [], and(iot_data_encryption, and(anti_tampering, or(obfuscated_storage, encrypted_storage)))).
   service(lightweight_analytics, 10,  2, [], and(access_control, or(obfuscated_storage, encrypted_storage))).
   service(alarm_driver, 2,  0.5, [ alarm1 ], [ access_control, host_IDS]).
   service(wan_optimiser, 5, 5, [], [pki, firewall, host_IDS]).
   service(storage, 10, 10, [], [backup, pki]).
   service(video_analytics, 40, 16, [], and(resource_monitoring, or(obfuscated_storage, encrypted_storage))).

   flow(cctv_driver, feature_extr, 20).
   flow(feature_extr, lightweight_analytics, 8).
   flow(lightweight_analytics, alarm_driver, .5).
   flow(feature_extr, wan_optimiser, 20).
   flow(wan_optimiser, storage, 15). 
   flow(storage, video_analytics, 10).
   %flow(video_analytics, lightweight_analytics, 0.1).
   

   maxLatency([cctv_driver, feature_extr, lightweight_analytics, alarm_driver], 100).

