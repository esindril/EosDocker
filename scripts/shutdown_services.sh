#! /bin/bash

docker stop eos-mq-test
docker rm eos-mq-test

docker stop eos-mgm-test
docker rm eos-mgm-test

for i in {1..6}
do
    FSTHOSTNAME=eos-fst${i}-test
    docker stop $FSTHOSTNAME
    docker rm $FSTHOSTNAME
done

docker network rm eoscluster.cern.ch
