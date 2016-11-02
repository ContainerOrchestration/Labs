
# Docker "Swarm Mode" Lab

Based on Mario's gist here: https://gist.github.com/l0rd/5186cc80f8f26dc7e9490abca4405830

# Requirements
- Docker 1.12
- Docker machine
- Virtualbox

# Create 3 nodes for your swarm cluster (one master and 2 slaves)

#### NOTE:
You may see errors as below, and an error reported by "docker-machine ls", leave some time for the swmaster to settle.

In the meantime you can go ahead and create the 2 swnode's below.


```bash
docker-machine create -d virtualbox swmaster
```

    Running pre-create checks...
    Creating machine...
    (swmaster) Copying /home/group20/.docker/machine/cache/boot2docker.iso to /home/group20/.docker/machine/machines/swmaster/boot2docker.iso...
    (swmaster) Creating VirtualBox VM...
    (swmaster) Creating SSH key...
    (swmaster) Starting the VM...
    (swmaster) Check network to re-create if needed...
    (swmaster) Waiting for an IP...
    Waiting for machine to be running, this may take a few minutes...
    Detecting operating system of created instance...
    Waiting for SSH to be available...
    Detecting the provisioner...
    Provisioning with boot2docker...
    Copying certs to the local machine directory...
    Copying certs to the remote machine...
    Setting Docker configuration on the remote daemon...
    Configuring swarm...
    Error creating machine: Error running provisioning: Unable to pull image: Post https://192.168.99.122:2376/v1.15/images/create?fromImage=swarm%3Alatest: x509: certificate is valid for 192.168.99.116, not 192.168.99.122





    Running pre-create checks...Creating machine...(swmaster) Copying /home/group20/.docker/machine/cache/boot2docker.iso to /home/group20/.docker/machine/machines/swmaster/boot2docker.iso...(swmaster) Creating VirtualBox VM...(swmaster) Creating SSH key...(swmaster) Starting the VM...(swmaster) Check network to re-create if needed...(swmaster) Waiting for an IP...Waiting for machine to be running, this may take a few minutes...Detecting operating system of created instance...Waiting for SSH to be available...Detecting the provisioner...Provisioning with boot2docker...Copying certs to the local machine directory...Copying certs to the remote machine...Setting Docker configuration on the remote daemon...Configuring swarm...Error creating machine: Error running provisioning: Unable to pull image: Post https://192.168.99.122:2376/v1.15/images/create?fromImage=swarm%3Alatest: x509: certificate is valid for 192.168.99.116, not 192.168.99.122




```bash
docker-machine ls
```


```bash
docker-machine create -d virtualbox swnode1
```


```bash
docker-machine ls
```

    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
    swmaster   -        virtualbox   Running   tcp://192.168.99.134:2376           v1.12.1   
    swnode1    -        virtualbox   Running   tcp://192.168.99.136:2376           v1.12.1   





    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORSswmaster   -        virtualbox   Running   tcp://192.168.99.134:2376           v1.12.1   swnode1    -        virtualbox   Running   tcp://192.168.99.136:2376           v1.12.1




```bash
docker-machine create -d virtualbox swnode2
```


```bash
docker-machine ls
```

    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
    swmaster   -        virtualbox   Running   tcp://192.168.99.134:2376           v1.12.1   
    swnode1    -        virtualbox   Running   tcp://192.168.99.136:2376           v1.12.1   





    NAME       ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORSswmaster   -        virtualbox   Running   tcp://192.168.99.134:2376           v1.12.1   swnode1    -        virtualbox   Running   tcp://192.168.99.136:2376           v1.12.1



# swarm init

Now we will initialize our Swarm Cluster


```bash
docker $(docker-machine config swmaster) swarm init --advertise-addr $(docker-machine ip swmaster)
```

    Swarm initialized: current node (ci1pa8ffrfa266a0brfottdjp) is now a manager.
    
    To add a worker to this swarm, run the following command:
    
        docker swarm join \
        --token SWMTKN-1-0odjpysca4e2aq2haamh86623n3li0j8e85odhiptdto5hmnbt-01pid9o6nuw7qqwso65x74a07 \
        192.168.99.134:2377
    
    To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
    





    Swarm initialized: current node (ci1pa8ffrfa266a0brfottdjp) is now a manager.To add a worker to this swarm, run the following command:    docker swarm join \    --token SWMTKN-1-0odjpysca4e2aq2haamh86623n3li0j8e85odhiptdto5hmnbt-01pid9o6nuw7qqwso65x74a07 \    192.168.99.134:2377To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.



A docker info should now show "Swarm: active" as below:


```bash
docker $(docker-machine config swmaster) info
```

    Containers: 0
     Running: 0
     Paused: 0
     Stopped: 0
    Images: 0
    Server Version: 1.12.1
    Storage Driver: aufs
     Root Dir: /mnt/sda1/var/lib/docker/aufs
     Backing Filesystem: extfs
     Dirs: 0
     Dirperm1 Supported: true
    Logging Driver: json-file
    Cgroup Driver: cgroupfs
    Plugins:
     Volume: local
     Network: null host bridge overlay
    Swarm: active
     NodeID: ci1pa8ffrfa266a0brfottdjp
     Is Manager: true
     ClusterID: 72o7h2sv59bsq3mbyhh0998ea
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
     Node Address: 192.168.99.134
    Runtimes: runc
    Default Runtime: runc
    Security Options: seccomp
    Kernel Version: 4.4.17-boot2docker
    Operating System: Boot2Docker 1.12.1 (TCL 7.2); HEAD : ef7d0b4 - Thu Aug 18 21:18:06 UTC 2016
    OSType: linux
    Architecture: x86_64
    CPUs: 1
    Total Memory: 995.9 MiB
    Name: swmaster
    ID: PY6N:PMVS:Y7EU:CAJM:4UNF:YRXP:KBOI:R3ZS:MNEX:N43Q:JPKD:YPGD
    Docker Root Dir: /mnt/sda1/var/lib/docker
    Debug Mode (client): false
    Debug Mode (server): true
     File Descriptors: 31
     Goroutines: 116
     System Time: 2016-10-05T07:50:51.368201334Z
     EventsListeners: 0
    Registry: https://index.docker.io/v1/
    Labels:
     provider=virtualbox
    Insecure Registries:
     127.0.0.0/8





    Containers: 0 Running: 0 Paused: 0 Stopped: 0Images: 0Server Version: 1.12.1Storage Driver: aufs Root Dir: /mnt/sda1/var/lib/docker/aufs Backing Filesystem: extfs Dirs: 0 Dirperm1 Supported: trueLogging Driver: json-fileCgroup Driver: cgroupfsPlugins: Volume: local Network: null host bridge overlaySwarm: active NodeID: ci1pa8ffrfa266a0brfottdjp Is Manager: true ClusterID: 72o7h2sv59bsq3mbyhh0998ea Managers: 1 Nodes: 1 Orchestration:  Task History Retention Limit: 5 Raft:  Snapshot Interval: 10000  Heartbeat Tick: 1  Election Tick: 3 Dispatcher:  Heartbeat Period: 5 seconds CA Configuration:  Expiry Duration: 3 months Node Address: 192.168.99.134Runtimes: runcDefault Runtime: runcSecurity Options: seccompKernel Version: 4.4.17-boot2dockerOperating System: Boot2Docker 1.12.1 (TCL 7.2); HEAD : ef7d0b4 - Thu Aug 18 21:18:06 UTC 2016OSType: linuxArchitecture: x86_64CPUs: 1Total Memory: 995.9 MiBName: swmasterID: PY6N:PMVS:Y7EU:CAJM:4UNF:YRXP:KBOI:R3ZS:MNEX:N43Q:JPKD:YPGDDocker Root Dir: /mnt/sda1/var/lib/dockerDebug Mode (client): falseDebug Mode (server): true File Descriptors: 31 Goroutines: 116 System Time: 2016-10-05T07:50:51.368201334Z EventsListeners: 0Registry: https://index.docker.io/v1/Labels: provider=virtualboxInsecure Registries: 127.0.0.0/8



# swarm join

Now we wish to join Master and Worker nodes to our swarm cluster, to do this we need to obtain the token generated during the "swarm init".

Let's save that token to an environment variable as follows:



```bash
token=$(docker $(docker-machine config swmaster) swarm join-token worker -q)
```







```bash
echo $token
```

    SWMTKN-1-0odjpysca4e2aq2haamh86623n3li0j8e85odhiptdto5hmnbt-01pid9o6nuw7qqwso65x74a07





    SWMTKN-1-0odjpysca4e2aq2haamh86623n3li0j8e85odhiptdto5hmnbt-01pid9o6nuw7qqwso65x74a07




```bash
docker $(docker-machine config swnode1) swarm join --token $token $(docker-machine ip swmaster):2377
```

    This node joined a swarm as a worker.





    This node joined a swarm as a worker.




```bash
docker $(docker-machine config swnode2) swarm join --token $token $(docker-machine ip swmaster):2377
```

    This node joined a swarm as a worker.





    This node joined a swarm as a worker.



# start service

First we check for any running services - there should be none in our newly initialized cluster:


```bash
docker $(docker-machine config swmaster) service ls
```

    ID  NAME  REPLICAS  IMAGE  COMMAND





    ID  NAME  REPLICAS  IMAGE  COMMAND



Now we will create a new service based on the docker image mariolet/docker-demo

We will expose this service on port 8080



```bash
docker $(docker-machine config swmaster) service create --replicas 1 --name docker-demo -p 8080:8080 mariolet/docker-demo:20
```

    7f5xw8j10kclbasftswo8s0ih


Now we list services again and we should see our newly added docker-demo service


```bash
docker $(docker-machine config swmaster) service ls
```

    ID            NAME         REPLICAS  IMAGE                    COMMAND
    7f5xw8j10kcl  docker-demo  1/1       mariolet/docker-demo:20  


... and we can look at the service as seen by the cluster:


```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME           IMAGE                    NODE      DESIRED STATE  CURRENT STATE          ERROR
    4m8g69g0xwhpkufzb6qx4zirz  docker-demo.1  mariolet/docker-demo:20  swmaster  Running        Running 3 minutes ago  


... and we can look at the service on the individual cluster nodes.

Of course as we set replicas to 1 there is only 1 replica of the service for the moment, running on just 1 node of our cluster:


```bash
docker $(docker-machine config swmaster) ps
```

    CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS               NAMES
    a9d7d4164dec        mariolet/docker-demo:20   "/bin/docker-demo -li"   3 minutes ago       Up 3 minutes        8080/tcp            docker-demo.1.4m8g69g0xwhpkufzb6qx4zirz



```bash
docker $(docker-machine config swnode1) ps
```

    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES



```bash
docker $(docker-machine config swnode2) ps
```

    CONTAINER ID        IMAGE                     COMMAND                  CREATED              STATUS              PORTS               NAMES
    89015e708c6c        mariolet/docker-demo:20   "/bin/docker-demo -li"   About a minute ago   Up About a minute   8080/tcp            docker-demo.2.46rtx1xq95yyqz9ht5keaspna


# Accessing the service

As we are working remotely we need to create an ssh tunnel through to the swarm cluster to access our service, exposing the port 8080 on your local machine.

We can obtain the ip address of the swarm master node as follows.


```bash
docker-machine ip swmaster
```

    192.168.99.134


So from a terminal on your laptop open the ssh tunnel to **YOUR USER@YOUR SERVER**

MYSERVER=10.3.222.32
MYUSER=group20

e.g. ssh group20@10.3.222.32 -L 8080:$(docker-machine ip swmaster):8080 -Nv


```bash
MYSERVER=10.3.222.32
MYUSER=group20
ssh ${MYUSER}@${MYSERVER} -L 8080:$(docker-machine ip swmaster):8080 -Nv
```

Then open your web browser at the page http://localhost:8080 and you should see a lovely blue whale.


# scale service

Now we can scale the service to 3 replicas:


```bash
docker $(docker-machine config swmaster) service scale docker-demo=3
```

    docker-demo scaled to 3



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME           IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    4m8g69g0xwhpkufzb6qx4zirz  docker-demo.1  mariolet/docker-demo:20  swmaster  Running        Running 6 minutes ago    
    46rtx1xq95yyqz9ht5keaspna  docker-demo.2  mariolet/docker-demo:20  swnode2   Running        Preparing 4 seconds ago  
    6i0mhypkwtjxcva2149ae0vw3  docker-demo.3  mariolet/docker-demo:20  swnode1   Running        Preparing 4 seconds ago  


# rolling-update

Now we will see how we can perform a rolling update.

We initially deployed version 20 of the service, now we will upgrade our whole cluster to version 20 



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME           IMAGE                    NODE      DESIRED STATE  CURRENT STATE           ERROR
    4m8g69g0xwhpkufzb6qx4zirz  docker-demo.1  mariolet/docker-demo:20  swmaster  Running        Running 18 minutes ago  
    46rtx1xq95yyqz9ht5keaspna  docker-demo.2  mariolet/docker-demo:20  swnode2   Running        Running 11 minutes ago  
    6i0mhypkwtjxcva2149ae0vw3  docker-demo.3  mariolet/docker-demo:20  swnode1   Running        Running 11 minutes ago  



```bash
docker $(docker-machine config swmaster) service update --image mariolet/docker-demo:21 docker-demo
```

    docker-demo



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    9bqw8x93wpj8c03g5f8w1hqht  docker-demo.1      mariolet/docker-demo:21  swnode2   Ready          Preparing 2 seconds ago  
    4m8g69g0xwhpkufzb6qx4zirz   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Running 18 minutes ago   
    d44mx9h76fwu2d9y4i77g3b5t  docker-demo.2      mariolet/docker-demo:21  swnode1   Running        Running 1 seconds ago    
    46rtx1xq95yyqz9ht5keaspna   \_ docker-demo.2  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 5 seconds ago   
    6i0mhypkwtjxcva2149ae0vw3  docker-demo.3      mariolet/docker-demo:20  swnode1   Running        Running 12 minutes ago   



```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    9bqw8x93wpj8c03g5f8w1hqht  docker-demo.1      mariolet/docker-demo:21  swnode2   Running        Running 40 seconds ago   
    4m8g69g0xwhpkufzb6qx4zirz   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Shutdown 41 seconds ago  
    d44mx9h76fwu2d9y4i77g3b5t  docker-demo.2      mariolet/docker-demo:21  swnode1   Running        Running 42 seconds ago   
    46rtx1xq95yyqz9ht5keaspna   \_ docker-demo.2  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 46 seconds ago  
    exck8pjbzbg0cjltk1dtld37y  docker-demo.3      mariolet/docker-demo:21  swmaster  Running        Running 37 seconds ago   
    6i0mhypkwtjxcva2149ae0vw3   \_ docker-demo.3  mariolet/docker-demo:20  swnode1   Shutdown       Shutdown 38 seconds ago  


### Verifying the service has been updated

Then open your web browser at the page http://localhost:8080 and you should see a lovely blue whale.


# drain a node

We can drain a node effectively placing it in 'maintenance mode'.


```bash
docker $(docker-machine config swmaster) node ls
```

    ID                           HOSTNAME  STATUS  AVAILABILITY  MANAGER STATUS
    18hvqzqwcyvdikg2eqyvmrmb7    swnode2   Ready   Active        
    7rdk8zejlwxd7oivnwraa2c4t    swnode1   Ready   Active        
    ci1pa8ffrfa266a0brfottdjp *  swmaster  Ready   Active        Leader


Let's drain swnode1


```bash
docker $(docker-machine config swmaster) node update --availability drain swnode1
```

    swnode1


and now we see that all services on swnode1 are shutdown


```bash
docker $(docker-machine config swmaster) service ps docker-demo
```

    ID                         NAME               IMAGE                    NODE      DESIRED STATE  CURRENT STATE            ERROR
    9bqw8x93wpj8c03g5f8w1hqht  docker-demo.1      mariolet/docker-demo:21  swnode2   Running        Running 2 minutes ago    
    4m8g69g0xwhpkufzb6qx4zirz   \_ docker-demo.1  mariolet/docker-demo:20  swmaster  Shutdown       Shutdown 2 minutes ago   
    drkmbmvx40942okypdcvel61o  docker-demo.2      mariolet/docker-demo:21  swmaster  Running        Running 39 seconds ago   
    d44mx9h76fwu2d9y4i77g3b5t   \_ docker-demo.2  mariolet/docker-demo:21  swnode1   Shutdown       Shutdown 41 seconds ago  
    46rtx1xq95yyqz9ht5keaspna   \_ docker-demo.2  mariolet/docker-demo:20  swnode2   Shutdown       Shutdown 2 minutes ago   
    exck8pjbzbg0cjltk1dtld37y  docker-demo.3      mariolet/docker-demo:21  swmaster  Running        Running 2 minutes ago    
    6i0mhypkwtjxcva2149ae0vw3   \_ docker-demo.3  mariolet/docker-demo:20  swnode1   Shutdown       Shutdown 2 minutes ago   


# remove a service

Now let's cleanup by removing our service


```bash
docker $(docker-machine config swmaster) service rm docker-demo
```

    docker-demo



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
