chain(ucdavis_cctv, [
    a,
    b
   ]).

   service(a, 5,  2, [], or(p1, and(p0, p2))).
   service(b, 5, 3, [], []).

   flow(a, b, 2).
   %flow(b, a, 2).

   maxLatency([a, b], 20).
