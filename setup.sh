#!/usr/bin/bash
DEBEZIUM_TAG=0.10
STRIMZI_VERSION=0.16.2

# Get Strimzi
curl -kL https://github.com/strimzi/strimzi-kafka-operator/releases/download/$STRIMZI_VERSION/strimzi-$STRIMZI_VERSION.tar.gz | tar xz
cd strimzi-$STRIMZI_VERSION

# Create project
oc new-project kafka

# Install controller and templates
sed -i 's/namespace: .*/namespace: kafka/' install/cluster-operator/*RoleBinding*.yaml
kubectl apply -f install/cluster-operator -n kafka && oc create -f examples/templates/cluster-operator

# Start pre-populated database
#oc new-app --name=mysql debezium/example-mysql:${DEBEZIUM_TAG}
#oc set env dc/mysql MYSQL_ROOT_PASSWORD=debezium  MYSQL_USER=mysqluser MYSQL_PASSWORD=mysqlpw

