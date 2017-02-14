#! /bin/bash

FSTHOSTNAME=$(hostname -f)

source /etc/sysconfig/eos
export EOS_MGM_URL=root://eos-mgm-test.cern.ch//

for i in {1..6}
do
    echo "Starting fst${i} ..."
    /usr/bin/xrootd -n fst${i} -c /etc/xrd.cf.fst${i} -l /var/log/eos/xrdlog.fst${i} -b -Rdaemon
    echo "Add file system $i"
    UUID=fst$i
    DATADIR=/home/data/eos$i
    echo "Create data directory for fst${i}"
    mkdir -p $DATADIR
    echo "$UUID" > $DATADIR/.eosfsuuid
    echo "$i" > $DATADIR/.eosfsid
    chown -R daemon:daemon $DATADIR
    eos -b fs add -m $i $UUID $FSTHOSTNAME:$((2000+$i)) $DATADIR default rw
    eos -b node set $FSTHOSTNAME:$((2000+$i)) on
    echo "Done with fst${i}"
done

