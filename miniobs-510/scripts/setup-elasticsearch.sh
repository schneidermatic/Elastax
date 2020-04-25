#!/bin/bash
configdir=/usr/share/elasticsearch/config

# Install unzip package
yum install -y unzip

# Determine if x-pack is enabled
echo "==> Determining if x-pack is installed..."
if [[ -f bin/elasticsearch-users ]]; then
    if [[ -n "$ELASTIC_PASSWORD" ]]; then

        echo "=== CREATE Keystore ==="
        echo "==> Elastic password is: $ELASTIC_PASSWORD"
        if [ -f $configdir/elasticsearch.keystore ]; then
            echo "Remove old elasticsearch.keystore"
            rm $configdir/elasticsearch.keystore
        fi
        [[ -f $configdir/elasticsearch.keystore ]] || (/usr/share/elasticsearch/bin/elasticsearch-keystore create)
        echo "Setting bootstrap.password..."
        (echo "$ELASTIC_PASSWORD" | /usr/share/elasticsearch/bin/elasticsearch-keystore add -x 'bootstrap.password')

        # Create SSL Certs
        echo "=== CREATE SSL CERTS ==="

        if [ ! -d $configdir/certificates/certs ]; then
            mkdir -p $configdir/certificates/certs
        fi

        #cp $configdir/instances.yml $configdir/certs/ssl/instances.yml
        
        # check if old docker-cluster-ca.zip exists, if it does remove and create a new one.
        if [ -f $configdir/certs/ssl/docker-cluster-ca.zip ]; then
            echo "==> Remove old ca zip..."
            rm $configdir/certs/ssl/docker-cluster-ca.zip
        fi
        echo "==> Creating docker-cluster-ca.zip..."
        /usr/share/elasticsearch/bin/elasticsearch-certutil ca --pem --silent --out $configdir/certificates/certs/docker-cluster-ca.zip

        echo "==> ls -la $configdir/certificates/certs"
        ls -la $configdir/certificates/certs

        # check if ca directory exists, if does, remove then unzip new files
        if [ -d $configdir/certificates/certs/ca ]; then
            echo "==> CA directory exists, removing..."
            rm -rf $configdir/certificates/certs/ca
        fi
        echo "==> Unzip ca files..."
        unzip $configdir/certificates/certs/docker-cluster-ca.zip -d $configdir/certificates/certs

        # check if certs zip exist. If it does remove and create a new one.
        if [ -f $configdir/certs/ssl/docker-cluster.zip ]; then
            echo "==> Remove old docker-cluster.zip zip..."
            rm $configdir/certs/ssl/docker-cluster.zip
        fi

        echo "==> Create cluster certs zipfile..."
        /usr/share/elasticsearch/bin/elasticsearch-certutil cert --silent --pem --in $configdir/certificates/certs/instances.yml --out $configdir/certificates/certs/docker-cluster.zip --ca-cert $configdir/certificates/certs/ca/ca.crt --ca-key $configdir/certificates/certs/ca/ca.key

        echo "==> ls -la $configdir/certificates/certs"
        ls -la $configdir/certificates/certs

        echo "==> ls -la $configdir/certificates/certs/instances.yml"
        cat $configdir/certificates/certs/instances.yml
        
        if [ -d $configdir/certificates/certs/docker-cluster ]; then
            rm -rf $configdir/certificates/certs/docker-cluster
        fi
        echo "==> Unzipping cluster certs zipfile..."
        unzip $configdir/certificates/certs/docker-cluster.zip -d $configdir/certificates/certs/docker-cluster

        echo "==> ls -la $configdir/certificates/certs/docker-cluster/elasticsearch"
        ls -la $configdir/certificates/certs/docker-cluster/elasticsearch

        chown 1000:1000 -R $configdir/certs
        echo "==> setup-elasticsearch.sh.... done"
    fi
fi