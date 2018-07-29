#!/bin/bash

sed -i 's/CLUSTER/'"$CLUSTER"'/g' /root/.kube/config
sed -i 's/KUBERNETES_URL/'"$KUBERNETES_URL"'/g' /root/.kube/config
sed -i 's/USER/'"$USER"'/g' /root/.kube/config
sed -i 's/TOKEN/'"$TOKEN"'/g' /root/.kube/config

exec "$@"