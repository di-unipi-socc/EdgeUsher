%0.2::node(parkingServices, 2, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]);0.8::
node(parkingServices, 1, [video1], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

%0.2::node(westEntry, 2, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]);0.8::
node(westEntry, 1, [], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

%0.2::node(kleiberHall, 2, [video5], [authentication,  anti_tampering,wireless_security,obfuscated_storage]); 0.8::
node(kleiberHall, 1, [video5], [authentication, anti_tampering,wireless_security,obfuscated_storage]).

%% 0.2::node(storerHall, 2, [video10], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]);0.8::
node(storerHall, 1, [video10], [authentication, resource_monitoring, anti_tampering,wireless_security,obfuscated_storage]).

%0.2::node(hoaglandAnnex, 4, [video6], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::
node(hoaglandAnnex, 2, [video6], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

%0.2::node(briggsHall, 4, [video7], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]);0.8::
node(briggsHall, 2, [video7], [authentication, anti_tampering, iot_data_encryption, firewall, pki, wireless_security, encrypted_storage]).

%0.2::node(mannLab, 8, [video3], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::
node(mannLab, 4, [video3], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

%0.2::node(lifeSciences, 8, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::
node(lifeSciences, 4, [video4], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

%0.2::node(sciencesLectureHall, 8, [video8], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::
node(sciencesLectureHall, 4, [video8], [access_logs, authentication, access_control, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

%0.2::node(firePolice, 16, [video2, alarm1], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]);0.8::
node(firePolice, 8, [video2, alarm1], [access_logs, access_control, authentication, backup,resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage]).

%0.2::node(isp, 64, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]);0.8::
node(isp, 32, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).

node(cloud, 10000, [], [access_logs, access_control, authentication, backup, resource_monitoring, iot_data_encryption, firewall, host_IDS, pki, wireless_security, encrypted_storage, anti_tampering,obfuscated_storage]).

link(isp, firePolice, 10, 1000). %;0.2::link(isp, firePolice, 20, 1000).
link(firePolice, isp, 10, 1000).% ;0.2::link(firePolice, isp, 20, 1000).

% ISP-cloud
link(isp, cloud, 50, 10000). % ;0.1::link(isp, cloud, 100, 10000).
link(cloud, isp, 50, 10000). %);0.1::link(cloud, isp, 100, 10000).

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

