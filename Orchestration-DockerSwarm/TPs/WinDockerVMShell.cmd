
docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export LD_LIBRARY_PATH=/containers/services/docker-ce/lower/usr/lib; export PATH=/containers/services/docker-ce/lower/usr/local/bin:/containers/services/docker-ce/lower/usr/bin:$PATH; sh"


