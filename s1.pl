:- use_module(library(lists)).

place(C, P, L) :-
    chain(C, Services),
    placeServices(Services, P, []),
    findall(f(N, M, LReq, BReq), (flow(A,B,LReq,BReq), member(p(A,N),P), member(p(B,M), P), M\==N), Flows),
    placeFlows(Flows, P, L),
    checkFlows(Flows,L).


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
    B is min(Bxz, Bzy),
    B >= BReq,
    sumflows(X,Z,Flow,Sum),     
    L is Lxz + Lzy,
    L =< LReq,
    Sum >= BReq.

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
    
    
    
    

query(sumflows(m,n,[f(m,n,1), f(m,n,1)],Sum)).


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
service(b, 2, []).
service(c, 30, []).


flow(a,b,15,1).
flow(a,c,15,1).

node(edge0, OpA, 38, [t2, t4]).
node(edge1, OpA, 50, []).
node(edge2, OpB, 32, [t1, t5]).
node(edge3, OpA, 16, [t3]).
node(edge4, OpA, 39, []).
node(edge5, OpB, 27, []).
node(edge6, OpB, 13, []).
node(edge7, OpA, 40, []).
node(edge8, OpA, 39, []).
node(edge9, OpB, 7, []).
node(edge10, OpB, 27, []).
node(edge11, OpA, 35, []).
node(edge12, OpA, 48, []).
node(edge13, OpA, 50, []).
node(cloud14, OpB, 10000, []).
node(edge15, OpB, 33, []).
node(edge16, OpA, 38, []).
node(edge17, OpB, 1, []).
node(edge18, OpB, 22, []).
node(cloud19, OpB, 10000, []).
node(edge20, OpA, 32, []).
node(edge21, OpA, 7, []).
node(edge22, OpA, 19, []).
node(edge23, OpA, 29, []).
node(edge24, OpA, 27, []).
node(edge25, OpB, 21, []).
node(edge26, OpA, 11, []).
node(edge27, OpB, 9, []).
node(edge28, OpA, 33, []).
node(edge29, OpA, 20, []).
link(edge0, edge4, 24, 39).
link(edge4, edge0, 6, 40).
link(edge0, edge7, 142, 11).
link(edge7, edge0, 53, 36).
link(edge0, edge12, 16, 18).
link(edge12, edge0, 52, 50).
link(edge0, edge24, 139, 26).
link(edge24, edge0, 29, 4).
link(edge1, edge12, 117, 22).
link(edge12, edge1, 128, 16).
link(edge1, edge16, 112, 25).
link(edge16, edge1, 3, 19).
link(edge1, edge22, 141, 19).
link(edge22, edge1, 125, 41).
link(edge1, edge24, 39, 48).
link(edge24, edge1, 112, 21).
link(edge2, edge5, 27, 10).
link(edge5, edge2, 99, 25).
link(edge2, edge7, 16, 38).
link(edge7, edge2, 61, 42).
link(edge2, edge8, 37, 37).
link(edge8, edge2, 25, 36).
link(edge2, edge12, 142, 11).
link(edge12, edge2, 99, 31).
link(edge2, edge18, 146, 28).
link(edge18, edge2, 139, 31).
link(edge2, edge27, 71, 16).
link(edge27, edge2, 111, 5).
link(edge3, edge4, 11, 26).
link(edge4, edge3, 52, 47).
link(edge3, edge8, 45, 24).
link(edge8, edge3, 36, 24).
link(edge3, edge12, 21, 44).
link(edge12, edge3, 20, 14).
link(edge3, edge13, 109, 13).
link(edge13, edge3, 10, 33).
link(edge3, edge15, 73, 33).
link(edge15, edge3, 127, 15).
link(edge3, edge20, 141, 11).
link(edge20, edge3, 148, 19).
link(edge3, edge21, 100, 50).
link(edge21, edge3, 40, 17).
link(edge3, edge26, 142, 16).
link(edge26, edge3, 34, 2).
link(edge3, edge28, 58, 25).
link(edge28, edge3, 79, 1).
link(edge4, edge11, 90, 32).
link(edge11, edge4, 115, 16).
link(edge4, edge22, 72, 8).
link(edge22, edge4, 18, 41).
link(edge4, edge24, 135, 23).
link(edge24, edge4, 91, 19).
link(edge4, edge25, 143, 10).
link(edge25, edge4, 25, 30).
link(edge5, edge24, 145, 22).
link(edge24, edge5, 4, 30).
link(edge5, edge25, 113, 45).
link(edge25, edge5, 134, 49).
link(edge5, edge29, 9, 21).
link(edge29, edge5, 4, 40).
link(edge6, edge7, 73, 40).
link(edge7, edge6, 79, 42).
link(edge6, edge8, 141, 17).
link(edge8, edge6, 4, 3).
link(edge6, edge11, 34, 10).
link(edge11, edge6, 52, 42).
link(edge6, cloud14, 105, 1).
link(cloud14, edge6, 75, 45).
link(edge6, edge15, 31, 13).
link(edge15, edge6, 134, 20).
link(edge6, edge16, 23, 30).
link(edge16, edge6, 46, 12).
link(edge6, edge17, 123, 6).
link(edge17, edge6, 128, 4).
link(edge6, edge18, 103, 19).
link(edge18, edge6, 34, 27).
link(edge6, edge27, 21, 9).
link(edge27, edge6, 56, 49).
link(edge7, edge9, 12, 3).
link(edge9, edge7, 38, 46).
link(edge7, edge10, 97, 21).
link(edge10, edge7, 15, 42).
link(edge7, cloud14, 78, 32).
link(cloud14, edge7, 25, 48).
link(edge7, edge18, 127, 33).
link(edge18, edge7, 124, 40).
link(edge8, edge9, 84, 30).
link(edge9, edge8, 14, 3).
link(edge8, edge13, 47, 34).
link(edge13, edge8, 31, 3).
link(edge8, cloud14, 30, 15).
link(cloud14, edge8, 51, 40).
link(edge8, edge15, 118, 35).
link(edge15, edge8, 10, 27).
link(edge8, edge17, 113, 47).
link(edge17, edge8, 123, 15).
link(edge8, edge18, 102, 42).
link(edge18, edge8, 128, 34).
link(edge8, edge24, 88, 16).
link(edge24, edge8, 56, 17).
link(edge9, edge10, 89, 45).
link(edge10, edge9, 79, 13).
link(edge9, cloud14, 43, 3).
link(cloud14, edge9, 64, 19).
link(edge9, edge23, 83, 16).
link(edge23, edge9, 41, 8).
link(edge9, edge24, 142, 43).
link(edge24, edge9, 56, 14).
link(edge9, edge26, 107, 16).
link(edge26, edge9, 120, 4).
link(edge10, edge11, 85, 34).
link(edge11, edge10, 79, 48).
link(edge10, edge13, 101, 34).
link(edge13, edge10, 93, 19).
link(edge10, edge23, 102, 10).
link(edge23, edge10, 8, 8).
link(edge10, edge24, 41, 22).
link(edge24, edge10, 147, 7).
link(edge10, edge26, 38, 16).
link(edge26, edge10, 139, 14).
link(edge11, edge12, 36, 30).
link(edge12, edge11, 90, 24).
link(edge11, edge15, 45, 49).
link(edge15, edge11, 23, 50).
link(edge11, edge24, 114, 46).
link(edge24, edge11, 5, 19).
link(edge12, edge13, 79, 7).
link(edge13, edge12, 114, 40).
link(edge12, cloud14, 100, 29).
link(cloud14, edge12, 95, 42).
link(edge12, edge16, 42, 11).
link(edge16, edge12, 143, 33).
link(edge12, edge21, 50, 36).
link(edge21, edge12, 88, 50).
link(edge12, edge23, 64, 9).
link(edge23, edge12, 128, 36).
link(edge12, edge26, 90, 8).
link(edge26, edge12, 53, 33).
link(edge12, edge27, 141, 21).
link(edge27, edge12, 149, 43).
link(edge12, edge29, 85, 4).
link(edge29, edge12, 19, 28).
link(edge13, edge18, 50, 28).
link(edge18, edge13, 94, 27).
link(edge13, edge21, 59, 39).
link(edge21, edge13, 4, 21).
link(edge13, edge22, 129, 7).
link(edge22, edge13, 141, 21).
link(edge13, edge27, 35, 50).
link(edge27, edge13, 59, 45).
link(cloud14, edge16, 37, 46).
link(edge16, cloud14, 52, 46).
link(cloud14, edge18, 113, 3).
link(edge18, cloud14, 4, 15).
link(edge15, edge17, 80, 50).
link(edge17, edge15, 12, 50).
link(edge15, edge18, 28, 39).
link(edge18, edge15, 54, 1).
link(edge15, edge22, 127, 42).
link(edge22, edge15, 28, 15).
link(edge16, edge18, 143, 25).
link(edge18, edge16, 85, 31).
link(edge16, edge20, 56, 42).
link(edge20, edge16, 59, 47).
link(edge16, edge25, 15, 32).
link(edge25, edge16, 132, 44).
link(edge16, edge26, 71, 39).
link(edge26, edge16, 11, 42).
link(edge16, edge27, 7, 48).
link(edge27, edge16, 65, 20).
link(edge17, edge26, 145, 9).
link(edge26, edge17, 104, 30).
link(edge17, edge28, 12, 19).
link(edge28, edge17, 29, 45).
link(edge17, edge29, 142, 7).
link(edge29, edge17, 34, 13).
link(edge18, edge22, 119, 7).
link(edge22, edge18, 130, 9).
link(edge18, edge26, 130, 37).
link(edge26, edge18, 53, 6).
link(cloud19, edge28, 27, 29).
link(edge28, cloud19, 132, 50).
link(edge20, edge22, 50, 47).
link(edge22, edge20, 99, 20).
link(edge21, edge22, 149, 4).
link(edge22, edge21, 77, 42).
link(edge22, edge24, 110, 29).
link(edge24, edge22, 67, 22).
link(edge22, edge26, 20, 32).
link(edge26, edge22, 66, 46).
link(edge23, edge28, 44, 9).
link(edge28, edge23, 82, 15).
link(edge24, edge25, 32, 50).
link(edge25, edge24, 24, 4).
link(edge25, edge27, 109, 9).
link(edge27, edge25, 125, 35).
link(edge26, edge28, 23, 15).
link(edge28, edge26, 118, 20).
link(edge27, edge28, 96, 19).
link(edge28, edge27, 53, 5).


query(place(C,P,L)).


%%%%%%%%%
% Utils
%%%%%%%%%

forall(G, C) :- not((G, not(C))).

