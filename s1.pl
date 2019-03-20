:- use_module(library(lists)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Queries
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%query(sumflows(m,n,[f(m,n,1), f(m,n,1)],Sum)).
%query(findpath(m,v,15,1,Flow)).
query(place(C,P)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Place Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%
place(C, P) :-
    chain(C, Services),
    placeServices(Services, P, []),
    findall(f(N, M, LReq, BReq), (flow(A,B,LReq,BReq), member(p(A,N),P), member(p(B,M), P), M\==N), Flows),
    placeFlows(Flows, P, L).


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
    B is min(Bxz, Bzy),
    B >= BReq,
    L is Lxz + Lzy,
    L =< LReq,
    sumflows(X,Z,Flow,Sum),     
    B - Sum >= BReq.

sumflows(X,Z,[],0).
sumflows(X,Z,[f(A,B,BReq)],BReq):-
    A == X,
    B == Z.
sumflows(X,Z,[f(A,B,BReq)],0):-
    A \== X,
    B \== Z.
sumflows(X,Z,[f(A,B,BReq)|Flow],Sum):-
    A == X,
    B == Z,
    sumflows(X,Z,Flow,Sum1),
    Sum is Sum1 + BReq.
sumflows(X,Z,[f(A,B,BReq)|Flow],Sum):-
    A \== X,
    B \== Z,
    sumflows(X,Z,Flow,Sum).
    
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Placement of Services
%%%%%%%%%%%%%%%%%%%%%%%%%
placeServices([], [], _).
placeServices([S|Ss], [p(S,N)|P], Alloc) :-
    service(S, HReqs, TReqs),
    node(N, OpN, HCaps, TCaps),
    subset(TReqs, TCaps),
    HCaps >= HReqs,
    checkHardware(N, HCaps, [a(N, HReqs)|Alloc]),
    placeServices(Ss, P, [a(N, HReqs)|Alloc]).

checkHardware(N, HCaps, Alloc) :-
    findall(HAll, member(a(N,HAll), Alloc), H),
    sum_list(H, Sum),
    Sum =< HCaps.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trust
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trusts(X,X).
trusts2(A,B) :-
    trusts(A,B).
trusts2(A,B) :-
    trusts(A,C),
    trusts2(C,B).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
% Example
%%%%%%%%%%%%%%%%%%%%%%%%%

chain(chain1, [a,b,c]).
service(a, 10, [t1]).
service(b, 2, []).
service(c, 3, []).

securityRequirements(chain1, N) :-
    physical_security(N),
    public_key_cryptography(N),
    authentication(N).


flow(a,b,150,1).
flow(a,c,100,1).

node(n, op, 10, [t2]).
node(m, op, 10, [t1]).
node(v, op, 100, []).
link(n,m, 1, 2).
link(m,n, 1, 2).
link(v,n, 50, 2).
link(n,v, 50, 1).



%%%%%%%%%
% Utils
%%%%%%%%%

forall(G, C) :- not((G, not(C))).

