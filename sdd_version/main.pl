:- consult('vnfog.1'). %SDD Library
%:- consult('vnfog'). %No SDD
:- consult('infrastructures/uc_davis_prob_sx').
:- consult('chains/uc_davis_chain_sx').

place(C,P,L) :- 
    cmd_args([A]),atom_number(A,N), N >= 0, N =< 1, 
    placement(C,P,L,N).

query(place(C,P,L)).

%query(placement(C,P,L,0.2)).

%% On Linux or MacOS launch with vnfog.1 and $ time problog --sdd-auto-gc --sdd-preset-variables main.pl -a .2


