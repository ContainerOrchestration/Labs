
# Mesos Lab

First move to the source directory where you already downloaded the git repo sources:

```bash
git clone https://github.com/ContainerOrchestration/Labs
cd Labs
```

## Setup the Mesos VM

We will now use docker-machine/virtualbox to create a new docker node to be used as the Mesos VM


```bash
docker-machine create --driver virtualbox mesoshost
```

    Running pre-create checks...
    Creating machine...
    (mesoshost) Copying /home/group20/.docker/machine/cache/boot2docker.iso to /home/group20/.docker/machine/machines/mesoshost/boot2docker.iso...
    (mesoshost) Creating VirtualBox VM...
    (mesoshost) Creating SSH key...
    (mesoshost) Starting the VM...
    (mesoshost) Check network to re-create if needed...
    (mesoshost) Waiting for an IP...
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
    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env mesoshost



```bash
docker-machine ls
```

    NAME          ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
    mesoshost   -        virtualbox   Running   tcp://192.168.99.100:2376           v1.12.3   


### Start the Mesos Master and Slave

We will now use docker-compose to start the Mesos Master and Slaves as containers within the mesoshost machine which we just created


```bash
docker-compose $(docker-machine config mesoshost) -f Orchestration-ApacheMesos/docker-compose.yml up -d
```

## Access to the Marathon console from your laptop:

Let's get the ip address of our 'mesoshost' machine, using
```bash
MESOS_MASTERIP=$(docker-machine ip mesoshost)
echo $MESOS_MASTERIP
```

Then open your web browser at the page http://$MESOS_MASTERIP:8080 and you should see the Marathon console, as shown here

![](https://github.com/mjbright/LinuxConEU-ContainerOrchestration/blob/master/images/marathon_dashboard.png)

### Access the Mesos console fro your laptop

Open your web browser at the page http://$MESOS_MASTERIP:5050 and you should see the Mesos console

You should verify that there is an active framework (marathon) and that there are 3 active slaves.

### Deploy applications on to the Mesos cluster

Use the Marathon application descriptions nginx.json and pacman.json to deploy these apps on mesos/marathon

Now let's launch the nginx application, by sending a POST request to the Mesos Master:


```bash
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" http://$MESOS_MASTERIP:8080/v2/apps -d @mesos/nginx.json
```

    {"id":"/nginx","cmd":null,"args":null,"user":null,"env":{},"instances":2,"cpus":0.1,"mem":64.0,"disk":0.0,"executor":"","constraints":[],"uris":[],"storeUrls":[],"ports":[0],"requirePorts":false,"backoffFactor":1.15,"container":{"type":"DOCKER","volumes":[],"docker":{"image":"nginx","network":"BRIDGE","portMappings":[{"containerPort":80,"hostPort":0,"servicePort":0,"protocol":"tcp"}],"privileged":false,"parameters":[]}},"healthChecks":[{"path":"/","protocol":"HTTP","portIndex":0,"command":null,"gracePeriodSeconds":5,"intervalSeconds":20,"timeoutSeconds":20,"maxConsecutiveFailures":3}],"dependencies":[],"upgradeStrategy":{"minimumHealthCapacity":1.0,"maximumOverCapacity":1.0},"labels":{},"version":"2016-10-31T14:20:15.971Z","tasks":[],"deployments":[{"id":"b6fb2a4f-9e78-4aa8-9ce8-969257799260"}],"tasksStaged":0,"tasksRunning":0,"tasksHealthy":0,"tasksUnhealthy":0,"backoffSeconds":1,"maxLaunchDelaySeconds":3600}

and let's launch the pacman application, by sending a POST request to the Mesos Master:


```bash
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" http://$MESOS_MASTERIP:8080/v2/apps -d @mesos/pacman.json
```

    {"id":"/pacman","cmd":null,"args":null,"user":null,"env":{},"instances":2,"cpus":0.1,"mem":64.0,"disk":0.0,"executor":"","constraints":[],"uris":[],"storeUrls":[],"ports":[0],"requirePorts":false,"backoffFactor":1.15,"container":{"type":"DOCKER","volumes":[],"docker":{"image":"emilevauge/pacman","network":"BRIDGE","portMappings":[{"containerPort":80,"hostPort":0,"servicePort":0,"protocol":"tcp"}],"privileged":false,"parameters":[]}},"healthChecks":[],"dependencies":[],"upgradeStrategy":{"minimumHealthCapacity":1.0,"maximumOverCapacity":1.0},"labels":{},"version":"2016-10-31T14:20:58.165Z","tasks":[],"deployments":[{"id":"bf88d1a4-ed34-4e29-92f0-c5b0e35f0f13"}],"tasksStaged":0,"tasksRunning":0,"tasksHealthy":0,"tasksUnhealthy":0,"backoffSeconds":1,"maxLaunchDelaySeconds":3600}

The Marathon console, at http://localhost:8080, should now show these 2 services running:

![](https://github.com/mjbright/LinuxConEU-ContainerOrchestration/blob/master/images/marathon_dashboard_2services.png)

Play with the Marathon console: scale applications, kill them etc...



```bash

```
