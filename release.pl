:- use_module(library(lists)).

%Prima versione che determina possibili placement controllando 
%sia vincoli su HW e Things dei nodi che vincoli di latenza e
%banda sul flow tra i servizi.
%KNOWN LIMITATIONS: 
%1-per ora considera solo link diretti (ovvero path lunghi 1)

query(findPlacement(P,T,T2)).

findPlacement(Placement,Temp,Temp2) :-
    findall(s(X,Y,W),service(X,Y,W),Services),
    place(Services,[],Placement),
    checkFlows(Placement,Temp,Temp2).

place([],_,[]).
place([s(C,HReqs,TReqs)|Cs],HWalloc,[on(C,X)|P]) :-
	place1(s(C,HReqs,TReqs),HWalloc,X),
	place(Cs,[(X,HReqs)|HWalloc],P).

place1(s(C,HReqs,TReqs),HWAlloc,X) :-
	node(X,_,HCaps,TCaps),
	checkTReqs(TReqs,TCaps),
	checkHReqs(HReqs,X,HCaps,HWAlloc).

checkTReqs([],_).
checkTReqs([R|Rs],TCaps) :-
	member(R,TCaps),
	checkTReqs(Rs,TCaps).

checkHReqs(HReqs,X,HCaps,Alloc) :-
	sumAlloc(X,Alloc,TotAllocX),
	UpdatedHCaps is HCaps-TotAllocX,
	HReqs < UpdatedHCaps.
	
sumAlloc(X,[],0).
sumAlloc(X,[(X,K)|Ls],NewS) :-
	sumAlloc(X,Ls,S),
	NewS is S+K.
sumAlloc(X,[(Y,K)|Ls],S) :-
   	X \== Y,
	sumAlloc(X,Ls,S).

checkFlows(Placement,NodeFlows,Paths) :-
	findall(f(X,Y,L,B),flow(X,Y,L,B),ServiceFlows),
	findNodeFlows(ServiceFlows,Placement,[],NodeFlows),
	findPaths(NodeFlows,[],[],Paths). 

findNodeFlows([],_,NFs,NFs).
findNodeFlows([f(X,Y,L,B)|SFs],P,NFs,NewNFs) :-
	member(on(X,Nx),P),
	member(on(Y,Ny),P),
	fupdate(nf(Nx,Ny,L,B),NFs,NFs2),
	findNodeFlows(SFs,P,NFs2,NewNFs).

fupdate(nf(N,N,_,_),NFs,NFs).
fupdate(nf(Nx,Ny,L,B),[],[nf(Nx,Ny,L,B)]) :-
	Nx \== Ny.
fupdate(nf(Nx,Ny,L,B),[nf(Nx,Ny,Lxy,Bxy)|NFs],[nf(Nx,Ny,Ln,Bn)|NFs]):-
	Nx \== Ny,
	Ln is min(L,Lxy),
	Bn is B+Bxy.
fupdate(nf(Nx,Ny,L,B),[nf(Nw,Nz,Lwz,Bwz)|NFs],[nf(Nw,Nz,Lwz,Bwz)|NewNFs]):-
	Nx \== Ny,
	(Nx \== Nw; Ny \== Nz),
	fupdate(nf(Nx,Ny,L,B),NFs,NewNFs).

findPaths([],_,Ps,Ps).
findPaths([nf(Nx,Ny,L,B)|NFs],Bag,Ps,NewPs) :-
    link(Nx,Ny,Ll,Bl),
    Ll < L,
    Bl > B,
    findPaths(NFs,[link(Nx,Ny,Ll,Bl)|Bag],[[Nx,Ny]|Ps],NewPs).

findPaths([nf(Nx,Ny,L,B)|NFs],Bag,Ps,NewPs) :-
    link(Nx,Nz,L1,B1),
    link(Nz,Ny,L2,B2),
    L1 + L2 < L,
    min(B1,B2) > B,
    findPaths(NFs,[link(Nx,Nz,L1,B1), link(Nz,Ny,L2,B2)|Bag],[[Nx,Nz,Ny]|Ps],NewPs).

findPaths([nf(Nx,Ny,L,B)|NFs],Bag,Ps,NewPs) :-
    link(Nx,Nz,L1,B1),
    link(Nz,Nw,L2,B2),
    link(Nw,Ny,L3,B3),
    L1 + L2 + L3 < L,
    min(min(B1,B2),B3) > B,
    findPaths(NFs,[link(Nx,Nz,L1,B1), link(Nz,Nw,L2,B2), link(Nw,Ny,L3,B3)|Bag],[[Nx,Nz,Nw,Ny]|Ps],NewPs).





% services
service(s1, 3, [thing1]).
service(s2, 4, [thing2]).
service(s3, 7, []).
flow(s1, s3, 100, 2).
flow(s1, s2, 70, 4).
flow(s2, s3, 59, 1).

% infrastructure/nodes
node(fog1, opA, 8, [thing1]).
node(fog2, opB, 12, [thing2]).
node(cloud1, opC, 1, []).
node(cloud2, opD, 100000, []).

link(fog1, fog2, 11, 12).
link(fog2, cloud1, 55, 8).
link(cloud1, fog1, 90, 8).
link(cloud1, cloud2, 1, 10).
%link(cloud2, fog, 1, 10).

   
