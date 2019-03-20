:- use_module(library(lists)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Queries
%%%%%%%%%%%%%%%%%%%%%%%%%%%
query(sumflows(m,n,[f(m,n,1), f(m,n,1)],Sum)).
%query(findpath(m,v,15,1,Flow)).
query(place(C,P,L)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Place Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%
place(C, P, L) :-
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
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

chain(chain1, [a,b,c]).
service(a, 10, [t1]).
service(b, 2, []).
service(c, 3, []).


flow(a,b,150,1).
flow(a,c,100,1).

node(edge0, OpB, 23, []).
node(cloud1, OpA, 10000, []).
node(edge2, OpA, 46, []).
node(edge3, OpA, 39, []).
node(edge4, OpB, 27, [t1]).
node(edge5, OpA, 17, []).
node(edge6, OpA, 49, []).
node(edge7, OpA, 5, []).
node(edge8, OpA, 12, []).
node(edge9, OpB, 9, []).
node(edge10, OpB, 26, []).
node(edge11, OpA, 8, []).
node(edge12, OpA, 22, []).
node(edge13, OpA, 50, []).
node(edge14, OpB, 22, []).
node(edge15, OpB, 5, []).
node(edge16, OpB, 15, []).
node(edge17, OpA, 47, []).
node(cloud18, OpB, 10000, []).
node(edge19, OpB, 18, []).
node(edge20, OpA, 9, []).
node(edge21, OpA, 5, []).
node(edge22, OpA, 34, []).
node(edge23, OpB, 50, []).
node(edge24, OpA, 26, []).
node(edge25, OpA, 5, []).
node(edge26, OpA, 11, []).
node(cloud27, OpB, 10000, []).
node(edge28, OpB, 27, []).
node(edge29, OpB, 40, []).
link(edge0, edge28, 100, 23).
link(edge28, edge0, 136, 11).
link(cloud1, edge4, 29, 27).
link(edge4, cloud1, 140, 45).
link(cloud1, edge17, 136, 1).
link(edge17, cloud1, 59, 45).
link(edge2, edge6, 53, 22).
link(edge6, edge2, 86, 6).
link(edge2, edge25, 142, 15).
link(edge25, edge2, 56, 27).
link(edge3, edge8, 72, 33).
link(edge8, edge3, 19, 41).
link(edge3, edge11, 139, 43).
link(edge11, edge3, 102, 16).
link(edge4, edge21, 13, 11).
link(edge21, edge4, 139, 16).
link(edge5, edge15, 59, 33).
link(edge15, edge5, 49, 43).
link(edge5, edge21, 138, 13).
link(edge21, edge5, 139, 38).
link(edge5, edge23, 76, 4).
link(edge23, edge5, 150, 23).
link(edge6, edge19, 118, 41).
link(edge19, edge6, 46, 24).
link(edge7, edge20, 123, 13).
link(edge20, edge7, 127, 9).
link(edge8, edge9, 113, 30).
link(edge9, edge8, 32, 48).
link(edge10, edge19, 104, 26).
link(edge19, edge10, 138, 15).
link(edge10, edge24, 54, 48).
link(edge24, edge10, 123, 31).
link(edge11, edge13, 69, 28).
link(edge13, edge11, 133, 28).
link(edge11, edge24, 75, 14).
link(edge24, edge11, 119, 22).
link(edge12, edge15, 97, 28).
link(edge15, edge12, 94, 26).
link(edge12, edge16, 81, 35).
link(edge16, edge12, 92, 15).
link(edge12, edge19, 58, 6).
link(edge19, edge12, 79, 33).
link(edge13, edge22, 145, 12).
link(edge22, edge13, 55, 46).
link(edge13, cloud27, 81, 42).
link(cloud27, edge13, 141, 36).
link(edge14, edge15, 18, 12).
link(edge15, edge14, 143, 10).
link(edge15, edge26, 112, 48).
link(edge26, edge15, 111, 50).
link(edge17, edge28, 53, 3).
link(edge28, edge17, 129, 10).
link(cloud18, edge29, 37, 5).
link(edge29, cloud18, 21, 28).
link(edge19, edge20, 44, 50).
link(edge20, edge19, 82, 31).
link(edge23, edge28, 31, 27).
link(edge28, edge23, 18, 9).
link(edge25, edge28, 139, 46).
link(edge28, edge25, 28, 41).
link(edge26, cloud27, 28, 16).
link(cloud27, edge26, 37, 50).
link(cloud27, edge28, 98, 50).
link(edge28, cloud27, 61, 33).
link(edge28, edge29, 15, 29).
link(edge29, edge28, 57, 15).





%%%%%%%%%
% Utils
%%%%%%%%%

forall(G, C) :- not((G, not(C))).

