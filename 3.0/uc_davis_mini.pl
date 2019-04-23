node(parkingServices, 2, [video1], [ anti_tampering ]).
node(firePolice, 16, [video2, alarm1], []).
node(mannLab, 8, [video3], []).
node(westEntry, 2, [], []).
node(lifeSciences, 8, [video4], []).
node(kleiberHall, 2, [video5], []).
node(hoaglandAnnex, 4, [video6], []).
node(briggsHall, 4, [video7], []).
node(sciencesLectureHall, 8, [video8], []).
node(sciencesLab, 4, [video9], []).
node(storerHall, 2, [video10], []).
node(studentCenter, 16, [video17], []).
node(isp, 64, [], []).
node(cloud, 10000, [], []).


% edge-ISP
0.8::link(isp, studentCenter, 10, 1000);0.2::link(isp, studentCenter, 20, 1000).
0.8::link(studentCenter, isp, 10, 1000);0.2::link(studentCenter, isp, 20, 1000).
0.8::link(isp, firePolice, 10, 1000);0.2::link(isp, firePolice, 20, 1000).
0.8::link(firePolice, isp, 10, 1000);0.2::link(firePolice, isp, 20, 1000).

% ISP-cloud
0.9::link(isp, cloud, 50, 10000);0.1::link(isp, cloud, 100, 10000).
0.9::link(cloud, isp, 50, 10000);0.1::link(cloud, isp, 100, 10000).

0.98::link(parkingServices, westEntry, 25, 70).
0.98::link(parkingServices, lifeSciences, 25, 70).
0.98::link(parkingServices, mannLab, 25, 70).

0.98::link(westEntry, parkingServices, 25, 70).
0.98::link(westEntry, mannLab, 25, 70).
0.98::link(westEntry, firePolice, 25, 70).

0.98::link(firePolice, westEntry, 25, 70).
0.98::link(firePolice, mannLab, 25, 70).
0.98::link(firePolice, kleiberHall, 25, 70).
0.98::link(firePolice, hoaglandAnnex, 25, 70).

0.98::link(mannLab, parkingServices, 25, 70).
0.98::link(mannLab, westEntry, 25, 70).
0.98::link(mannLab, firePolice, 25, 70).
0.98::link(mannLab, lifeSciences, 25, 70).
0.98::link(mannLab, briggsHall, 25, 70).
0.98::link(mannLab, sciencesLectureHall, 25, 70).
0.98::link(mannLab, kleiberHall, 25, 70).
0.98::link(mannLab, hoaglandAnnex, 25, 70).

0.98::link(hoaglandAnnex, mannLab, 25, 70).
0.98::link(hoaglandAnnex, firePolice, 25, 70).
0.98::link(hoaglandAnnex, kleiberHall, 25, 70).

0.98::link(kleiberHall, hoaglandAnnex, 25, 70).
0.98::link(kleiberHall, mannLab, 25, 70).
0.98::link(kleiberHall, briggsHall, 25, 70).
0.98::link(kleiberHall, firePolice, 25, 70).
0.98::link(kleiberHall, sciencesLectureHall, 25, 70).

0.98::link(briggsHall, mannLab, 25, 70).
0.98::link(briggsHall, lifeSciences, 25, 70).
0.98::link(briggsHall, kleiberHall, 25, 70).
0.98::link(briggsHall, sciencesLectureHall, 25, 70).
0.95::link(briggsHall, studentCenter, 5, 250);0.05::link(briggsHall, studentCenter, 15, 150). %fiber

0.98::link(lifeSciences, parkingServices, 25, 70).
0.98::link(lifeSciences, mannLab, 25, 70).
0.98::link(lifeSciences, briggsHall, 25, 70).
0.95::link(lifeSciences, studentCenter, 5, 250);0.05::link(lifeSciences, studentCenter, 15, 150). %fiber

0.98::link(sciencesLectureHall, briggsHall, 25, 70).
0.98::link(sciencesLectureHall, mannLab, 25, 70).
0.98::link(sciencesLectureHall, kleiberHall, 25, 70).
0.95::link(sciencesLectureHall, studentCenter, 5, 250);0.05::link(sciencesLectureHall, studentCenter, 15, 150). %fiber

0.98::link(sciencesLab, storerHall, 25, 70).
0.95::link(sciencesLab, studentCenter, 5, 250);0.05::link(sciencesLab, studentCenter, 15, 150). %fiber

0.98::link(storerHall, sciencesLab, 25, 70).
0.95::link(storerHall, studentCenter, 5, 250);0.05::link(storerHall, studentCenter, 15, 150). %fiber

0.95::link(studentCenter, sciencesLectureHall, 5, 250);0.05::link(studentCenter, sciencesLectureHall, 15, 150). %fiber
0.95::link(studentCenter, lifeSciences, 5, 250);0.05::link(studentCenter, lifeSciences, 15, 150). %fiber
0.95::link(studentCenter, briggsHall, 5, 250);0.05::link(studentCenter, briggsHall, 15, 150). %fiber
0.95::link(studentCenter, sciencesLab, 5, 250);0.05::link(studentCenter, sciencesLab, 15, 150). %fiber
0.95::link(studentCenter, storerHall, 5, 250);0.05::link(studentCenter, storerHall, 15, 150). %fiber
