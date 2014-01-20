#
# Simple EOS Docker file 
#
# Version 0.1

# Use the fedora base image
FROM fedora
MAINTAINER Elvin Sindrialru, esindril@cern.ch, CERN 2014

# Add the EOS repository
ADD eos.repo /etc/yum.repos.d/eos.repo

# Install EOS 
RUN yum -y --nogpg install eos-server eos-testkeytab

# Create the /var/lock/subsys directory needed by the eos daemons
ADD eos.conf /etc/tmpfiles.d/eos.conf
RUN systemd-tmpfiles --create /etc/tmpfiles.d/eos.conf

# Configuration files for the EOS test instance
ADD eos.sysconfig /etc/sysconfig/eos
ADD xrd.cf.mgm /etc/xrd.cf.mgm

# Start the eos instance in master mode
RUN service eos master mgm
RUN service eos master mq

# Install supervisor to start the eos service
RUN yum -y --nogpg install supervisor 
ADD supervisor.conf /etc/supervisor/conf.d/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf && /bin/bash
