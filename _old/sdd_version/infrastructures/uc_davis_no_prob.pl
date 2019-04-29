node(parkingServices, 2, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

node(westEntry, 2, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

node(kleiberHall, 2, [video5], [authentication,  anti_tampering,wireless_security,obfuscated_storage]).

node(storerHall, 2, [video10], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

node(kerrHall, 2, [video14], [authentication,  anti_tampering,wireless_security,obfuscated_storage]).

node(hartHall, 2, [video16], [authentication,  anti_tampering,wireless_security,obfuscated_storage]).

node(hoaglandAnnex, 4, [video6], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

node(briggsHall, 4, [video7], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

node(sciencesLab, 4, [video9], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

node(asmundsonHall, 4, [video12], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

node(robbinsHallAn, 4, [], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).


node(mannLab, 8, [video3], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(lifeSciences, 8, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(sciencesLectureHall, 8, [video8], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(hutchisonHall, 8, [video11], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(robbinsHall, 8, [video13], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(wellManHall, 8, [video15], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).


node(firePolice, 16, [video2, alarm1], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(studentCenter, 16, [video17, alarm2], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(isp, 64, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).

node(cloud, 10000, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).


% edge-ISP
link(isp, studentCenter, 10, 1000).
link(studentCenter, isp, 10, 1000).
link(isp, firePolice, 10, 1000).
link(firePolice, isp, 10, 1000).

% ISP-cloud
link(isp, cloud, 50, 10000).
link(cloud, isp, 50, 10000).

% wireless edge-edge
link(parkingServices, westEntry, 25, 70).
link(parkingServices, lifeSciences, 25, 70).
link(parkingServices, mannLab, 25, 70).

link(westEntry, parkingServices, 25, 70).
link(westEntry, mannLab, 25, 70).
link(westEntry, firePolice, 25, 70).

link(firePolice, westEntry, 25, 70).
link(firePolice, mannLab, 25, 70).
link(firePolice, kleiberHall, 25, 70).
link(firePolice, hoaglandAnnex, 25, 70).

link(mannLab, parkingServices, 25, 70).
link(mannLab, westEntry, 25, 70).
link(mannLab, firePolice, 25, 70).
link(mannLab, lifeSciences, 25, 70).
link(mannLab, briggsHall, 25, 70).
link(mannLab, sciencesLectureHall, 25, 70).
link(mannLab, kleiberHall, 25, 70).
link(mannLab, hoaglandAnnex, 25, 70).

link(hoaglandAnnex, mannLab, 25, 70).
link(hoaglandAnnex, firePolice, 25, 70).
link(hoaglandAnnex, kleiberHall, 25, 70).

link(kleiberHall, hoaglandAnnex, 25, 70).
link(kleiberHall, mannLab, 25, 70).
link(kleiberHall, briggsHall, 25, 70).
link(kleiberHall, firePolice, 25, 70).
link(kleiberHall, sciencesLectureHall, 25, 70).

link(briggsHall, mannLab, 25, 70).
link(briggsHall, lifeSciences, 25, 70).
link(briggsHall, kleiberHall, 25, 70).
link(briggsHall, sciencesLectureHall, 25, 70).


link(lifeSciences, parkingServices, 25, 70).
link(lifeSciences, mannLab, 25, 70).
link(lifeSciences, briggsHall, 25, 70).


link(sciencesLectureHall, briggsHall, 25, 70).
link(sciencesLectureHall, mannLab, 25, 70).
link(sciencesLectureHall, kleiberHall, 25, 70).


link(sciencesLab, storerHall, 25, 70).
link(sciencesLab, kerrHall, 25, 70).
link(sciencesLab, robbinsHallAn, 25, 70).
link(sciencesLab, robbinsHall, 25, 70).

link(storerHall, sciencesLab, 25, 70).
link(storerHall, asmundsonHall, 25, 70).
link(storerHall, kerrHall, 25, 70).


link(asmundsonHall, storerHall, 25, 70).
link(asmundsonHall, hutchisonHall, 25, 70).
link(asmundsonHall, hartHall, 25, 70).
link(asmundsonHall, kerrHall, 25, 70).

link(hutchisonHall, asmundsonHall, 25, 70).
link(hutchisonHall, kerrHall, 25, 70).
link(hutchisonHall, hartHall, 25, 70).

link(kerrHall, asmundsonHall, 25, 70).
link(kerrHall, storerHall, 25, 70).
link(kerrHall, hutchisonHall, 25, 70).
link(kerrHall, sciencesLab, 25, 70).
link(kerrHall, robbinsHallAn, 25, 70).
link(kerrHall, robbinsHall, 25, 70).
link(kerrHall, hartHall, 25, 70).
link(kerrHall, wellManHall, 25, 70).

link(robbinsHallAn, kerrHall, 25, 70).
link(robbinsHallAn, sciencesLab, 25, 70).
link(robbinsHallAn, wellManHall, 25, 70).
link(robbinsHallAn, hartHall, 25, 70).
link(robbinsHallAn, robbinsHall, 25, 70).

link(robbinsHall, kerrHall, 25, 70).
link(robbinsHall, robbinsHallAn, 25, 70).
link(robbinsHall, sciencesLab, 25, 70).


link(hartHall, wellManHall, 25, 70).
link(hartHall, kerrHall, 25, 70).
link(hartHall, asmundsonHall, 25, 70).
link(hartHall, robbinsHallAn, 25, 70).
link(hartHall, hutchisonHall, 25, 70).

link(wellManHall, kerrHall, 25, 70).
link(wellManHall, robbinsHallAn, 25, 70).
link(wellManHall, hartHall, 25, 70).


% wired edge-edge

link(sciencesLectureHall, studentCenter, 5, 250). %fiber
link(studentCenter, sciencesLectureHall, 5, 250). %fiber

link(lifeSciences, studentCenter, 5, 250). %fiber
link(studentCenter, lifeSciences, 5, 250). %fiber

link(briggsHall, studentCenter, 5, 250). %fiber
link(studentCenter, briggsHall, 5, 250). %fiber

link(sciencesLab, studentCenter, 5, 250). %fiber
link(studentCenter, sciencesLab, 5, 250). %fiber

link(storerHall, studentCenter, 5, 250). %fiber
link(studentCenter, storerHall, 5, 250). %fiber

link(robbinsHall, studentCenter, 5, 250). %fiber
link(studentCenter, robbinsHall, 5, 250). %fiber