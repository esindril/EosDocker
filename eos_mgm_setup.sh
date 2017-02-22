#! /bin/bash

source /etc/sysconfig/eos

chown daemon:daemon /etc/eos.krb5.keytab
/usr/bin/xrootd -n mgm -c /etc/xrd.cf.mgm -m -l /var/log/eos/xrdlog.mgm -b -Rdaemon

eos -b vid enable sss
eos -b vid enable unix
