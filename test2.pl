%chain(chain1, [s1,s2,s3,s4]).
chain(chain1, [s1,s2]).

service(s1, 10, [t1]).
service(s2, 10, [t2]).
%service(s3, 10, [t3]).
%service(s4, 10, [t3]).

flow(s1,s2,100,2).
%flow(s2,s3,10,6).
%flow(s2,s4,10,7).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
node(n1, op1, 10, [t1]).
node(n2, op1, 10, [t2]).
%node(n3, op1, 20, [t3]).

link(n1, n2, 1, 5).
link(n1, due, 1, 5).
link(due, tre, 1, 5).
    link(due, n1, 1, 5).
link(tre, n2, 1, 5).


%link(n2, n3, 1, 13).

