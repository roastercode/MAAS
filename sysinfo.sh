# sysinfo.sh
# bring back information from remote machines

# dependencies
df
nethogs
sysstat


## harddrive level 
# df
df -h


# Network analysis
sudo nethogs
# pid information (offer pid request)
ps -p 6195 -o comm=
(clear response (chrome))

# sar - from sysstat package
Cannot open /var/log/sa/sa24: No such file or directory
Please check if data collecting is enabled

You can try sar -n ALL to get all possible network statistics,
or if you want rx and tx statistics per network device, every second - try this:

sar -n DEV 1
For a 5 second avarage of rx and tx for eth0 (for example) do:

sar -n DEV 1 5 | grep -i eth0 | tail -n1 | awk '{print $5, $6}'
