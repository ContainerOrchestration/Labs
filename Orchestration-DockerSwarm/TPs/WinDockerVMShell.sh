
#winpty docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export PS1='MobyLinuxVM[nsenter] \u@\h \w> '; export LD_LIBRARY_PATH=/containers/services/docker-ce/lower/usr/lib; export PATH=/containers/services/docker-ce/lower/usr/local/bin:/containers/services/docker-ce/lower/usr/bin:$PATH; sh"

#winpty docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export LD_LIBRARY_PATH=/containers/services/docker-ce/lower/usr/lib; export PATH=/containers/services/docker-ce/lower/usr/local/bin:/containers/services/docker-ce/lower/usr/bin:$PATH; sh"

#winpty docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export A=1; sh"

#winpty docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export PATH=/containers/services/docker-ce/lower/usr/local/bin:/containers/services/docker-ce/lower/usr/bin:$PATH; sh"

#winpty docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export PATH=/containers/services/docker-ce/lower/usr/local/bin:/containers/services/docker-ce/lower/usr/bin; /bin/sh"

winpty docker run --privileged --pid=host -it alpine:3.8 nsenter -t 1 -m -u -n -i -- sh -c "export PS1='MobyLinuxVM[nsenter] \u@\h \w> '; export LD_LIBRARY_PATH=/containers/services/docker-ce/lower/usr/lib; export PATH=/containers/services/docker-ce/lower/usr/local/bin:/containers/services/docker-ce/lower/usr/bin:/usr/bin:/bin; sh"

