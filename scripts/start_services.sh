#! /bin/bash

docker network create eoscluster.cern.ch

docker run -dit -h eos-mq-test.eoscluster.cern.ch --name eos-mq-test --net=eoscluster.cern.ch --net-alias=eos-mq-test eos-container
docker exec -it eos-mq-test /eos_mq_setup.sh

docker run -dit -h eos-mgm-test.eoscluster.cern.ch --name eos-mgm-test --net=eoscluster.cern.ch --net-alias=eos-mgm-test eos-container
docker exec -it eos-mgm-test /eos_mgm_setup.sh

docker run --privileged -dit -h eos-fst-test.eoscluster.cern.ch --name eos-fst-test --net=eoscluster.cern.ch --net-alias=eos-fst-test eos-container
docker exec -it eos-fst-test /eos_fst_setup.sh

docker exec -it eos-mgm-test /eos_mgm_fs_setup.sh

