%% problog -k 'kbest' file
:- use_module(library(lists)).
%:- consult('mini_main').
%:- consult('test0').
%:- consult('uc_davis_no_prob').
:- consult('uc_davis_prob_sx').
:- consult('uc_davis_chain_sx').

query(fullPlacement(C,P)).
fullPlacement(C,P):-placement(C,P),checkLatencies(P).

placement(Chain, Placement) :-
    chain(Chain, Services),
    placement(Services, [], Placement).

placement([], P, P).
placement([S|Ss], P, NewP) :-
    servicePlacementStep(S,P,N,P2),
    %next line finds all flows to service S from another service S0 placed on a node N0 different from N
    findall(nf(S0,N0,S,N,Br), ( flow(S0,S,Br), member((N0,Ss0,_,_), P2), N0\==N, member(S0,Ss0) ), NodeFlows),
    flowPlacementStep(NodeFlows,P2,P3),
    placement(Ss,P3,NewP).

servicePlacementStep(S,P,N,NewP) :-
    service(S, _, HW_Reqs, Thing_Reqs, Sec_Reqs),
    node(N, HW_Caps, Thing_Caps, Sec_Caps),
    HW_Reqs =< HW_Caps,
    thingReqsOK(Thing_Reqs, Thing_Caps),
    secReqsOK(Sec_Reqs, Sec_Caps),             %da "scommentare"
    hwReqsOK(HW_Reqs, N, HW_Caps, S, P, NewP).

thingReqsOK(T_Reqs, T_Caps) :- subset(T_Reqs, T_Caps).

%% sintassi con empty e prop  per eliminare backtracking -- ? sintassi troppo "pesante" ?
% Namely, the security requirements term in service/6 is either "empty" or a term of 
% the kind "list(listOfSecurityProperties)" or an AND/OR composition of security properties.

secReqsOK([], _).
secReqsOK([SR|SRs], Sec_Caps) :- subset([SR|SRs], Sec_Caps).

secReqsOK(and(P1,P2), Sec_Caps) :- secReqsOK2(P1, Sec_Caps), secReqsOK2(P2, Sec_Caps).
secReqsOK(or(P1,P2), Sec_Caps) :- secReqsOK2(P1, Sec_Caps); secReqsOK2(P2, Sec_Caps).

secReqsOK2(and(P1,P2), Sec_Caps) :- secReqsOK2(P1, Sec_Caps), secReqsOK2(P2, Sec_Caps).
secReqsOK2(or(P1,P2), Sec_Caps) :- secReqsOK2(P1, Sec_Caps); secReqsOK2(P2, Sec_Caps).
secReqsOK2(P, Sec_Caps) :- member(P, Sec_Caps).  

% Placement is a list of terms of the kind (n,ss,aa,rs) where
%  -ss is the list of services placed on node n
%  -a is the amount of HW units already allocated on n
%  -rs is a list of service routes, i.e. terms of the form (n2,b,[(sa,sb),(sc,sd),...]) 
%   meaning that link n-n2 is used to route flow from sa to sb, and from sc to sd, ... 
hwReqsOK(HW_Reqs, N, _, S, [], [(N,[S],HW_Reqs,[])]).
hwReqsOK(HW_Reqs, N, HW_Caps, S, [(N,Ss,A,Rs)|P], [(N,[S|Ss],NewA,Rs)|P]) :-
    NewA is A+HW_Reqs, NewA =< HW_Caps.
hwReqsOK(HW_Reqs, N, HW_Caps, S, [(N1,Ss1,A1,Rs1)|P], [(N1,Ss1,A1,Rs1)|NewP]) :-
    N \== N1, hwReqsOK(HW_Reqs, N, HW_Caps, S, P, NewP).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flowPlacementStep([], P, P).
flowPlacementStep([nf(S1,N1,S2,N2,Br)|NFs], P, NewP) :-
    path(S1, N1, S2, N2, Br, 3, [], P, P2),     %3 is the (maximal) radius of paths
    flowPlacementStep(NFs, P2, NewP).

path(S1, N1, S2, N2, Br, Radius, _, P, NewP) :-
    Radius > 0,
    link(N1, N2, _, Bf),
    Bf >= Br,
    update(P, S1, N1, S2, N2, Br, Bf, NewP).

path(S1, N1, S2, N2, Br, Radius, VisitedNodes, P, NewP) :-
    Radius > 0,
    link(N1, N3, _, Bf), N3 \== N2, \+ member(N3, VisitedNodes),
    Bf >= Br,
    update(P, S1, N1, S2, N2, Br, Bf, P2),
    NewRadius is Radius-1,
    path(S1, N1, S2, N2, Br, NewRadius, [N3|VisitedNodes], P2, NewP).
    
update([], S1, N1, S2, N2, Br, _, [(N1,[],0,[(N2,Br,[(S1,S2)])])]).         %case in which N1 is a node with no service deployed on it
update([(N1,Ss1,A1,Rs1)|P], S1, N1, S2, N2, Br, Bf, [(N1,Ss1,A1,NewRs1)|P]) :-
    update2(Rs1, S1, S2, N2, Br, Bf, NewRs1).
update([(N0,Ss0,A0,Rs0)|P], S1, N1, S2, N2, Br, Bf, [(N0,Ss0,A0,Rs0)|NewP]) :-
    N0 \== N1,
    update(P, S1, N1, S2, N2, Br, Bf, NewP).

update2([], S1, S2, N2, Br, _, [(N2,Br,[(S1,S2)])]).    
update2([(N2,Br2,S2Ss)|Rs], S1, S2, N2, Br, Bf, [(N2,NewBr,NewS2Ss)|Rs]) :-
    NewBr is Br2+Br,
    Bf >= NewBr,
    update3(S2Ss,S1,S2,NewS2Ss).
update2([(N0,Br0,S2Ss)|Rs], S1, S2, N2, Br, Bf, [(N0,Br0,S2Ss)|NewRs]) :-
    N0 \== N2,
    update2(Rs, S1, S2, N2, Br, Bf, NewRs).

%forse update3 non è necessaria e potremmo scrivere direttamente (N2,NewBr,[(S1,S2)|S2Ss])
%nella seconda clausola di update2. update3 serve solo a non avere duplicati nel S2Ss di N2.
update3([],S1,S2,[(S1,S2)]).
update3([(S1,S2)|L],S1,S2,[(S1,S2)|L]).
update3([(S3,S4)|L],S1,S2,[(S3,S4)|NewL]) :-
    (S3 \== S1 ; S4 \== S2),
    update3(L,S1,S2,NewL).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Placement is a list of terms of the kind (n,ss,aa,rs) where
%  -ss is the list of services placed on node n
%  -a is the amount of HW units already allocated on n
%  -rs is a list of service routes, i.e. terms of the form (n2,b,[(sa,sb),(sc,sd),...]) 
%   meaning that link n-n2 is used to route flow from sa to sb, and from sc to sd, ... 

checkLatencies(P) :-
    findall(maxLatency(Ss,Lat),maxLatency(Ss,Lat),LSs),
    checkLatencies(LSs,P).
checkLatencies([],_).
checkLatencies([maxLatency(Ss,Lat)|LSs],P) :-
    latency(Ss,P,LatSs),
    Lat >= LatSs,
    checkLatencies(LSs,P).

latency([S],_,ServiceTimeS) :-
   service(S,ServiceTimeS,_,_,_).
 
latency([S1,S2|Ss],P,Lat) :-
    member((N1,Ss1,_,Rs1),P),
    member(S1,Ss1),
    service(S1,ServiceTimeS1,_,_,_),
    member((N2,_,S2Ss),Rs1),
    member((S1,S2),S2Ss),
    link(N1, N2, Lf, _),
    latency([S2|Ss],P,Lat2),       
    Lat is ServiceTimeS1+Lf+Lat2.

    
