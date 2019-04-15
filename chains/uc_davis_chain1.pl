chain(ucdavis_cctv, [
    cctv_driver1,
   feature_extr1,
   short_term_analytics1,
   alarm_driver1,
   cctv_driver2,
   feature_extr2,
   short_term_analytics2,
   alarm_driver2,
   video_compression,
    storage,
    long_term_analytics
   ]).
   service(cctv_driver1, 2,  0.5, [ video1 ],[ ]).
   service(feature_extr1, 5,  0.5, [], [ ]).
   service(short_term_analytics1, 2,  0.5, [], [ ]).
   service(alarm_driver1, 2,  0.5, [ alarm1 ], [ ]).
   flow(cctv_driver1, feature_extr1, 8).
   flow(feature_extr1, short_term_analytics1, 5).
   flow(short_term_analytics1, alarm_driver1, .5).
   flow(feature_extr1, video_compression, 5).
   flow(long_term_analytics, short_term_analytics1, 1).
   maxLatency([cctv_driver1, feature_extr1, short_term_analytics1, alarm_driver1], 50).
   service(cctv_driver2, 2,  0.5, [ video2 ],[ ]).
   service(feature_extr2, 5,  0.5, [], [ ]).
   service(short_term_analytics2, 2,  0.5, [], [ ]).
   service(alarm_driver2, 2,  0.5, [ alarm1 ], [ ]).
   flow(cctv_driver2, feature_extr2, 8).
   flow(feature_extr2, short_term_analytics2, 5).
   flow(short_term_analytics2, alarm_driver2, .5).
   flow(feature_extr2, video_compression, 5).
   flow(long_term_analytics, short_term_analytics2, 1).
   maxLatency([cctv_driver2, feature_extr2, short_term_analytics2, alarm_driver2], 50).
   service(video_compression, 5, 3, [], []).
   service(storage, 50, 10, [], []).
   service(long_term_analytics, 50, 2, [], []).
   flow(video_compression, storage, 5).
   flow(storage, long_term_analytics, 3).

   securityPolicy(X, U).