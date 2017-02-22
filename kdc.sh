#!/bin/bash

# Start kdc
echo -n "Starting kdc... "
/usr/libexec/kdc --detach
echo Done.

#Init the kdc store
echo -n "Initing kdc... "
/usr/lib/heimdal/bin/kadmin -l -r TEST.EOS init --realm-max-ticket-life=unlimited --realm-max-renewable-life=unlimited TEST.EOS || (echo Failed. ; exit 1)
echo Done.

# Populate KDC and generate keytab files
echo -n "Populating kdc... "
/usr/lib/heimdal/bin/kadmin -l -r TEST.EOS add --random-password --use-defaults admin1 host/eos-mgm-test.eoscluster.cern.ch
/usr/lib/heimdal/bin/kadmin -l -r TEST.EOS ext_keytab --keytab=/root/admin1.keytab admin1
/usr/lib/heimdal/bin/kadmin -l -r TEST.EOS ext_keytab --keytab=/root/eos.keytab host/eos-mgm-test.eoscluster.cern.ch
echo Done.
