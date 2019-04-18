% 0.2::node(parkingServices, 2, [video1], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(parkingServices, 1, [video1], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).

% 0.2::node(westEntry, 2, [], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(westEntry, 1, [], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).

% 0.2::node(kleiberHall, 2, [video5], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(kleiberHall, 1, [video5], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).

0.2::node(storerHall, 2, [video10], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(storerHall, 1, [video10], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).

0.2::node(kerrHall, 2, [video14], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(kerrHall, 1, [video14], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).

0.2::node(hartHall, 2, [video16], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::node(hartHall, 1, [video16], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).


% 0.2::node(hoaglandAnnex, 4, [video6], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::node(hoaglandAnnex, 2, [video6], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

% 0.2::node(briggsHall, 4, [video7], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::node(briggsHall, 2, [video7], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

0.2::node(sciencesLab, 4, [video9], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::node(sciencesLab, 2, [video9], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

0.2::node(asmundsonHall, 4, [video12], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::node(asmundsonHall, 2, [video12], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

0.2::node(robbinsHallAn, 4, [], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::node(robbinsHallAn, 2, [], [authentication, resource_monitoring, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).


% 0.2::node(mannLab, 8, [video3], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(mannLab, 4, [video3], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

% 0.2::node(lifeSciences, 8, [video4], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(lifeSciences, 4, [video4], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

% 0.2::node(sciencesLectureHall, 8, [video8], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(sciencesLectureHall, 4, [video8], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.2::node(hutchisonHall, 8, [video11], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(hutchisonHall, 4, [video11], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.2::node(robbinsHall, 8, [video13], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(robbinsHall, 4, [video13], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.2::node(wellManHall, 8, [video15], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(wellManHall, 4, [video15], [access_logs, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).


% 0.2::node(firePolice, 16, [video2, alarm1], [access_logs, access_control, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(firePolice, 8, [video2, alarm1], [access_logs, access_control, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.2::node(studentCenter, 16, [video17,alarm2], [access_logs, access_control, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::node(studentCenter, 8, [video17], [access_logs, access_control, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).


0.2::node(isp, 64, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]);0.8::node(isp, 32, [], [access_logs, access_control, authentication, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).


0.999::node(cloud, 10000, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).


% edge-ISP
0.8::link(isp, studentCenter, 10, 1000);0.2::link(isp, studentCenter, 20, 1000).
0.8::link(studentCenter, isp, 10, 1000);0.2::link(studentCenter, isp, 20, 1000).
% 0.8::link(isp, firePolice, 10, 1000);0.2::link(isp, firePolice, 20, 1000).
% 0.8::link(firePolice, isp, 10, 1000);0.2::link(firePolice, isp, 20, 1000).

% ISP-cloud
0.9::link(isp, cloud, 50, 10000);0.1::link(isp, cloud, 100, 10000).
0.9::link(cloud, isp, 50, 10000);0.1::link(cloud, isp, 100, 10000).

% wireless edge-edge
% 0.98::link(parkingServices, westEntry, 25, 70).
% 0.98::link(parkingServices, lifeSciences, 25, 70).
% 0.98::link(parkingServices, mannLab, 25, 70).

% 0.98::link(westEntry, parkingServices, 25, 70).
% 0.98::link(westEntry, mannLab, 25, 70).
% 0.98::link(westEntry, firePolice, 25, 70).

% 0.98::link(firePolice, westEntry, 25, 70).
% 0.98::link(firePolice, mannLab, 25, 70).
% 0.98::link(firePolice, kleiberHall, 25, 70).
% 0.98::link(firePolice, hoaglandAnnex, 25, 70).

% 0.98::link(mannLab, parkingServices, 25, 70).
% 0.98::link(mannLab, westEntry, 25, 70).
% 0.98::link(mannLab, firePolice, 25, 70).
% 0.98::link(mannLab, lifeSciences, 25, 70).
% 0.98::link(mannLab, briggsHall, 25, 70).
% 0.98::link(mannLab, sciencesLectureHall, 25, 70).
% 0.98::link(mannLab, kleiberHall, 25, 70).
% 0.98::link(mannLab, hoaglandAnnex, 25, 70).

% 0.98::link(hoaglandAnnex, mannLab, 25, 70).
% 0.98::link(hoaglandAnnex, firePolice, 25, 70).
% 0.98::link(hoaglandAnnex, kleiberHall, 25, 70).

% 0.98::link(kleiberHall, hoaglandAnnex, 25, 70).
% 0.98::link(kleiberHall, mannLab, 25, 70).
% 0.98::link(kleiberHall, briggsHall, 25, 70).
% 0.98::link(kleiberHall, firePolice, 25, 70).
% 0.98::link(kleiberHall, sciencesLectureHall, 25, 70).

% 0.98::link(briggsHall, mannLab, 25, 70).
% 0.98::link(briggsHall, lifeSciences, 25, 70).
% 0.98::link(briggsHall, kleiberHall, 25, 70).
% 0.98::link(briggsHall, sciencesLectureHall, 25, 70).


% 0.98::link(lifeSciences, parkingServices, 25, 70).
% 0.98::link(lifeSciences, mannLab, 25, 70).
% 0.98::link(lifeSciences, briggsHall, 25, 70).


% 0.98::link(sciencesLectureHall, briggsHall, 25, 70).
% 0.98::link(sciencesLectureHall, mannLab, 25, 70).
% 0.98::link(sciencesLectureHall, kleiberHall, 25, 70).


0.98::link(sciencesLab, storerHall, 25, 70).
0.98::link(sciencesLab, kerrHall, 25, 70).
0.98::link(sciencesLab, robbinsHallAn, 25, 70).
0.98::link(sciencesLab, robbinsHall, 25, 70).

0.98::link(storerHall, sciencesLab, 25, 70).
0.98::link(storerHall, asmundsonHall, 25, 70).
0.98::link(storerHall, kerrHall, 25, 70).


0.98::link(asmundsonHall, storerHall, 25, 70).
0.98::link(asmundsonHall, hutchisonHall, 25, 70).
0.98::link(asmundsonHall, hartHall, 25, 70).
0.98::link(asmundsonHall, kerrHall, 25, 70).

0.98::link(hutchisonHall, asmundsonHall, 25, 70).
0.98::link(hutchisonHall, kerrHall, 25, 70).
0.98::link(hutchisonHall, hartHall, 25, 70).

0.98::link(kerrHall, asmundsonHall, 25, 70).
0.98::link(kerrHall, storerHall, 25, 70).
0.98::link(kerrHall, hutchisonHall, 25, 70).
0.98::link(kerrHall, sciencesLab, 25, 70).
0.98::link(kerrHall, robbinsHallAn, 25, 70).
0.98::link(kerrHall, robbinsHall, 25, 70).
0.98::link(kerrHall, hartHall, 25, 70).
0.98::link(kerrHall, wellManHall, 25, 70).

0.98::link(robbinsHallAn, kerrHall, 25, 70).
0.98::link(robbinsHallAn, sciencesLab, 25, 70).
0.98::link(robbinsHallAn, wellManHall, 25, 70).
0.98::link(robbinsHallAn, hartHall, 25, 70).
0.98::link(robbinsHallAn, robbinsHall, 25, 70).

0.98::link(robbinsHall, kerrHall, 25, 70).
0.98::link(robbinsHall, robbinsHallAn, 25, 70).
0.98::link(robbinsHall, sciencesLab, 25, 70).


0.98::link(hartHall, wellManHall, 25, 70).
0.98::link(hartHall, kerrHall, 25, 70).
0.98::link(hartHall, asmundsonHall, 25, 70).
0.98::link(hartHall, robbinsHallAn, 25, 70).
0.98::link(hartHall, hutchisonHall, 25, 70).

0.98::link(wellManHall, kerrHall, 25, 70).
0.98::link(wellManHall, robbinsHallAn, 25, 70).
0.98::link(wellManHall, hartHall, 25, 70).


% wired edge-edge

% 0.95::link(sciencesLectureHall, studentCenter, 5, 250);0.05::link(sciencesLectureHall, studentCenter, 15, 150). %fiber
% 0.95::link(studentCenter, sciencesLectureHall, 5, 250);0.05::link(studentCenter, sciencesLectureHall, 15, 150). %fiber

% 0.95::link(lifeSciences, studentCenter, 5, 250);0.05::link(lifeSciences, studentCenter, 15, 150). %fiber
% 0.95::link(studentCenter, lifeSciences, 5, 250);0.05::link(studentCenter, lifeSciences, 15, 150). %fiber

% 0.95::link(briggsHall, studentCenter, 5, 250);0.05::link(briggsHall, studentCenter, 15, 150). %fiber
% 0.95::link(studentCenter, briggsHall, 5, 250);0.05::link(studentCenter, briggsHall, 15, 150). %fiber

0.95::link(sciencesLab, studentCenter, 5, 250);0.05::link(sciencesLab, studentCenter, 15, 150). %fiber
0.95::link(studentCenter, sciencesLab, 5, 250);0.05::link(studentCenter, sciencesLab, 15, 150). %fiber

0.95::link(storerHall, studentCenter, 5, 250);0.05::link(storerHall, studentCenter, 15, 150). %fiber
0.95::link(studentCenter, storerHall, 5, 250);0.05::link(studentCenter, storerHall, 15, 150). %fiber

0.95::link(robbinsHall, studentCenter, 5, 250);0.05::link(robbinsHall, studentCenter, 15, 150). %fiber
0.95::link(studentCenter, robbinsHall, 5, 250);0.05::link(studentCenter, robbinsHall, 15, 150). %fiber
