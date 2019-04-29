:- consult('vnfog.1'). %SDD Library
%:- consult('vnfog'). %No SDD
%:- consult('infrastructures/uc_davis_prob').
:- consult('infrastructures/infrastructure_with_single_probs').
:- consult('chains/uc_davis_chain_sx').


place(C,P,L, Prob) :- 
    cmd_args([A]),atom_number(A,N), N >= 0, N =< 1, 
    placement(C,P,L,N, Prob).

query(place(C,P,L, Prob)).
%query(place(ucdavis_cctv,[on(cctv_driver,parkingServices), on(feature_extr,hoaglandAnnex), on(lightweight_analytics,firePolice), on(alarm_driver,firePolice), on(wan_optimiser,isp), on(storage,isp), on(video_analytics,isp)],[(parkingServices, mannLab, 20, [(cctv_driver, feature_extr)]), (mannLab, hoaglandAnnex, 20, [(cctv_driver, feature_extr)]), (hoaglandAnnex, firePolice, 28, [(feature_extr, wan_optimiser), (feature_extr, lightweight_analytics)]), (firePolice, isp, 20, [(feature_extr, wan_optimiser)])])).
%query(placement(C,P,L,0.2)).

%% On Linux or MacOS launch with vnfog.1 and $ time problog --sdd-auto-gc --sdd-preset-variables main.pl -a .2


