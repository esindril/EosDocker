#
# Simple EOS Docker file 
#
# Version 0.2

# Use the fedora base image
FROM centos:7
MAINTAINER Elvin Sindrilaru, esindril@cern.ch, CERN 2017

RUN yum -y --nogpg update

# Add required repositories
ADD *.repo /etc/yum.repos.d/

# Add configuration files for EOS instance
ADD eos.sysconfig /etc/sysconfig/eos
ADD xrd.cf.* /etc/

# Instal XRootD
ENV XRD_VERSION 4.5.0
RUN yum -y --nogpg install \
    xrootd-$XRD_VERSION \
    xrootd-client-$XRD_VERSION \
    xrootd-client-libs-$XRD_VERSION \
    xrootd-libs-$XRD_VERSION \
    xrootd-server-devel-$XRD_VERSION \
    xrootd-server-libs-$XRD_VERSION

# Install EOS 
RUN yum -y --nogpg install\
    eos-server eos-testkeytab quarkdb\
    initscripts less emasc && yum clean all
ADD eos_setup.sh /
ENTRYPOINT ["/bin/bash"]

