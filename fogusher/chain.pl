chain(ucdavis_cctv, [
    cctv_driver,
    feature_extr,
    lightweight_analytics,
    alarm_driver, 
    wan_optimiser,
    storage,
    video_analytics
   ]).

% service(S, ServiceTime, HW_Reqs, Thing_Reqs, Sec_Reqs)                                                                                                    %AB p()
service(cctv_driver, 2,             0.5, [ video1 ], or(anti_tampering,access_control)).
service(feature_extr, 5,            4.5,   [],       and(iot_data_encryption, or(anti_tampering, or(obfuscated_storage, encrypted_storage)))).  %AB HW_Reqs: 2 -> 4.5
service(lightweight_analytics, 10,  4.5, [],         and(access_control, or(obfuscated_storage,encrypted_storage))).                              %AB HW_Reqs: 2 -> 4.5
service(alarm_driver, 2,            0.5, [ alarm1 ], [access_control, host_IDS]).
service(wan_optimiser, 5,           5,   [],         [pki, firewall, host_IDS]).
service(storage, 10,               10,   [],         [backup, pki]).                                                                 
service(video_analytics, 40,       16,   [],         and(resource_monitoring,or(obfuscated_storage,encrypted_storage))).




flow(cctv_driver, feature_extr, 1).                                                                                                                         %AB 20->1
flow(feature_extr, lightweight_analytics, 8).
flow(lightweight_analytics, alarm_driver, 0.5).

flow(feature_extr, wan_optimiser, 20).
flow(wan_optimiser, storage, 15). 
flow(storage, video_analytics, 10).
   
maxLatency([cctv_driver, feature_extr, lightweight_analytics, alarm_driver], 200).

