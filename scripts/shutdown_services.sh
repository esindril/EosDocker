#! /bin/bash

docker stop eos-mq-test.cern.ch
docker rm eos-mq-test.cern.ch

docker stop eos-mgm-test.cern.ch
docker rm eos-mgm-test.cern.ch

docker stop eos-fst-test.cern.ch
docker rm eos-fst-test.cern.ch

docker network rm eos-cluster
