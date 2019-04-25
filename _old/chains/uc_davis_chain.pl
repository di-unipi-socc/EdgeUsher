
chain(ucdavis_cctv, [
       cctv_driver1,
       feature_extr1,
       short_term_analytics1,
       alarm_driver1,
       cctv_driver2,
       feature_extr2,
       short_term_analytics2,
       alarm_driver2,
       cctv_driver3,
       feature_extr3,
       short_term_analytics3,
       alarm_driver3,
       cctv_driver4,
       feature_extr4,
       short_term_analytics4,
       alarm_driver4,
       cctv_driver5,
       feature_extr5,
       short_term_analytics5,
       alarm_driver5,
       cctv_driver6,
       feature_extr6,
       short_term_analytics6,
       alarm_driver6,
       cctv_driver7,
       feature_extr7,
       short_term_analytics7,
       alarm_driver7,
       cctv_driver8,
       feature_extr8,
       short_term_analytics8,
       alarm_driver8,
       cctv_driver9,
       feature_extr9,
       short_term_analytics9,
       alarm_driver9,
       cctv_driver10,
       feature_extr10,
       short_term_analytics10,
       alarm_driver10,
       cctv_driver11,
       feature_extr11,
       short_term_analytics11,
       alarm_driver11,
       cctv_driver12,
       feature_extr12,
       short_term_analytics12,
       alarm_driver12,
       cctv_driver13,
       feature_extr13,
       short_term_analytics13,
       alarm_driver13,
       cctv_driver14,
       feature_extr14,
       short_term_analytics14,
       alarm_driver14,
       cctv_driver15,
       feature_extr15,
       short_term_analytics15,
       alarm_driver15,
       cctv_driver16,
       feature_extr16,
       short_term_analytics16,
       alarm_driver16,
       cctv_driver17,
       feature_extr17,
       short_term_analytics17,
       alarm_driver17,
       %common functions
       video_compression,
       storage,
       long_term_analytics
       ]).

% service(S, T_proc, HW_Reqs, Thing_Reqs, Sec_Reqs),
service(cctv_driver1, 2,  0.5, [ video1 ],[ anti_tampering ]).
service(cctv_driver2, 2,  0.5, [ video2 ],[ anti_tampering ]).
service(cctv_driver3, 2,  0.5, [ video3 ],[ anti_tampering ]).
service(cctv_driver4, 2,  0.5, [ video4 ],[ anti_tampering ]).
service(cctv_driver5, 2,  0.5, [ video5 ],[ anti_tampering ]).
service(cctv_driver6, 2,  0.5, [ video6 ],[ anti_tampering ]).
service(cctv_driver7, 2,  0.5, [ video7 ],[ anti_tampering ]).
service(cctv_driver8, 2,  0.5, [ video8 ],[ anti_tampering ]).
service(cctv_driver9, 2,  0.5, [ video9 ],[ anti_tampering ]).
service(cctv_driver10, 2,  0.5, [ video10 ],[ anti_tampering ]).
service(cctv_driver11, 2,  0.5, [ video11 ],[ anti_tampering ]).
service(cctv_driver12, 2,  0.5, [ video12 ],[ anti_tampering ]).
service(cctv_driver13, 2,  0.5, [ video13 ],[ anti_tampering ]).
service(cctv_driver14, 2,  0.5, [ video14 ],[ anti_tampering ]).
service(cctv_driver15, 2,  0.5, [ video15 ],[ anti_tampering ]).
service(cctv_driver16, 2,  0.5, [ video16 ],[ anti_tampering ]).
service(cctv_driver17, 2,  0.5, [ video17 ],[ anti_tampering ]).

flow(s1,s2,2).
flow(s2,s3,2).

maxlatency([s1,s2,s3],100).
maxlatency([s1,s2],100).
maxlatency([s2,s3],100).


query(placement(C,P,L)).