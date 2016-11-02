
# Docker "Swarm Mode" Lab

Based on Mario's gist here: https://gist.github.com/l0rd/5186cc80f8f26dc7e9490abca4405830

# Requirements
- Docker 1.12
- Docker machine
- Virtualbox

# Create 3 nodes for your swarm cluster (one master and 2 slaves)

We will create 3 nodes using docker-machine/virtualbox.

#### NOTE:
You may see errors as below, and an error reported by "docker-machine ls", leave some time for the swmaster to settle.

In the meantime you can go ahead and create the 2 swnode's below.


```bash
docker-machine create -d virtualbox swmaster
```

    Running pre-create checks...
    (swmaster) No default Boot2Docker ISO found locally, downloading the latest release...
    (swmaster) Latest release for github.com/boot2docker/boot2docker is v1.12.3
    (swmaster) Downloading /home/group20/.docker/machine/cache/boot2docker.iso from https://github.com/boot2docker/boot2docker/releases/download/v1.12.3/boot2docker.iso...
    (swmaster) 0%....10%....20%....30%....40%....50%....60%....70%....80%....90%....100%
    Creating machine...
    (swmaster) Copying /home/group20/.docker/machine/cache/boot2docker.iso to /home/group20/.docker/machine/machines/swmaster/boot2docker.iso...
    (swmaster) Creating VirtualBox VM...
    (swmaster) Creating SSH key...
    (swmaster) Starting the VM...
    (swmaster) Check network to re-create if needed...
    (swmaster) Waiting for an IP...
    (swmaster) The host-only adapter is corrupted. Let's stop the VM, fix the host-only adapter and restart the VM
    (swmaster) Waiting for an IP...
    Waiting for machine to be running, this may take a few minutes...
    Detecting operating system of created instance...
    Waiting for SSH to be available...
    Detecting the provisioner...
    Provisioning with boot2docker...
    Copying certs to the local machine directory...
    Copying certs to the remote machine...
    Setting Docker configuration on the remote daemon...
    Checking connection to Docker...
    Docker is up and running!
    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env swmaster



```bash
docker-machine ls
```

    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
    swmaster   -        virtualbox   Running   tcp://192.168.99.105:2376           v1.12.3   



```bash
docker-machine create -d virtualbox swnode1
```

    Running pre-create checks...
    Creating machine...
    (swnode1) Copying /home/group20/.docker/machine/cache/boot2docker.iso to /home/group20/.docker/machine/machines/swnode1/boot2docker.iso...
    (swnode1) Creating VirtualBox VM...
    (swnode1) Creating SSH key...
    (swnode1) Starting the VM...
    (swnode1) Check network to re-create if needed...
    (swnode1) Waiting for an IP...
    Waiting for machine to be running, this may take a few minutes...
    Detecting operating system of created instance...
    Waiting for SSH to be available...
    Detecting the provisioner...
    Provisioning with boot2docker...
    Copying certs to the local machine directory...
    Copying certs to the remote machine...
    Setting Docker configuration on the remote daemon...
    Checking connection to Docker...
    Docker is up and running!
    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env swnode1



```bash
docker-machine ls
```

    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
    swmaster   -        virtualbox   Running   tcp://192.168.99.105:2376           v1.12.3   
    swnode1    -        virtualbox   Running   tcp://192.168.99.106:2376           v1.12.3   



```bash
time docker-machine create -d virtualbox swnode2
```

    Running pre-create checks...
    Creating machine...
    (swnode2) Copying /home/group20/.docker/machine/cache/boot2docker.iso to /home/group20/.docker/machine/machines/swnode2/boot2docker.iso...
    (swnode2) Creating VirtualBox VM...
    (swnode2) Creating SSH key...
    (swnode2) Starting the VM...
    (swnode2) Check network to re-create if needed...
    (swnode2) Waiting for an IP...
    Waiting for machine to be running, this may take a few minutes...
    Detecting operating system of created instance...
    Waiting for SSH to be available...
    Detecting the provisioner...
    Provisioning with boot2docker...
    Copying certs to the local machine directory...
    Copying certs to the remote machine...
    Setting Docker configuration on the remote daemon...
    Checking connection to Docker...
    Docker is up and running!
    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env swnode2
    
    real	1m0.014s
    user	0m0.492s
    sys	0m0.076s



```bash
docker-machine ls
```

    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
    swmaster   -        virtualbox   Running   tcp://192.168.99.105:2376           v1.12.3   
    swnode1    -        virtualbox   Running   tcp://192.168.99.106:2376           v1.12.3   
    swnode2    -        virtualbox   Running   tcp://192.168.99.107:2376           v1.12.3   


# swarm init

Now that we have 3 nodes available, we will initialize our Swarm Cluster with 1 master node

First let's identify the ip address of that node.

We can see this through config or ip commands of docker-machine as shown below.


```bash
docker-machine config swmaster
```

    --tlsverify
    --tlscacert="/home/group20/.docker/machine/certs/ca.pem"
    --tlscert="/home/group20/.docker/machine/certs/cert.pem"
    --tlskey="/home/group20/.docker/machine/certs/key.pem"
    -H=tcp://192.168.99.105:2376



```bash
docker-machine ip swmaster
```

    192.168.99.105


We could then provide the above ip address as parameter to --advertise-addr when initializing the swarm.

However, it is quite convenient to run the above commands embedded, as below, as arguments to the swarm init command.

docker-machine config swmaster provides the parameters to use when connecting to the appropriate docker engine for our machine "swmaster".

The following command will run swarm init to generate the cluster with 'swmaster' as the Master node.
You should see output similar to the below:


```bash
docker $(docker-machine config swmaster) swarm init --advertise-addr $(docker-machine ip swmaster)
```

    Swarm initialized: current node (983fp9611vely7wgd593pyup6) is now a manager.
    
    To add a worker to this swarm, run the following command:
    
        docker swarm join \
        --token SWMTKN-1-53u20lpb0qanlwwxb59iwirt6w1qw0qi2t1p7c1gk0p4c44o0m-dsggkdumqs5536he24tn7gave \
        192.168.99.105:2377
    
    To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
    


A docker info should now show "Swarm: active" as below:


```bash
docker $(docker-machine config swmaster) info
```

    Containers: 0
     Running: 0
     Paused: 0
     Stopped: 0
    Images: 0
    Server Version: 1.12.3
    Storage Driver: aufs
     Root Dir: /mnt/sda1/var/lib/docker/aufs
     Backing Filesystem: extfs
     Dirs: 0
     Dirperm1 Supported: true
    Logging Driver: json-file
    Cgroup Driver: cgroupfs
    Plugins:
     Volume: local
     Network: null bridge overlay host
    Swarm: active
     NodeID: 983fp9611vely7wgd593pyup6
     Is Manager: true
     ClusterID: d3navkk4xgotvnxg9to70xb1j
     Managers: 1
     Nodes: 1
     Orchestration:
      Task History Retention Limit: 5
     Raft:
      Snapshot Interval: 10000
      Heartbeat Tick: 1
      Election Tick: 3
     Dispatcher:
      Heartbeat Period: 5 seconds
     CA Configuration:
      Expiry Duration: 3 months
     Node Address: 192.168.99.105
    Runtimes: runc
    Default Runtime: runc
    Security Options: seccomp
    Kernel Version: 4.4.27-boot2docker
    Operating System: Boot2Docker 1.12.3 (TCL 7.2); HEAD : 7fc7575 - Thu Oct 27 17:23:17 UTC 2016
    OSType: linux
    Architecture: x86_64
    CPUs: 1
    Total Memory: 995.8 MiB
    Name: swmaster
    ID: WH2I:PBRM:OD3D:4HTC:Y6O2:V7SL:VIAH:SQEN:A6T3:RN6M:HG3C:XF7R
    Docker Root Dir: /mnt/sda1/var/lib/docker
    Debug Mode (client): false
    Debug Mode (server): true
     File Descriptors: 31
     Goroutines: 117
     System Time: 2016-10-31T10:10:55.659047537Z
     EventsListeners: 0
    Registry: https://index.docker.io/v1/
    Labels:
     provider=virtualbox
    Insecure Registries:
     127.0.0.0/8


# swarm join

Now we wish to join Master and Worker nodes to our swarm cluster, to do this we need to obtain the token generated during the "swarm init".

Let's save that token to an environment variable as follows:



```bash
token=$(docker $(docker-machine config swmaster) swarm join-token worker -q)
```

    


```bash
echo $token
```

    SWMTKN-1-53u20lpb0qanlwwxb59iwirt6w1qw0qi2t1p7c1gk0p4c44o0m-dsggkdumqs5536he24tn7gave


Now we can use this token to join nodes as a worker to this cluster

Note: we could also join nodes as Master, but we have only 3 nodes available.

Let's join swnode1 as a worker node


```bash
docker $(docker-machine config swnode1) swarm join --token $token $(docker-machine ip swmaster):2377
```

    This node joined a swarm as a worker.


Now we can use the same token to join node swnode2 as a worker node



```bash
docker $(docker-machine config swnode2) swarm join --token $token $(docker-machine ip swmaster):2377
```

    This node joined a swarm as a worker.


# start service

First we check for any running services - there should be none in our newly initialized cluster:


```bash
docker $(docker-machine config swmaster) service ls
```

    ID  NAME  REPLICAS  IMAGE  COMMAND


Now we will create a new service based on the docker image mariolet/docker-demo

We will expose this service on port 8080



```bash
docker $(docker-machine config swmaster) service create --replicas 1 --name docker-demo -p 8080:8080 mariolet/docker-demo:20
```

    0iy9fudrubw5q4987hznce3zu


Now we list services again and we should see our newly added docker-demo service


```bash
docker $(docker-machine config swmaster) service ls
```

    ID            NAME         REPLICAS  IMAGE                    COMMAND
    0iy9fudrubw5  docker-demo  0/1       mariolet/docker-demo:20  


... and we can look at the service as seen by the cluster:


```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME           IMAGE                    NODE      DESIRED STATE  CURRENT STATE          ERROR
    bis9a6yzjtxipx0kkeb4e0b8w  docker-demo.1  mariolet/docker-demo:20  swmaster  Running        Running 5 seconds ago  


... and we can look at the service on the individual cluster nodes.

Of course as we set replicas to 1 there is only 1 replica of the service for the moment, running on just 1 node of our cluster:


```bash
docker $(docker-machine config swmaster) ps
```

    CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS               NAMES
    337010515c59        mariolet/docker-demo:20   "/bin/docker-demo -li"   3 minutes ago       Up 3 minutes        8080/tcp            docker-demo.1.bis9a6yzjtxipx0kkeb4e0b8w



```bash
docker $(docker-machine config swnode1) ps
```

    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES



```bash
docker $(docker-machine config swnode2) ps
```

    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES


# Accessing the service

As we are working remotely we need to create an ssh tunnel through to the swarm cluster to access our service, exposing the port 8080 on your local machine.

We can obtain the ip address of the swarm master node as follows.


```bash
docker-machine ip swmaster
```

    192.168.99.105


So from a terminal on your laptop open the ssh tunnel to **YOUR USER@YOUR SERVER**

MYSERVER=10.3.222.32
MYUSER=group20

e.g. ssh group20@10.3.222.32 -L 8080:192.168.99.105:8080 -Nv


```bash
MYSERVER=10.3.222.32
MYUSER=group20
ssh ${MYUSER}@${MYSERVER} -L 8080:$(docker-machine ip swmaster):8080 -Nv
```

Then open your web browser at the page http://localhost:8080 and you should see a lovely blue whale, as below:

![](images/docker.png)


# scale service

Now we can scale the service to 3 replicas:


```bash
docker $(docker-machine config swmaster) service scale docker-demo=3
```

    docker-demo scaled to 3



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME           IMAGE                    NODE      DESIRED STATE  CURRENT STATE          ERROR
    bis9a6yzjtxipx0kkeb4e0b8w  docker-demo.1  mariolet/docker-demo:20  swmaster  Running        Running 6 minutes ago  
    buqwkgkessqp87t1hx4h7xafx  docker-demo.2  mariolet/docker-demo:20  swnode1   Running        Running 1 seconds ago  
    8itya650tbhsax94zbcu8f8x5  docker-demo.3  mariolet/docker-demo:20  swnode2   Running        Running 1 seconds ago  


# rolling-update

Now we will see how we can perform a rolling update.

We initially deployed version 20 of the service, now we will upgrade our whole cluster to version 20 



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME           IMAGE                    NODE      DESIRED STATE  CURRENT STATE           ERROR
    bis9a6yzjtxipx0kkeb4e0b8w  docker-demo.1  mariolet/docker-demo:20  swmaster  Running        Running 6 minutes ago   
    buqwkgkessqp87t1hx4h7xafx  docker-demo.2  mariolet/docker-demo:20  swnode1   Running        Running 16 seconds ago  
    8itya650tbhsax94zbcu8f8x5  docker-demo.3  mariolet/docker-demo:20  swnode2   Running        Running 16 seconds ago  



```bash
docker $(docker-machine config swmaster) service update --image mariolet/docker-demo:21 docker-demo
```

    docker-demo



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    5m8jfezy3zvmfu0ym7z64gkcn  docker-demo.1      mariolet/docker-demo:21  swnode2   Ready          Preparing 1 seconds ago  
    bis9a6yzjtxipx0kkeb4e0b8w   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Running 7 minutes ago    
    buqwkgkessqp87t1hx4h7xafx  docker-demo.2      mariolet/docker-demo:20  swnode1   Running        Running 30 seconds ago   
    68o013o4n66jeczvf2b009wr4  docker-demo.3      mariolet/docker-demo:21  swnode1   Running        Running 1 seconds ago    
    8itya650tbhsax94zbcu8f8x5   \_ docker-demo.3  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 4 seconds ago   



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    5m8jfezy3zvmfu0ym7z64gkcn  docker-demo.1      mariolet/docker-demo:21  swnode2   Running        Running 11 seconds ago   
    bis9a6yzjtxipx0kkeb4e0b8w   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Shutdown 12 seconds ago  
    2x9tfhlyrr8oox89ii62ohb8w  docker-demo.2      mariolet/docker-demo:21  swmaster  Running        Running 7 seconds ago    
    buqwkgkessqp87t1hx4h7xafx   \_ docker-demo.2  mariolet/docker-demo:20  swnode1   Shutdown       Shutdown 9 seconds ago   
    68o013o4n66jeczvf2b009wr4  docker-demo.3      mariolet/docker-demo:21  swnode1   Running        Running 13 seconds ago   
    8itya650tbhsax94zbcu8f8x5   \_ docker-demo.3  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 16 seconds ago  


### Verifying the service has been updated

Then open your web browser at the page http://localhost:8080 and you should now see a lovely **red** whale.


![](images/docker_red.png)



# drain a node

We can drain a node effectively placing it in 'maintenance mode'.

Draining a node means that it no longer has running tasks on it.


```bash
docker $(docker-machine config swmaster) node ls
```

    ID                           HOSTNAME  STATUS  AVAILABILITY  MANAGER STATUS
    5qolyd9sqwby52luxb1x97zv0    swnode1   Ready   Active        
    983fp9611vely7wgd593pyup6 *  swmaster  Ready   Active        Leader
    an3ql7dx7ctif5gxd8rm3gf9h    swnode2   Ready   Active        


Let's drain swnode1


```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE           ERROR
    5m8jfezy3zvmfu0ym7z64gkcn  docker-demo.1      mariolet/docker-demo:21  swnode2   Running        Running 3 minutes ago   
    bis9a6yzjtxipx0kkeb4e0b8w   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Shutdown 3 minutes ago  
    2x9tfhlyrr8oox89ii62ohb8w  docker-demo.2      mariolet/docker-demo:21  swmaster  Running        Running 3 minutes ago   
    buqwkgkessqp87t1hx4h7xafx   \_ docker-demo.2  mariolet/docker-demo:20  swnode1   Shutdown       Shutdown 3 minutes ago  
    68o013o4n66jeczvf2b009wr4  docker-demo.3      mariolet/docker-demo:21  swnode1   Running        Running 3 minutes ago   
    8itya650tbhsax94zbcu8f8x5   \_ docker-demo.3  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 3 minutes ago  



```bash
docker $(docker-machine config swmaster) node update --availability drain swnode1
```

    swnode1


and now we see that all services on swnode1 are shutdown


```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    5m8jfezy3zvmfu0ym7z64gkcn  docker-demo.1      mariolet/docker-demo:21  swnode2   Running        Running 4 minutes ago    
    bis9a6yzjtxipx0kkeb4e0b8w   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Shutdown 4 minutes ago   
    2x9tfhlyrr8oox89ii62ohb8w  docker-demo.2      mariolet/docker-demo:21  swmaster  Running        Running 4 minutes ago    
    buqwkgkessqp87t1hx4h7xafx   \_ docker-demo.2  mariolet/docker-demo:20  swnode1   Shutdown       Shutdown 4 minutes ago   
    63321zmooc33yq4d6l7jpa1m3  docker-demo.3      mariolet/docker-demo:21  swmaster  Running        Running 11 seconds ago   
    68o013o4n66jeczvf2b009wr4   \_ docker-demo.3  mariolet/docker-demo:21  swnode1   Shutdown       Shutdown 13 seconds ago  
    8itya650tbhsax94zbcu8f8x5   \_ docker-demo.3  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 4 minutes ago   



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    5m8jfezy3zvmfu0ym7z64gkcn  docker-demo.1      mariolet/docker-demo:21  swnode2   Running        Running 4 minutes ago    
    bis9a6yzjtxipx0kkeb4e0b8w   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Shutdown 4 minutes ago   
    2x9tfhlyrr8oox89ii62ohb8w  docker-demo.2      mariolet/docker-demo:21  swmaster  Running        Running 4 minutes ago    
    buqwkgkessqp87t1hx4h7xafx   \_ docker-demo.2  mariolet/docker-demo:20  swnode1   Shutdown       Shutdown 4 minutes ago   
    63321zmooc33yq4d6l7jpa1m3  docker-demo.3      mariolet/docker-demo:21  swmaster  Running        Running 28 seconds ago   
    68o013o4n66jeczvf2b009wr4   \_ docker-demo.3  mariolet/docker-demo:21  swnode1   Shutdown       Shutdown 30 seconds ago  
    8itya650tbhsax94zbcu8f8x5   \_ docker-demo.3  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 4 minutes ago   


# remove a service

Now let's cleanup by removing our service


```bash
docker $(docker-machine config swmaster) service rm docker-demo
```

    docker-demo


We can check that the service is no longer running:


```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    Error: No such service: docker-demo



```bash
docker $(docker-machine config swmaster) ps
```

    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES



```bash

```
