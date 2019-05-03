0.8::node(parkingServices, 1, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

0.8::node(westEntry, 1, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

0.8::node(kleiberHall, 1, [video5], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

0.8::node(hoaglandAnnex, 2, [video6], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

0.8::node(briggsHall, 2, [video7], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

0.8::node(mannLab, 4, [video3], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.8::node(lifeSciences, 4, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.8::node(sciencesLectureHall, 4, [video8], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.8::node(firePolice, 8, [video2, alarm1], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).


0.8::node(studentCenter, 8, [video17], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

0.8::node(isp, 32, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).

0.999::node(cloud, 10000, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).


0.8::link(isp, firePolice, 10, 1000).
0.8::link(firePolice, isp, 10, 1000).
0.8::link(isp, studentCenter, 10, 1000).
0.8::link(studentCenter, isp, 10, 1000).


0.9::link(isp, cloud, 50, 10000).
0.9::link(cloud, isp, 50, 10000).

0.98::link(parkingServices, westEntry, 15, 70).
0.98::link(parkingServices, lifeSciences, 15, 70).
0.98::link(parkingServices, mannLab, 15, 70).

0.98::link(westEntry, parkingServices, 15, 70).
0.98::link(westEntry, mannLab, 15, 70).
0.98::link(westEntry, firePolice, 15, 70).

0.98::link(firePolice, westEntry, 15, 70).
0.98::link(firePolice, mannLab, 15, 70).
0.98::link(firePolice, kleiberHall, 15, 70).
0.98::link(firePolice, hoaglandAnnex, 15, 70).

0.98::link(mannLab, parkingServices, 15, 70).
0.98::link(mannLab, westEntry, 15, 70).
0.98::link(mannLab, firePolice, 15, 70).
0.98::link(mannLab, lifeSciences, 15, 70).
0.98::link(mannLab, briggsHall, 15, 70).
0.98::link(mannLab, sciencesLectureHall, 15, 70).
0.98::link(mannLab, kleiberHall, 15, 70).
0.98::link(mannLab, hoaglandAnnex, 15, 70).

0.98::link(hoaglandAnnex, mannLab, 15, 70).
0.98::link(hoaglandAnnex, firePolice, 15, 70).
0.98::link(hoaglandAnnex, kleiberHall, 15, 70).

0.98::link(kleiberHall, hoaglandAnnex, 15, 70).
0.98::link(kleiberHall, mannLab, 15, 70).
0.98::link(kleiberHall, briggsHall, 15, 70).
0.98::link(kleiberHall, firePolice, 15, 70).
0.98::link(kleiberHall, sciencesLectureHall, 15, 70).

0.98::link(briggsHall, mannLab, 15, 70).
0.98::link(briggsHall, lifeSciences, 15, 70).
0.98::link(briggsHall, kleiberHall, 15, 70).
0.98::link(briggsHall, sciencesLectureHall, 15, 70).


0.98::link(lifeSciences, parkingServices, 15, 70).
0.98::link(lifeSciences, mannLab, 15, 70).
0.98::link(lifeSciences, briggsHall, 15, 70).


0.98::link(sciencesLectureHall, briggsHall, 15, 70).
0.98::link(sciencesLectureHall, mannLab, 15, 70).
0.98::link(sciencesLectureHall, kleiberHall, 15, 70).

% wired edge-edge

0.95::link(sciencesLectureHall, studentCenter, 5, 250).
0.95::link(studentCenter, sciencesLectureHall, 5, 250).

0.95::link(lifeSciences, studentCenter, 5, 250).
0.95::link(studentCenter, lifeSciences, 5, 250).
0.95::link(briggsHall, studentCenter, 5, 250).
0.95::link(studentCenter, briggsHall, 5, 250).

