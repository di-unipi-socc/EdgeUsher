chain(chain1, [s1,s2,s3]).

service(s1, 10, [t1], 5).
service(s2, 10, [t2], 5).
service(s3, 10, [t3], 5).

flow(s1,s2,2).
flow(s2,s3,2).

maxlatency([s1,s2,s3],15).
maxlatency([s1,s2],6).

%%%%%%%%%%%%%%%%%%%%%%
%  n7 <-- n8 <-- n9  %
%  ^      ^      ^   %
%  |      |      |   %
%  n4     n5     n6  %
%  ^      ^      ^   %
%  |      |      |   %
%  n1 --> n2 --> n3  %
%%%%%%%%%%%%%%%%%%%%%%

node(n1, op1, 10, [t1]).
node(n2, op1, 9, [t1]).
node(n3, op1, 10, [t1]).

node(n4, op1, 9, [t2]).
node(n5, op1, 10, [t2]).
node(n6, op1, 10, [t2]).

node(n7, op1, 10, [t3]).
node(n8, op1, 9, [t3]).
node(n9, op1, 9, [t3]).

link(n1, n2, 1, 5).
link(n2, n3, 1, 5).
link(n9, n8, 1, 5).
link(n8, n7, 1, 5).

link(n1, n4, 1, 5).
link(n4, n7, 1, 5).
link(n2, n5, 1, 5).
link(n5, n8, 1, 5).
link(n3, n6, 1, 5).
link(n6, n9, 1, 5).
