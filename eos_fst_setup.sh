#! /bin/bash

FSTHOSTNAME=$(hostname -f)
i=$1

source /etc/sysconfig/eos
export EOS_MGM_URL=root://eos-mgm-test.eoscluster.cern.ch//

echo "Starting fst${i} ..."
/usr/bin/xrootd -n fst${i} -c /etc/xrd.cf.fst -l /var/log/eos/xrdlog.fst -b -Rdaemon
echo "Add file system $i"
UUID=fst$i
DATADIR=/home/data/eos$i
echo "Create data directory for fst${i}"
mkdir -p $DATADIR
echo "$UUID" > $DATADIR/.eosfsuuid
echo "$i" > $DATADIR/.eosfsid
chown -R daemon:daemon $DATADIR
eos -b fs add -m $i $UUID $FSTHOSTNAME:1095 $DATADIR default rw
eos -b node set $FSTHOSTNAME:1095 on
echo "Done with fst${i}"
