%:- consult('vnfog.1'). %SDD Library
:- consult('vnfog'). %No SDD
:- consult('infrastructures/uc_davis_prob_sx').
:- consult('chains/uc_davis_chain_sx').

query(placement(C,P,L,0.95)).

%% On Linux or MacOS launch with vnfog.1 and $ time problog --sdd-auto-gc --sdd-preset-variables main.pl


