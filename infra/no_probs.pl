node(parkingServices, 1, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

node(westEntry, 1, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

node(kleiberHall, 1, [video5], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

node(hoaglandAnnex, 2, [video6], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

node(briggsHall, 2, [video7], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

node(mannLab, 4, [video3], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(lifeSciences, 4, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(sciencesLectureHall, 4, [video8], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(firePolice, 8, [video2, alarm1], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).


node(studentCenter, 8, [video17], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

node(isp, 32, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).

node(cloud, 10000, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).


link(isp, firePolice, 10, 1000).
link(firePolice, isp, 10, 1000).
link(isp, studentCenter, 10, 1000).
link(studentCenter, isp, 10, 1000).


link(isp, cloud, 50, 10000).
link(cloud, isp, 50, 10000).

link(parkingServices, westEntry, 15, 70).
link(parkingServices, lifeSciences, 15, 70).
link(parkingServices, mannLab, 15, 70).

link(westEntry, parkingServices, 15, 70).
link(westEntry, mannLab, 15, 70).
link(westEntry, firePolice, 15, 70).

link(firePolice, westEntry, 15, 70).
link(firePolice, mannLab, 15, 70).
link(firePolice, kleiberHall, 15, 70).
link(firePolice, hoaglandAnnex, 15, 70).

link(mannLab, parkingServices, 15, 70).
link(mannLab, westEntry, 15, 70).
link(mannLab, firePolice, 15, 70).
link(mannLab, lifeSciences, 15, 70).
link(mannLab, briggsHall, 15, 70).
link(mannLab, sciencesLectureHall, 15, 70).
link(mannLab, kleiberHall, 15, 70).
link(mannLab, hoaglandAnnex, 15, 70).

link(hoaglandAnnex, mannLab, 15, 70).
link(hoaglandAnnex, firePolice, 15, 70).
link(hoaglandAnnex, kleiberHall, 15, 70).

link(kleiberHall, hoaglandAnnex, 15, 70).
link(kleiberHall, mannLab, 15, 70).
link(kleiberHall, briggsHall, 15, 70).
link(kleiberHall, firePolice, 15, 70).
link(kleiberHall, sciencesLectureHall, 15, 70).

link(briggsHall, mannLab, 15, 70).
link(briggsHall, lifeSciences, 15, 70).
link(briggsHall, kleiberHall, 15, 70).
link(briggsHall, sciencesLectureHall, 15, 70).


link(lifeSciences, parkingServices, 15, 70).
link(lifeSciences, mannLab, 15, 70).
link(lifeSciences, briggsHall, 15, 70).


link(sciencesLectureHall, briggsHall, 15, 70).
link(sciencesLectureHall, mannLab, 15, 70).
link(sciencesLectureHall, kleiberHall, 15, 70).

% wired edge-edge

link(sciencesLectureHall, studentCenter, 5, 250).
link(studentCenter, sciencesLectureHall, 5, 250).

link(lifeSciences, studentCenter, 5, 250).
link(studentCenter, lifeSciences, 5, 250).
link(briggsHall, studentCenter, 5, 250).
link(studentCenter, briggsHall, 5, 250).

