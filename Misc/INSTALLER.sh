#!/bin/bash

set -u

################################################################################
# Configuration:

INSTALL_DIR=$HOME/ContainerConEU2016-OrchestnLab
ARCHIVE_DIR=$INSTALL_DIR/Archives

KUBE_RELEASE=1.3.6
KUBE_RELEASE_FILE_SIZE=1488182774
KUBE_RELEASE_FILE_md5=7dbbbb70b2b0c2a614cb4fd70e61c62a
KUBE_UNTAR_DIR=$INSTALL_DIR
KUBE_ROOT_DIR=$INSTALL_DIR/kubernetes_$KUBE_RELEASE

MESOS_RELEASE=1.0.1
MESOS_RELEASE_FILE_SIZE=41765234
MESOS_RELEASE_FILE_md5=1aaca00a0ffb20f4b31c2dcc2447c2c5
MESOS_UNTAR_DIR=$INSTALL_DIR
MESOS_ROOT_DIR=$INSTALL_DIR/mesos_$MESOS_RELEASE

#DOCKER_RELEASE=latest
DOCKER_RELEASE=1.12.1
DOCKER_RELEASE_FILE_SIZE=28845850
DOCKER_RELEASE_FILE_md5=6249d7b0be08762f9de506fff32aba9f
DOCKER_UNTAR_DIR=$INSTALL_DIR
DOCKER_ROOT_DIR=$INSTALL_DIR/docker_$DOCKER_RELEASE

VERBOSE=0

################################################################################
# Functions:

die() {
    echo "$0: $*" >&2
    exit 1
}

press() {
    echo "$*"
    echo "Press <return> to continue"
    read _DUMMY
    [ "$_DUMMY" eq "q" ] && exit 0
    [ "$_DUMMY" eq "Q" ] && exit 0
}

makedir() {
    DIR=$1
    [ ! -d $DIR ] && mkdir -p $DIR
    [ ! -d $DIR ] && die "Failed to 'mkdir -p $DIR'"
}

INSTALL_sw() {
    SW=$1; shift
    SW_RELEASE=$1; shift
    SW_URL=$1; shift
    SW_DOWNLOAD=$1; shift
    ARCHIVE_FILE=$1; shift
    ARCHIVE_FILE_SIZE=$1; shift
    ARCHIVE_FILE_MD5=$1; shift
    SW_TAR_TOP_DIR=$1; shift
    SW_UNTAR_DIR=$1; shift
    SW_FINAL_ROOT_DIR=$1; shift

    if [ -z "$SW_FINAL_ROOT_DIR" ];then
        echo "Error: some parameters to $0 missing";
        set | grep -E "^(ARCHIVE_|SW_|SW=)"
        die "Some parameters to $0 missing";
    fi


    ARCHIVE_PATH=$ARCHIVE_DIR/$ARCHIVE_FILE

    echo "--------------------------"
    echo "- Downloading/Unpacking $SW"

    #[ $VERBOSE -ne 0 ] && [ -f $ARCHIVE_PATH ] && echo "---- $SW archive file exists: <$ARCHIVE_PATH>"
    if [ -f $ARCHIVE_PATH ]; then
        [ $VERBOSE -ne 0 ] && echo "---- $SW archive file exists: <$ARCHIVE_PATH>"
        local SIZE=$(wc -c < $ARCHIVE_PATH)

        if [ $SIZE == $ARCHIVE_FILE_SIZE ];then
            [ $VERBOSE -ne 0 ] && echo "---- $SW archive file has correct size: <$ARCHIVE_FILE_SIZE>"
            SW_DOWNLOAD=0
        else
            [ $VERBOSE -ne 0 ] && echo "---- $SW archive file has incorrect size: $SIZE != $ARCHIVE_FILE_SIZE"
        fi
    fi

    [ $SW_DOWNLOAD -ne 0 ] && {
        echo "-- Downloading $SW release <$SW_RELEASE>";
        echo "--- to <$ARCHIVE_PATH>";
        echo "    curl -o $ARCHIVE_PATH $SW_URL";
        curl -o $ARCHIVE_PATH $SW_URL;

        local SIZE=$(wc -c < $ARCHIVE_PATH)
        [ $SIZE != $ARCHIVE_FILE_SIZE ] && {
            die "$SW archive file has incorrect size: $SIZE != $ARCHIVE_FILE_SIZE"
        }
    }

    if [ -d $SW_FINAL_ROOT_DIR ];then
        [ $VERBOSE -ne 0 ] && echo "---- $SW INSTALL_DIR exists: <$SW_FINAL_ROOT_DIR>"
    else
        echo "-- Unpacking archive for $SW release <$SW_RELEASE>";
        echo "--- to <$SW_UNTAR_DIR>";

        if [ "${ARCHIVE_PATH%.tar}" != "$ARCHIVE_PATH" ]; then
            CMD="tar -C $SW_UNTAR_DIR -xf $ARCHIVE_PATH"
        elif [ "${ARCHIVE_PATH%.tbz2}" != "$ARCHIVE_PATH" ]; then
            CMD="tar -C $SW_UNTAR_DIR -jxf $ARCHIVE_PATH"
        elif [ "${ARCHIVE_PATH%.tar.bz2}" != "$ARCHIVE_PATH" ]; then
            CMD="tar -C $SW_UNTAR_DIR -jxf $ARCHIVE_PATH"
        elif [ "${ARCHIVE_PATH%.tgz}" != "$ARCHIVE_PATH" ]; then
            CMD="tar -C $SW_UNTAR_DIR -zxf $ARCHIVE_PATH"
        elif [ "${ARCHIVE_PATH%.tar.gz}" != "$ARCHIVE_PATH" ]; then
            CMD="tar -C $SW_UNTAR_DIR -zxf $ARCHIVE_PATH"
        else
            die "Don't know how to untar archive '$ARCHIVE_PATH'"
        fi
        echo $CMD
        $CMD

        echo "SW_TAR_TOP_DIR=$SW_TAR_TOP_DIR"
        echo "SW_UNTAR_DIR=$SW_UNTAR_DIR"
        echo "SW_FINAL_ROOT_DIR=$SW_FINAL_ROOT_DIR"

        if [ "$SW_UNTAR_DIR" != "$SW_FINAL_ROOT_DIR" ]; then
            CMD="mv $SW_TAR_TOP_DIR $SW_FINAL_ROOT_DIR"
            echo $CMD
            $CMD
        fi
    fi
}


INSTALL_kubernetes() {
    KUBE_RELEASE=$1; shift

    KUBE_URL=https://storage.googleapis.com/kubernetes-release/release/v$KUBE_RELEASE/kubernetes.tar.gz
    KUBE_FILE=kubernetes_v$KUBE_RELEASE.tar.gz
    KUBE_DOWNLOAD=1

    # This is the top-level dir within the tar (need special treatment if .)
    KUBE_TAR_TOP_DIR=$INSTALL_DIR/kubernetes

    INSTALL_sw "kubernetes" $KUBE_RELEASE $KUBE_URL $KUBE_DOWNLOAD $KUBE_FILE \
                            $KUBE_RELEASE_FILE_SIZE $KUBE_RELEASE_FILE_md5 \
                            $KUBE_TAR_TOP_DIR $KUBE_UNTAR_DIR $KUBE_ROOT_DIR
}

INSTALL_mesos() {
    MESOS_RELEASE=$1; shift

    MESOS_URL=http://archive.apache.org/dist/mesos/$MESOS_RELEASE/mesos-$MESOS_RELEASE.tar.gz
    MESOS_FILE=mesos_v$MESOS_RELEASE.tar.gz
    MESOS_DOWNLOAD=1

    # This is the top-level dir within the tar (need special treatment if .)
    MESOS_TAR_TOP_DIR=$INSTALL_DIR/mesos-$MESOS_RELEASE

    INSTALL_sw "mesos" $MESOS_RELEASE $MESOS_URL $MESOS_DOWNLOAD $MESOS_FILE \
                            $MESOS_RELEASE_FILE_SIZE $MESOS_RELEASE_FILE_md5 \
                            $MESOS_TAR_TOP_DIR $MESOS_UNTAR_DIR $MESOS_ROOT_DIR
}

INSTALL_docker() {
    DOCKER_RELEASE=$1; shift

    DOCKER_URL="https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_RELEASE}.tgz"
    DOCKER_FILE=docker_v$DOCKER_RELEASE.tar.gz
    DOCKER_DOWNLOAD=1

    # This is the top-level dir within the tar (need special treatment if .)
    DOCKER_TAR_TOP_DIR=$INSTALL_DIR/docker

    INSTALL_sw "docker" $DOCKER_RELEASE $DOCKER_URL $DOCKER_DOWNLOAD $DOCKER_FILE \
                            $DOCKER_RELEASE_FILE_SIZE $DOCKER_RELEASE_FILE_md5 \
                            $DOCKER_TAR_TOP_DIR $DOCKER_UNTAR_DIR $DOCKER_ROOT_DIR
}

################################################################################
# Args:

while [ ! -z "$*" ];do
    case "$1" in
        -v) let VERBOSE=VERBOSE+1;;
        -x) set -x;;
        +x) set +x;;
        *) die "Unknown option <$1>";;
    esac
    shift
done

################################################################################
# Main:

#curl -sS https://get.k8s.io > get.k8s.io.sh
#chmod +x get.k8s.io.sh

#KUBERNETES_SKIP_DOWNLOAD=skip_download

#./get.k8s.io.sh

makedir $INSTALL_DIR
echo "- Installing to '$INSTALL_DIR'"

makedir $ARCHIVE_DIR

INSTALL_kubernetes $KUBE_RELEASE

INSTALL_mesos $MESOS_RELEASE

INSTALL_docker $DOCKER_RELEASE


