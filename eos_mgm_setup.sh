#! /bin/bash

source /etc/sysconfig/eos

/usr/bin/xrootd -n mgm -c /etc/xrd.cf.mgm -m -l /var/log/eos/xrdlog.mgm -b -Rdaemon

eos -b vid enable sss
eos -b vid enable unix
