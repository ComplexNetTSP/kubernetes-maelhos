#!/bin/bash

# Define the MongoDB service and replica set name
MONGO_SERVICE="mongodb-headless"
REPLICAS=3
REPLICA_SET_NAME="rs0"

echo "Waiting for MongoDB pods to be ready..."
for ((i=0; i<REPLICAS; i++)); do
  until kubectl --namespace mhostettler exec mongodb-$i -- mongosh --eval "db.runCommand({ ping: 1 })" &>/dev/null; do
    echo "Waiting for mongodb-$i to be ready..."
    sleep 5s
  done
done

echo "All MongoDB instances are ready. Initializing the replica set..."


# Run rs.initiate() from the first MongoDB pod
kubectl exec mongodb-0 -n mhostettler -- mongosh --eval "
rs.initiate({
  _id: '$REPLICA_SET_NAME',
  members: [
    { _id: 0, host: 'mongodb-0.$MONGO_SERVICE.mhostettler.svc.cluster.local:27017' },
    { _id: 1, host: 'mongodb-1.$MONGO_SERVICE.mhostettler.svc.cluster.local:27017' },
    { _id: 2, host: 'mongodb-2.$MONGO_SERVICE.mhostettler.svc.cluster.local:27017' }
  ]
});
"

# Verify the replica set status
echo "Replica set initiated. Checking status..."
kubectl exec mongodb-0 -- mongosh --eval "rs.status()"
