:- consult('vnfog').
:- consult('infrastructures/uc_davis').

chain(chain1, [s1,s2,s3]).


service(s1, 10, 5, [video11], []).
service(s2, 10,  5, [], []).
service(s3, 10,  5, [], []).

flow(s1,s2,2).
flow(s2,s3,2).

maxlatency([s1,s2,s3],100).
maxlatency([s1,s2],100).
maxlatency([s2,s3],100).


query(placement(C,P,L)).