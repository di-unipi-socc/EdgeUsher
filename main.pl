:- consult('chains/chain.pl').
:- consult('infra/full_probs.pl').

%:- consult('edgeusher.pl').
%query(placement(Chain, Placement, ServiceRoutes)).

:- consult('hedgeusher.pl').
query(placement(Chain, Placement, ServiceRoutes, 0.9, 0.9)).