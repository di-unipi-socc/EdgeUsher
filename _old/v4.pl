:- use_module(library(lists)).

% place(Placement,NewNodes) determines a possible Placement of the services defined by service/3
% on the infrastructure nodes defined by node/4, and returns the nodes (NewNodes) with their HW
% capabilities updated by the Placement

place(Placement,NewNodes) :-
    findall(n(X,Y,W,Z),node(X,Y,W,Z),Nodes),
    findall(s(X,Y,W),service(X,Y,W),Services),
    placement(Services,Nodes,Placement,NewNodes),
    checkFlowsReqs(Placement).

% placement(Cs,Nodes,Placement,NewNodes) given a list of services Cs and a list of Nodes,
% returns a possible Placement of the services and the list of Nodes with their hW capabilities
% HCaps updated
placement([],Nodes,[],Nodes).
placement([s(C,HReqs,TReqs)|Cs],Nodes,[on(C,X)|Ps],NewNodes) :-
	place1(s(C,HReqs,TReqs),Nodes,X,Nodes2),
	placement(Cs,Nodes2,Ps,NewNodes).

place1(s(C,HReqs,TReqs),[n(X,Op,HCaps,TCaps)|Ns],X,[n(X,Op,NewHCaps,TCaps)|Ns]) :-
	subset(TReqs,TCaps),
	HReqs < HCaps,
	NewHCaps is HCaps-HReqs.
place1(C,[N|Ns],X,[N|NewNs]) :-
	place1(C,Ns,X,NewNs).

subset([],_).
subset([R|Rs],TCaps) :-
	member(R,TCaps),
	subset(Rs,TCaps).

% services
service(s1, 3, [thing1]).
service(s2, 3, [thing2]).
service(s3, 3, []).
    flow(s1, s2, 70, 4).
    flow(s2, s3, 59, 2).

% infrastructure/nodes
node(fog1, opA, 8, [thing1]).
node(fog2, opB, 8, [thing2]).
node(cloud1, opC, 100000, [] ).
    link(fog1, fog2, 11, 12).
    link(fog2, cloud1, 58, 8).
    link(fog1, cloud1, 90, 8).
	link(fog2,fog1,3,3).
	link(cloud1,fog1,4,4).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%linked *to be double checked*
linked(X,Y,L,B):-
	link2(X,Y,L,B,[X],Q),
	reverse(Q, Path).

link2(X, Y, Lat, Bw, Visited, [Y|Visited]) :-
    link(X, Y, Lat, Bw).

link2(X, Y, Lat, Bw, Visited, Path) :-
    link(X, Z, LatXZ, BwXZ),
    X \== Z,
    Z \== Y,
    X \== Y,
    \+ member(Z, Visited),
    link2(Z, Y, LatZY, BwZY, [Z|Visited], Path),
    Lat is LatXZ + LatZY,
    Bw is min(BwXZ, BwZY).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
checkFlowsReqs(Placement) :-
    findall(f(X,Y,L,B),flow(X,Y,L,B),Flows),
    checkFlows(Flows,Placement).

checkFlows([],_).
checkFlows([f(S1,S2,L,B)|Fs],P) :-
    member(on(S1,N),P),
    member(on(S2,N),P),
    checkFlows(Fs,P).
checkFlows([f(S1,S2,L,B)|Fs],P) :-
    member(on(S1,N1),P),
    member(on(S2,N2),P),
    writenl(N1,N2),
    writenl(linked(N1,N2,Li,Bi)),
    findall(ld(Li,Bi),linked(N1,N2,Li,Bi),[W|Ws]), %fails if no linked found
    checkEach(L,B,[W|Ws]),
    checkFlows(Fs,P).

checkEach(_,_,[]).
checkEach(L,B,[ld(Li,Bi)|Ls]) :-
    L > Li,
    B < Bi,
    checkEach(L,B,Ls).

% query
 %query(place(P,N)).
query(linked(fog1,cloud1,L,B)).