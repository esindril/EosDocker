#
# Simple EOS Docker file 
#
# Version 0.1

# Use the fedora base image
FROM fedora:20
MAINTAINER Elvin Sindrilaru, esindril@cern.ch, CERN 2014

# Add the EOS repository
ADD eos.repo /etc/yum.repos.d/eos.repo

# Create the /var/lock/subsys directory needed by the eos daemons
ADD eos.conf /etc/tmpfiles.d/eos.conf
RUN systemd-tmpfiles --create /etc/tmpfiles.d/eos.conf

# Configuration files for the EOS test instance
ADD eos.sysconfig /etc/sysconfig/eos
ADD xrd.cf.mgm /etc/xrd.cf.mgm
ADD xrd.cf.fst1 /etc/xrd.cf.fst1
ADD xrd.cf.fst2 /etc/xrd.cf.fst2
ADD xrd.cf.fst3 /etc/xrd.cf.fst3
ADD xrd.cf.fst4 /etc/xrd.cf.fst4
ADD xrd.cf.fst5 /etc/xrd.cf.fst5
ADD xrd.cf.fst6 /etc/xrd.cf.fst6

# Add EOS setup script
ADD eos_setup.sh /tmp/eos_setup.sh

# Instal XRootD 3.3.6 dependency
RUN yum -y --nogpg install perl
ENV XRD_VER 3.3.6
RUN yum --disablerepo="*" --enablerepo="eos-beryl" -y --nogpg install \
    xrootd-$XRD_VER \
    xrootd-client-$XRD_VER \
    xrootd-client-libs-$XRD_VER \
    xrootd-libs-$XRD_VER \
    xrootd-server-devel-$XRD_VER \
    xrootd-server-libs-$XRD_VER

# Install EOS 
RUN yum -y --nogpg install eos-server eos-testkeytab

# Start the eos instance in master mode
RUN service eos master mgm
RUN service eos master mq

# Finish configuration of EOS
RUN mkdir /home/data && \
    mkdir /home/data/eos1 && \
    mkdir /home/data/eos2 && \
    mkdir /home/data/eos3 && \
    mkdir /home/data/eos4 && \
    mkdir /home/data/eos5 && \
    mkdir /home/data/eos6 

RUN chmod +x /tmp/eos_setup.sh
RUN chown -R daemon:daemon /home/data/*

CMD service eos restart && \
    /tmp/eos_setup.sh && \
    /bin/bash

