#!/bin/bash

DIR="/root/ContainerOrchestration.Labs/Orchestration-Kubernetes"
DIR="/home/mjb/Dropbox/z/bin/DEMOS_TUTORIALS/2018-Mar-KubeTutorial/Orchestration-Kubernetes"

SERVING_DIR="/home/mjb/src/git/GIT_mjbright/Talks/kubetuto.html/"

die() {
    echo "$0: die - $*" >&2
    exit 1
}

[ ! -d $DIR ]         && die "No such src dir <$DIR>"
[ ! -d $SERVING_DIR ] && die "No such serving dir <$SERVING_DIR>"

cd $DIR/

mkdir -p html/images

for NB in Kubernetes.ipynb 1.Concepts.ipynb 2.kubectl_basics.ipynb 3.pods.ipynb 4.* 5.maintenance.ipynb 6.tools.ipynb 9.Resources.ipynb ; do
    jupyter-nbconvert --to slides $NB
done

mv *.html html/
rsync -av images/ html/images/

rsync -av html/ $SERVING_DIR/
