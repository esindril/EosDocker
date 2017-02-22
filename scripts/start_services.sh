#! /bin/bash

docker network create eoscluster.cern.ch

docker run -dit -h eos-krb-test.eoscluster.cern.ch --name eos-krb-test --net=eoscluster.cern.ch --net-alias=eos-krb-test eos-container
docker exec -it eos-krb-test /kdc.sh

docker run -dit -h eos-mq-test.eoscluster.cern.ch --name eos-mq-test --net=eoscluster.cern.ch --net-alias=eos-mq-test eos-container
docker exec -it eos-mq-test /eos_mq_setup.sh

docker run -dit -h eos-mgm-test.eoscluster.cern.ch --name eos-mgm-test --net=eoscluster.cern.ch --net-alias=eos-mgm-test eos-container

TMP_EOS_KEYTAB=mktemp
docker cp eos-krb-test:/root/eos.keytab $TMP_EOS_KEYTAB
docker cp $TMP_EOS_KEYTAB eos-mgm-test:/etc/eos.krb5.keytab
rm -f $TMP_EOS_KEYTAB
docker exec -it eos-mgm-test /eos_mgm_setup.sh

for i in {1..6}
do   
    FSTHOSTNAME=eos-fst${i}-test
    docker run --privileged -dit -h $FSTHOSTNAME.eoscluster.cern.ch --name $FSTHOSTNAME --net=eoscluster.cern.ch --net-alias=$FSTHOSTNAME eos-container
    docker exec -it $FSTHOSTNAME /eos_fst_setup.sh $i
done

docker exec -it eos-mgm-test /eos_mgm_fs_setup.sh

docker run -dit -h eos-client-test.eoscluster.cern.ch --name eos-client-test --net=eoscluster.cern.ch --net-alias=eos-client-test eos-container
docker exec -it eos-krb-test cat /root/admin1.keytab | docker exec -i eos-client-test bash -c "cat > /root/admin1.keytab"
docker exec -it eos-client-test kinit -kt /root/admin1.keytab admin1@TEST.EOS
docker exec -it eos-client-test kvno host/eos-mgm-test.eoscluster.cern.ch

