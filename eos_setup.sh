#! /bin/bash 

# Script used to register the filesystems in EOS and enable all the features
# necessary for a default setup

HOSTNAME=`hostname -f`
echo "Running the configuration script for host: $HOSTNAME"

for i in {1..6}
do
    echo "Add file system $i"
    UUID=fst$i
    DATADIR=/home/data/eos$i
    echo "$UUID" > $DATADIR/.eosfsuuid
    echo "$i" > $DATADIR/.eosfsid
    eos -b fs add -m $i $UUID $HOSTNAME:$((2000+$i)) $DATADIR default rw
    eos -b node set $HOSTNAME:$((2000+$i)) on    
done 

eos -b space quota default off 
eos -b space set default on 
eos -b vid enable sss 
eos -b vid enable unix
eos -b fs boot \*
eos -b config save -f default 
exit 0

