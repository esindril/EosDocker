#! /bin/bash

/usr/bin/xrootd -n mq -c /etc/xrd.cf.mq -l /var/log/eos/xrdlog.mq -b -Rdaemon
