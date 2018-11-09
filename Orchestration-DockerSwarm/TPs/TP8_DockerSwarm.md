# TP8: Docker Swarm

We will now use Docker 'Swarm Mode' to manage a cluster of nodes.

Note that this time we have nothing extra to install, 'Swarm Mode' capabilities are integrated into the
standard Docker Engine.

We will use Play with Docker again.

# 1. Create multiple nodes

Create 3 nodes in play-with-docker by pressing on the **"+ ADD NEW INSTANCE"** link.
![](images/playwd1.JPG)

# 2. Create a swarm instance

## 2.1 Initialize the 1st node as the Swarm Master

Use the command ```docker swarm init``` to initialize the cluster.
Probably you will get an error, if so run ```docker swarm init --advertise-addr $(hostname -i)``` to use the first network.

```
[node1] (local) root@192.168.0.48 ~
$ docker swarm init
Error response from daemon: could not choose an IP address to advertise since this system has multiple addresses on different interfaces (192.168.0.48 on eth0 and 172.18.0.25 on eth1) - specify one with --advertise-addr
[node1] (local) root@192.168.0.48 ~
$ docker swarm init --advertise-addr $(hostname -i)
Swarm initialized: current node (ykzexnk780yh6ivpokyg2919a) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1skoem28av2k2scj5nivccywjydioj7y7b2vr88rypdhy3e6fh-4zdyb2lkln490rqcmaz42gi2o 192.168.0.48:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

The swarm has been initialized and node1 is our Master, check using ```docker node ls``` as below:
```
[node1] (local) root@192.168.0.48 ~
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
ykzexnk780yh6ivpokyg2919a *   node1               Ready               Active              Leader              18.06.1-ce
```

## 2.2 On this 1st node, obtain the join token

Note that we have been provided with the command to run on *another node* to allow this node to join the cluster as a worker node.

If you didn't capture that command, you can obtain it again with the ```docker swarm join-token``` command with either manager or worker as argument, e.g. to get the command to join a node as a worker:
```
[node1] (local) root@192.168.0.48 ~
$ docker swarm join-token worker
To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1skoem28av2k2scj5nivccywjydioj7y7b2vr88rypdhy3e6fh-4zdyb2lkln490rqcmaz42gi2o 192.168.0.48:2377
```

**NOTE:** We can also obtain just the token rather than the full command with ```docker swarm join-token worker -q```
```
[node1] (local) root@192.168.0.48 ~
$ docker swarm join-token worker -q
SWMTKN-1-1skoem28av2k2scj5nivccywjydioj7y7b2vr88rypdhy3e6fh-4zdyb2lkln490rqcmaz42gi2o
```

## 2.3 Join node2 to the cluster as a worker

Run the ```docker swarm join``` command you were provided with by the ```docker swarm join-token worker``` command above.

e.g.
```
[node2] (local) root@192.168.0.47 ~
$ docker swarm join --token SWMTKN-1-1skoem28av2k2scj5nivccywjydioj7y7b2vr88rypdhy3e6fh-4zdyb2lkln490rqcmaz42gi2o 192.168.0.48:2377
This node joined a swarm as a worker.
```

## 2.4 Join node3 to the cluster as a worker

Perform the same ```docker swarm join``` command as for node2.
e.g.
```
[node3] (local) root@192.168.0.46 ~
$ docker swarm join --token SWMTKN-1-1skoem28av2k2scj5nivccywjydioj7y7b2vr88rypdhy3e6fh-4zdyb2lkln490rqcmaz42gi2o 192.168.0.48:2377
This node joined a swarm as a worker.
```

## 2.5 Check that we now have 3 nodes in our cluster

**NOTE:** This command must be run from a master node, i.e. node1 in our case:
```
[node1] (local) root@192.168.0.48 ~
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
ykzexnk780yh6ivpokyg2919a *   node1               Ready               Active              Leader              18.06.1-ce
qsri0p2teyxcyo1jcgrdx1u06     node2               Ready               Active                                  18.06.1-ce
x1yt1bs5movv21cdnak6w2sxv     node3               Ready               Active                                  18.06.1-ce
```


