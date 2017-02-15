#! /bin/bash

docker stop eos-mq-test
docker rm eos-mq-test

docker stop eos-mgm-test
docker rm eos-mgm-test

docker stop eos-fst-test
docker rm eos-fst-test

docker network rm eoscluster.cern.ch
