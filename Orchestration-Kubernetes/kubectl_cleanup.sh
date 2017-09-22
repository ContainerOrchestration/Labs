#!/bin/bash

. ~/bin/.demorc

clean_helm() {
    helm_charts=$(helm list | tail --lines=+2 | awk '{ print $1; }')

    [ ! -z "$helm_charts" ] && {
        hl "Removing exisitng helm applications"
        RUN helm delete $helm_charts
    }
}

echo
hl "Showing current pods, deployments, replicasets and services"
SHOW kubectl get           --namespace default pods,deploy,replicaset,service

clean_helm

echo
hl "Removing any deployments and services"
RUN  kubectl delete deploy --namespace default --all
RUN  kubectl delete service mike-docker-demo-service

echo
hl "Showing current pods, deployments, replicasets and services"
SHOW kubectl get           --namespace default pods,deploy,replicaset,service


