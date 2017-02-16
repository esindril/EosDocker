#! /bin/bash

docker network create eoscluster.cern.ch

docker run -dit -h eos-mq-test.eoscluster.cern.ch --name eos-mq-test --net=eoscluster.cern.ch --net-alias=eos-mq-test eos-container
docker exec -it eos-mq-test /eos_mq_setup.sh

docker run -dit -h eos-mgm-test.eoscluster.cern.ch --name eos-mgm-test --net=eoscluster.cern.ch --net-alias=eos-mgm-test eos-container
docker exec -it eos-mgm-test /eos_mgm_setup.sh

for i in {1..6}
do   
    FSTHOSTNAME=eos-fst${i}-test
    docker run --privileged -dit -h $FSTHOSTNAME.eoscluster.cern.ch --name $FSTHOSTNAME --net=eoscluster.cern.ch --net-alias=$FSTHOSTNAME eos-container
    docker exec -it $FSTHOSTNAME /eos_fst_setup.sh $i
done

docker exec -it eos-mgm-test /eos_mgm_fs_setup.sh

