result = "chain(ucdavis_cctv, [\n "

N = 2

for i in range(1,N+1):
    result += "cctv_driver" + str(i) + ",\n"
    result += "feature_extr" + str(i) + ",\n"
    result += "short_term_analytics" + str(i) + ",\n"
    result += "alarm_driver" + str(i) + ",\n"
result += "video_compression,\n storage,\n long_term_analytics\n]).\n" 
    
cctv_driver_proc = ", 2, "
cctv_driver_hw = " 0.5, "
cctv_driver_things = "[ video" # TODO ADJUST
cctv_driver_sec ="[ ]).\n"

fe_driver_proc = ", 5, "
fe_driver_hw = " 0.5, "
fe_driver_things = "[], " 
fe_driver_sec ="[ ]).\n"

sta_driver_proc = ", 2, "
sta_driver_hw = " 0.5, "
sta_driver_things = "[], " 
sta_driver_sec ="[ ]).\n"

alarm_driver_proc = ", 2, "
alarm_driver_hw = " 0.5, "
alarm_driver_things = "[ alarm1 ], " 
#alarm_driver_things = "[ alarm" + str(i) + "], "
alarm_driver_sec ="[ ]).\n"

for i in range(1,N+1):
    result = result + "service(cctv_driver" + str(i) + cctv_driver_proc + cctv_driver_hw + cctv_driver_things + str(i) + " ]," + cctv_driver_sec
    result = result + "service(feature_extr" + str(i) + fe_driver_proc + fe_driver_hw + fe_driver_things + fe_driver_sec
    result = result + "service(short_term_analytics" + str(i) + sta_driver_proc + sta_driver_hw + sta_driver_things + sta_driver_sec
    result = result + "service(alarm_driver" + str(i) + alarm_driver_proc + alarm_driver_hw + alarm_driver_things + alarm_driver_sec
    result += "flow(cctv_driver" + str(i) +", feature_extr" + str(i) +", 8).\n" 
    result += "flow(feature_extr" + str(i) +", short_term_analytics" + str(i) +", 5).\n" 
    result += "flow(short_term_analytics" + str(i) +", alarm_driver" + str(i) +", .5).\n" 
    result += "flow(feature_extr" + str(i) +", video_compression, 5).\n" 
   # result += "flow(long_term_analytics" + str(i) +", short_term_analytics, 1).\n" 
    result += "flow(long_term_analytics" +", short_term_analytics" + str(i)+ ", 1).\n"
    result += "maxLatency([cctv_driver" + str(i) + ", feature_extr" + str(i) + ", short_term_analytics" + str(i) + ", alarm_driver" + str(i) + "], 50).\n"    


result += "service(video_compression, 5, 3, [], []).\n"
result += "service(storage, 50, 10, [], []).\n"
result += "service(long_term_analytics, 50, 2, [], []).\n"

result += "flow(video_compression, storage, 5).\n"
result += "flow(storage, long_term_analytics, 3).\n"

print(result)