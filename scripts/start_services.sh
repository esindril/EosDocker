#! /bin/bash

docker network create eos-cluster

docker run -dit -h eos-mq-test.cern.ch --name eos-mq-test.cern.ch --net=eos-cluster --net-alias=eos-mq-test.cern.ch eos-container
docker exec -it eos-mq-test.cern.ch /eos_mq_setup.sh

docker run -dit -h eos-mgm-test.cern.ch --name eos-mgm-test.cern.ch --net=eos-cluster --net-alias=eos-mgm-test.cern.ch eos-container
docker exec -it eos-mgm-test.cern.ch /eos_mgm_setup.sh

docker run --privileged -dit -h eos-fst-test.cern.ch --name eos-fst-test.cern.ch --net=eos-cluster --net-alias=eos-fst-test.cern.ch eos-container
docker exec -it eos-fst-test.cern.ch /eos_fst_setup.sh

docker exec -it eos-mgm-test.cern.ch /eos_fs_setup.sh

