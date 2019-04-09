node(parkingServices, op, 2, [video1], []).
node(firePolice, op, 16, [video2, alarm1], []).
node(mannLab, op, 8, [video3], []).
node(westEntry, op, 2, [], []).
node(lifeSciences, op, 8, [video4], []).
node(kleiberHall, op, 2, [video5], []).
node(hoaglandAnnex, op, 4, [video6], []).
node(briggsHall, op, 4, [video7], []).
node(sciencesLectureHall, op, 8, [video8], []).
node(sciencesLab, op, 4, [video9], []).
node(storerHall, op, 2, [video10], []).
node(hutchisonHall, op, 8, [video11], []).
node(asmundsonHall, op, 4, [video12], []).
node(robbinsHallAn, op, 4, [], []).
node(robbinsHall, op, 8, [video13], []).
node(kerrHall, op, 2, [video14], []).
node(wellManHall, op, 8, [video15], []).
node(hartHall, op, 2, [video16], []).
node(studentCenter, op, 16, [video17], []).

link(parkingServices, westEntry, 5, 10).
link(parkingServices, lifeSciences, 5, 10).
link(parkingServices, mannLab, 5, 10).

link(westEntry, parkingServices, 5, 10).
link(westEntry, mannLab, 5, 10).
link(westEntry, firePolice, 5, 10).

link(firePolice, westEntry, 5, 10).
link(firePolice, mannLab, 5, 10).
link(firePolice, kleiberHall, 5, 10).
link(firePolice, hoaglandAnnex, 5, 10).

link(mannLab, parkingServices, 5, 10).
link(mannLab, westEntry, 5, 10).
link(mannLab, firePolice, 5, 10).
link(mannLab, lifeSciences, 5, 10).
link(mannLab, briggsHall, 5, 10).
link(mannLab, sciencesLectureHall, 5, 10).
link(mannLab, kleiberHall, 5, 10).
link(mannLab, hoaglandAnnex, 5, 10).

link(hoaglandAnnex, mannLab, 5, 10).
link(hoaglandAnnex, firePolice, 5, 10).
link(hoaglandAnnex, kleiberHall, 5, 10).

link(kleiberHall, hoaglandAnnex, 5, 10).
link(kleiberHall, mannLab, 5, 10).
link(kleiberHall, briggsHall, 5, 10).
link(kleiberHall, firePolice, 5, 10).
link(kleiberHall, sciencesLectureHall, 5, 10).

link(briggsHall, mannLab, 5, 10).
link(briggsHall, lifeSciences, 5, 10).
link(briggsHall, kleiberHall, 5, 10).
link(briggsHall, sciencesLectureHall, 5, 10).
link(briggsHall, studentCenter, 2, 300).

link(lifeSciences, parkingServices, 5, 10).
link(lifeSciences, mannLab, 5, 10).
link(lifeSciences, briggsHall, 5, 10).
link(lifeSciences, studentCenter, 2, 300). %fiber

link(sciencesLectureHall, briggsHall, 5, 10).
link(sciencesLectureHall, mannLab, 5, 10).
link(sciencesLectureHall, kleiberHall, 5, 10).
link(sciencesLectureHall, studentCenter, 2, 300). %fiber

link(sciencesLab, storerHall, 5, 10).
link(sciencesLab, kerrHall, 5, 10).
link(sciencesLab, robbinsHallAn, 5, 10).
link(sciencesLab, robbinsHall, 5, 10).
link(sciencesLab, studentCenter, 2, 300). %fiber

link(storerHall, sciencesLab, 5, 10).
link(storerHall, asmundsonHall, 5, 10).
link(storerHall, kerrHall, 5, 10).
link(storerHall, studentCenter, 2, 300). %fiber

link(asmundsonHall, storerHall, 5, 10).
link(asmundsonHall, hutchisonHall, 5, 10).
link(asmundsonHall, hartHall, 5, 10).
link(asmundsonHall, kerrHall, 5, 10).

link(hutchisonHall, asmundsonHall, 5, 10).
link(hutchisonHall, kerrHall, 5, 10).
link(hutchisonHall, hartHall, 5, 10).

link(kerrHall, asmundsonHall, 5, 10).
link(kerrHall, storerHall, 5, 10).
link(kerrHall, hutchisonHall, 5, 10).
link(kerrHall, sciencesLab, 5, 10).
link(kerrHall, robbinsHallAn, 5, 10).
link(kerrHall, robbinsHall, 5, 10).
link(kerrHall, hartHall, 5, 10).
link(kerrHall, wellManHall, 5, 10).

link(robbinsHallAn, kerrHall, 5, 10).
link(robbinsHallAn, sciencesLab, 5, 10).
link(robbinsHallAn, wellManHall, 5, 10).
link(robbinsHallAn, hartHall, 5, 10).
link(robbinsHallAn, robbinsHall, 5, 10).

link(robbinsHall, kerrHall, 5, 10).
link(robbinsHall, robbinsHallAn, 5, 10).
link(robbinsHall, sciencesLab, 5, 10).
link(robbinsHall, studentCenter, 2, 300). %fiber

link(hartHall, wellManHall, 5, 10).
link(hartHall, kerrHall, 5, 10).
link(hartHall, asmundsonHall, 5, 10).
link(hartHall, robbinsHallAn, 5, 10).
link(hartHall, hutchisonHall, 5, 10).

link(wellManHall, kerrHall, 5, 10).
link(wellManHall, robbinsHallAn, 5, 10).
link(wellManHall, hartHall, 5, 10).



link(studentCenter, sciencesLectureHall, 2, 300). %fiber
link(studentCenter, lifeSciences, 2, 300). %fiber
link(studentCenter, briggsHall, 2, 300). %fiber
link(studentCenter, sciencesLab, 2, 300). %fiber
link(studentCenter, storerHall, 2, 300). %fiber
link(studentCenter, robbinsHall, 2, 300). %fiber

