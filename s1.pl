:- use_module(library(lists)).

place(C, P, L) :-
    chain(C, Services),
    placeServices(Services, P, []),
    findall(f(N, M, LReq, BReq), (flow(A,B,LReq,BReq), member(p(A,N),P), member(p(B,M), P), M\==N), Flows),
    placeFlows(Flows, P, L),
    checkFlows(Flows,L).




%%%%%%%%%%%%%%%%%%%%%%%%%
%% Placement of Flows
%%%%%%%%%%%%%%%%%%%%%%%%%



placeFlows([], P, []).
placeFlows([f(N,M,LReq,BReq)|Fs], P, [A1|Alloc]):-
    findpath(N,M,LReq,BReq,A1),
    placeFlows(Fs, P, Alloc).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X, Y nodi,
% Visited nodi visitati,
% Path, percorso nodi visitati,
% L, B latenza e banda del percorso
% LReq, BReq latenza e banda richiesti sul percorso,
% Flow taccuino per ricordare i flussi mappati su un certo link.

%findpath(X,Y,Path,L,B,LReq,BReq,Flow) :-
findpath(X,Y,LReq,BReq,Flow) :-
    path(X,Y,[X],Q,L,B,LReq,BReq,Flow,4), %%% arrives at depth 4 
    reverse(Q,Path),
    X \== Y.

path(X,Y,P,[Y|P],L,B,LReq,BReq,[f(X,Y,BReq)],D) :- 
    D > 0,
    link(X, Y, L, B),
    L =< LReq,
    B >= BReq.
path(X,Y,Visited,Path,L,B,LReq,BReq,[f(X,Z,BReq)|Flow],D) :-
    D > 0,
    link(X, Z, Lxz, Bxz),           
    Z \== Y,
    \+ member(Z,Visited),
    D1 is D - 1,
    path(Z,Y,[Z|Visited],Path,Lzy,Bzy,LReq,BReq,Flow,D1),
    L is Lxz + Lzy,
    B is min(Bxz, Bzy),
    L =< LReq,
    B >= BReq.


query(findpath(m,v,15,1,Flow)).


%%%%%%%%%%%%%%%%%%%%%%%%%
%% Placement of Services
%%%%%%%%%%%%%%%%%%%%%%%%%
placeServices([], [], _).
placeServices([S|Ss], [p(S,N)|P], Alloc) :-
    service(S, HReqs, TReqs),
    node(N, OpN, HCaps, TCaps),
    subset(TReqs, TCaps),
    checkHardware(N, HCaps, [a(N, HReqs)|Alloc]),
    placeServices(Ss, P, [a(N, HReqs)|Alloc]).

checkHardware(N, HCaps, Alloc) :-
    findall(HAll, member(a(N,HAll), Alloc), H),
    sum_list(H, Sum),
    Sum =< HCaps.
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

chain(chain1, [a,b,c]).
service(a, 10, [t1]).
service(b, 5, []).
service(c, 5, []).


flow(a,b,15,1).
flow(a,c,15,1).


node(n, op, 10, [t2]).
node(m, op, 10, [t1]).


link(n,m, 1, 2).
link(m,n, 1, 1).
link(v,n, 1, 1).
link(n,v, 1, 1).

query(place(C,P,L)).


%%%%%%%%%
% Utils
%%%%%%%%%

forall(G, C) :- not((G, not(C))).
