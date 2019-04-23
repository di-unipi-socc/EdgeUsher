chain(ucdavis_cctv, [
   cctv_driver1,
   feature_extr1,
   short_term_analytics1
   %alarm_driver1,
   %video_compression,
   % storage,
   % long_term_analytics
   ]).
   service(cctv_driver1, 2,  1, [ video1 ],[ ]).
   service(feature_extr1, 5,  1, [], [ ]).
   service(short_term_analytics1, 2,  0.5, [], [ ]).
   %service(alarm_driver1, 2,  1, [ alarm1 ], [ ]).
   %service(video_compression, 5, 3, [], []).
   %service(storage, 50, 10, [], []).
   %service(long_term_analytics, 50, 2, [], []).

   flow(cctv_driver1, feature_extr1, 8).
   %flow(feature_extr1, short_term_analytics1, 5).
   %flow(short_term_analytics1, alarm_driver1, .5).
   %flow(feature_extr1, video_compression, 5).
   %flow(long_term_analytics, short_term_analytics1, 1).
   %flow(video_compression, storage, 5).
   %flow(storage, long_term_analytics, 3).
   %maxLatency([cctv_driver1, feature_extr1, short_term_analytics1, alarm_driver1], 50).
%ADDED
maxLatency([cctv_driver1, feature_extr1], 50).
