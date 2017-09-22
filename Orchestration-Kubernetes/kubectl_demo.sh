#!/bin/bash

. ~/bin/.demorc

MASTER_NODE=10.3.61.91

IPORT=8080
EPORT=8080
#EXPOSE_TYPE=LoadBalancer
EXPOSE_TYPE=NodePort

DEMO_NAME=k8s-demo
DEMO_V1=1
DEMO_V2=2
DEMO_REPLICAS=3

show_access_pod_ports() {
    echo
    hl "------------------------------------------------"; echo
    hl "Access to pods directly using:"; echo;
    kubectl describe pods | awk '/IP:/ { print "    curl "$2":8080"; }'
}

show_access_ports() {
    echo
    hl "------------------------------------------------"; echo
    hl "Access service by running command:"; echo; echo -n "    "
    echo "    curl $SERVICE_URL"
}

echo
hl "Showing current pods, deployments, replicasets ,services"; echo
SHOW kubectl get           --namespace default pods,deploy,replicaset,service

echo
hl "Now we create a new deployment called ${DEMO_NAME}, with $(green ${DEMO_REPLICAS}) replicas (pods)";
echo
RUN  kubectl run ${DEMO_NAME} --labels="owner=demouser" --port $IPORT --replicas=${DEMO_REPLICAS} --image mjbright/${DEMO_NAME}:${DEMO_V1}

echo
hl "Showing current pods, deployments, replicasets ,services"; echo
SHOW kubectl get           --namespace default pods,deploy,replicaset,service

RUN  kubectl describe deploy ${DEMO_NAME}
RUN  kubectl describe replicaset ${DEMO_NAME}

echo
hl "You can access directly to the service on the pods (because we are running on a Kubernetes node)";
echo
hl "You can not $(green yet) access from outside a Kubernetes node";
echo
show_access_pod_ports

echo
echo
hl "We will now $(green expose) our service so that we can access from another machine"; echo
RUN  kubectl expose deploy ${DEMO_NAME} --type=$EXPOSE_TYPE --name=${DEMO_NAME}-service --port $EPORT
#SHOW kubectl get           --namespace default pods,deploy,replicaset,service
SHOW kubectl get            service

SERVICE_URL="http://${MASTER_NODE}:$( kubectl get svc | grep ${DEMO_NAME} | awk '{ print $4; }' | sed -e 's/.*://' -e 's/\/.*//' )"
show_access_ports

echo
hl "By modifyng the $(green image version) associated with our deployment, a new version is automatically rolled out"; echo
RUN  kubectl set image deployment ${DEMO_NAME} ${DEMO_NAME}=mjbright/${DEMO_NAME}:${DEMO_V2} --record

echo
RUN  kubectl rollout status deploy ${DEMO_NAME}

echo
hl "We see now that there are 2 ReplicaSets, the old one with zero replicas, and the new one with ${DEMO_REPLICAS} replicas"; echo
#SHOW kubectl get           --namespace default pods,deploy,replicaset,service
kubectl get --namespace default pod,rs | highlight "^rs/"

echo
show_access_ports

#hl "See how we can select items, e.g. pods based on labels"
#SHOW kubectl get pods --selector "owner=demouser" service


exit 0

