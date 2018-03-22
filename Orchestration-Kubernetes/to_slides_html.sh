#!/bin/bash

cd /root/ContainerOrchestration.Labs/Orchestration-Kubernetes
mkdir -p html

for NB in Kubernetes.ipynb 1.Concepts.ipynb 2.kubectl_basics.ipynb 3.pods.ipynb 4.* 5.maintenance.ipynb 6.tools.ipynb 9.Resources.ipynb ; do
    jupyter-nbconvert --to slides $NB
done

mv *.html html/

