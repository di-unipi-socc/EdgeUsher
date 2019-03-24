:- use_module(library(lists)).

findPlacement(Placement,Temp,Temp2) :-
    findall(s(X,Y,W),service(X,Y,W),Services),
    place(Services, [], Placement, [], Flows),
    checkFlows(Placement,Temp,Temp2).

place([],_,[],_,[]).
place([s(C,HReqs,TReqs)|Cs],HWalloc,[on(C,X)|P],FlowAlloc,[F|Fs]) :-
	place1(s(C,HReqs,TReqs),HWalloc,X),
    writenl(P),
	place(Cs,[(X,HReqs)|HWalloc],P).

place1(s(C,HReqs,TReqs),HWAlloc,X) :-
	node(X,_,HCaps,TCaps),
	checkTReqs(TReqs,TCaps),
	checkHReqs(HReqs,X,HCaps,HWAlloc).
    

checkFlows(C, X, P) :-
    writenl(C),
    writenl(X),
    writenl(P),
    findall(out(X, Y, LReq, BReq),(flow(C, D, LReq, BReq), member(to(D, Y), P)), [OutF|Ofs]),
    writenl("HE"),
    findall(in(Y, X, LReq, BReq),(flow(D, C, LReq, BReq), member(to(D, Y), P)), [InF|Infs]).
    

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

query(findPlacement(P,T,T2)).

% services
service(s1, 3, [thing1]).
service(s2, 4, [thing2]).
service(s3, 7, []).
flow(s1, s2, 70, 4).
flow(s2, s3, 59, 2).
% infrastructure/nodes
node(fog1, opA, 7, [thing1]).
node(fog2, opB, 12, [thing2]).
node(cloud1, opC, 100000, []).