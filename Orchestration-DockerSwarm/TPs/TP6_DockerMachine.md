<<<<<<< HEAD

# TP6: Docker Machine
=======
# TP6: Docker Machine - ABANDONED USE OF KVM

- problems with docker-machine-driver-kvm (VM fails to have ip connectivity, cant ping google.com (or it's ip address - not a DNS problem)
- abandoned for next commit : VirtualBox based.

You can find the official documentation for '*Docker Machine*' here: [https://docs.docker.com/machine/](https://docs.docker.com/machine/)

The source code for '*Docker Machine*' is available here: [https://github.com/docker/machine](https://github.com/docker/machine)

If using '*Docker Desktop*' for Windows you already have *docker-machine*' installed, you can skip to <a href="#2-using-docker-machine"> step 2</a> "*Using docker-machine*" below.

## 1. Download docker-machine on CentOS 7

Go to the page [https://github.com/docker/machine/releases](https://github.com/docker/machine/releases) and download the latest Linux binary, e.g. [docker-machine-Linux-x86_64](https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Linux-x86_64).

```
wget -O docker-machine https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Linux-x86_64
```

Copy the binary to /usr/local/bin and set execution rights:

```
sudo mv docker-machine /usr/local/bin
sudo chmod +x /usr/local/bin/docker-machine
```

### 1.1 Download the docker-machine kvm driver for CentOS 7

docker-machine includes drivers for many providers, but not kvm.

We could install VirtualBox as a hyper-visor but in this example we will use the native Linux KVM hypervisor.

For this you will need to first install some tools

```
sudo yum install libvirt-client qemu-kvm libvirt-daemon-driver-qemu
```

Now download the latest docker-machine-driver-kvm from:
https://github.com/dhiltgen/docker-machine-kvm/releases

move the driver to /usr/local/bin:
```
sudo mv docker-machine-driver-kvm-centos7  /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm
```

Create the libvirtd group if it doesn't already exist and change to that group:
```
sudo groupadd libvirtd
sudo gpasswd -a $USER libvirtd

newgrp libvirtd
id
```

Enable and start the service:
```
systemctl enable libvirtd
systemctl start libvirtd
```

Check that the libvirtd daemon is running and accessible:
```
systemctl status libvirtd
```

You should see something like:

```
● libvirtd.service - Virtualization daemon
   Loaded: loaded (/usr/lib/systemd/system/libvirtd.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2018-10-27 11:40:26 CEST; 4s ago
     Docs: man:libvirtd(8)
           https://libvirt.org
 Main PID: 25213 (libvirtd)
    Tasks: 16 (limit: 32768)
   Memory: 4.2M
   CGroup: /system.slice/libvirtd.service
           └─25213 /usr/sbin/libvirtd
```

The following should not produce any errors:
```
virsh list
```

**NOTE**: Scott Lowe wrote a blog post about this installation here: https://blog.scottlowe.org/2017/11/24/using-docker-machine-kvm-libvirt/

## 2. Using docker-machine

To see what version you have installed
```
docker-machine version
```

you should see something similar to:
```
$ docker-machine version
docker-machine version 0.15.0, build b48dc28d
```




### 2.1 Creating a machine:

We can now create our first machine.

#### On Windows:

You will first need to create a new virtual switch.

Open the "*Hyper-V Manager*" from the Windows task bar.

Then in the right-hand Actions pane click on "*Virtual Switch Manager*".

Create a new "*virtual network switch*" of type External and call it "*ext*".

Now you can create a machine using the command:

```
docker-machine create -d hyperv --hyperv-virtual-switch ext test
```

In case of errors, use the --debug option to debug:

```
docker-machine --debug create -d hyperv --hyperv-virtual-switch ext test
```


#### On CentOS:

Now you can create a machine using the command:

```
docker-machine create -d kvm --kvm-network "docker-machines" test
```

In case of errors, use the --debug option to debug:

```
docker-machine create --debug -d kvm --kvm-network "docker-machines" test
```

Note it may be necessary to uncomment the lines:
```
    #user = root
    #group = root
```

in file /etc/libvirt/qemu.conf.

then restart libvirtd:
```
 systemctl restart libvirtd.service
```

**NOTE**: That machine creation can take several minutes especially for the first time as it is necessary to download the "*boot2docker.iso*" which is roughly 48M Bytes.

An example output on creating the machine on CentOS is:
```
$ docker-machine create -d kvm --kvm-network "docker-machines" test
Running pre-create checks...
Creating machine...
(test) Copying /home/mjb/.docker/machine/cache/boot2docker.iso to /home/mjb/.docker/machine/machines/test/boot2docker.iso...
(test) Creating SSH key...
(test) Failed to decode dnsmasq lease status: unexpected end of JSON input
(test) Failed to decode dnsmasq lease status: unexpected end of JSON input
...  LINES REMOVED ...
(test) Failed to decode dnsmasq lease status: unexpected end of JSON input
(test) Failed to decode dnsmasq lease status: unexpected end of JSON input
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
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env test
```

### 2.2 Accessing the machine:

**NOTE**: During the creation of the machine the command ```docker-machine ls``` can be run already but will show various errors, you can ignore those *worrying!* errors until the "*docker-machine create*" command has completed.

Let's now check that our machine is running correctly.

Run the command: ```docker-machine ls```

We can see the output below.
It tells us we're running with the kvm driver, that our machine is "*Running*' and that the docker daemon (version "*v18.06.1-ce*") running in that virtual machine is contactable at tcp://192.168.42.32:2376.

```
$ docker-machine ls
NAME   ACTIVE   DRIVER   STATE     URL                        SWARM   DOCKER        ERRORS
test   -        kvm      Running   tcp://192.168.42.32:2376           v18.06.1-ce
```

However we will need to know more before we can connect to the daemon.

Try running (replacing the tcp: address with your output from "*docker-machine ls*"):
```
docker -H tcp://192.168.42.32:2376 ps
```

and you will see that we need certificates to access the daemon.
```
Get http://192.168.42.32:2376/v1.38/containers/json: net/http: HTTP/1.x transport connection broken: malformed HTTP response "\x15\x03\x01\x00\x02\x02".
* Are you trying to connect to a TLS-enabled daemon without TLS?
```

### 2.3 Connecting to the docker daemon

docker-machine provides 2 ways to connect to the daemon.

We can provide the parameters to the docker client either through:
- command-line parameters
- shell environment variables

#### Connecting to the docker daemon - Using command-line parameters

We can use the *config* command to get the parameters we need to pass to the docker client:
```
$ docker-machine config test
--tlsverify
--tlscacert="/home/mjb/.docker/machine/machines/test/ca.pem"
--tlscert="/home/mjb/.docker/machine/machines/test/cert.pem"
--tlskey="/home/mjb/.docker/machine/machines/test/key.pem"
-H=tcp://192.168.42.32:2376
```

So we can pass these parameters to the docker client at each invocation as follows:

```
$ docker $(docker-machine config test) version
Client:
 Version:           18.06.1-ce
 API version:       1.38
 Go version:        go1.10.3
 Git commit:        e68fc7a
 Built:             Tue Aug 21 17:23:03 2018
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          18.06.1-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.3
  Git commit:       e68fc7a
  Built:            Tue Aug 21 17:28:38 2018
  OS/Arch:          linux/amd64
  Experimental:     false
```

It may not be obvious that we are accessing a "*remote*" docker daemon.
Try ```  docker $(docker-machine config test) info```
instead and in the output you should see the lines
```
Kernel Version: 4.9.93-boot2docker
Operating System: Boot2Docker 18.06.1-ce (TCL 8.2.1); HEAD : c7e5c3e - Wed Aug 22 16:27:42 UTC 2018
```

different from your Windows or CentOS host.

This is very handy, by providing different parameters to the docker client we can switch between different environments.


#### Connecting to the docker daemon - Using environment variables

The other way to connect is by using the "*env*" sub-command:

```
$ docker-machine env test
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.42.32:2376"
export DOCKER_CERT_PATH="/home/mjb/.docker/machine/machines/test"
export DOCKER_MACHINE_NAME="test"
# Run this command to configure your shell:
# eval $(docker-machine env test)
```

So now run that last command
```
eval $(docker-machine env test)
```

and we now have the appropriate variables set:
```
env | grep DOCKER
DOCKER_HOST=tcp://192.168.42.32:2376
DOCKER_MACHINE_NAME=test
DOCKER_TLS_VERIFY=1
DOCKER_CERT_PATH=/home/mjb/.docker/machine/machines/test
```

Now any docker command from *this shell* will access our docker-machine host until we unset those variables.

Check this by running
```
docker info
```

to check that you see the same lines as before:
```
Kernel Version: 4.9.93-boot2docker
Operating System: Boot2Docker 18.06.1-ce (TCL 8.2.1); HEAD : c7e5c3e - Wed Aug 22 16:27:42 UTC 2018
```

## 2.4 docker-machine commands

Now let's investigate more of the commands docker-machine provides us with.

Enter the command ```docker-machine help```

```$ docker-machine help
Usage: docker-machine [OPTIONS] COMMAND [arg...]

Create and manage machines running Docker.

Version: 0.15.0, build b48dc28d

Author:
  Docker Machine Contributors - <https://github.com/docker/machine>

Options:
  --debug, -D                                           Enable debug mode
  --storage-path, -s "/home/mjb/.docker/machine"        Configures storage path [$MACHINE_STORAGE_PATH]
  --tls-ca-cert                                         CA to verify remotes against [$MACHINE_TLS_CA_CERT]
  --tls-ca-key                                          Private key to generate certificates [$MACHINE_TLS_CA_KEY]
  --tls-client-cert                                     Client cert to use for TLS [$MACHINE_TLS_CLIENT_CERT]
  --tls-client-key                                      Private key used in client TLS auth [$MACHINE_TLS_CLIENT_KEY]
  --github-api-token                                    Token to use for requests to the Github API [$MACHINE_GITHUB_API_TOKEN]
  --native-ssh                                          Use the native (Go-based) SSH implementation. [$MACHINE_NATIVE_SSH]
  --bugsnag-api-token                                   BugSnag API token for crash reporting [$MACHINE_BUGSNAG_API_TOKEN]
  --help, -h                                            show help
  --version, -v                                         print the version

Commands:
  active                Print which machine is active
  config                Print the connection config for machine
  create                Create a machine
  env                   Display the commands to set up the environment for the Docker client
  inspect               Inspect information about a machine
  ip                    Get the IP address of a machine
  kill                  Kill a machine
  ls                    List machines
  provision             Re-provision existing machines
  regenerate-certs      Regenerate TLS Certificates for a machine
  restart               Restart a machine
  rm                    Remove a machine
  ssh                   Log into or run a command on a machine with SSH.
  scp                   Copy files between machines
  mount                 Mount or unmount a directory from a machine with SSHFS.
  start                 Start a machine
  status                Get the status of a machine
  stop                  Stop a machine
  upgrade               Upgrade a machine to the latest version of Docker
  url                   Get the URL of a machine
  version               Show the Docker Machine version or a machine docker version
  help                  Shows a list of commands or help for one command

Run 'docker-machine COMMAND --help' for more information on a command.
```

#### Experiment

Experiment with the following commands subset, try also adding the ```--debug``` flag for more information.

```
  active                Print which machine is active
  config                Print the connection config for machine
  create                Create a machine
  env                   Display the commands to set up the environment for the Docker client
  inspect               Inspect information about a machine
  ip                    Get the IP address of a machine
  ls                    List machines
  ssh                   Log into or run a command on a machine with SSH.
  scp                   Copy files between machines
  status                Get the status of a machine
  url                   Get the URL of a machine
  version               Show the Docker Machine version or a machine docker version
  help                  Shows a list of commands or help for one command
  ```
  
  e.g. try
  ``` docker-machine ssh test uptime```
  
  and
  ``` docker-machine --debug ssh test uptime```

Log into the machine with ```docker-machine ssh test``` and play with docker commands from there.


### 2.5 Managing multiple machines

Now let's try creating more machines.

#### Create test2, test3, ...

Now use the appropriate command for your Operating System to create some more machines.

Then use ```docker-machine ls``` to see those machines

e.g.
```
$ docker-machine ls
NAME    ACTIVE   DRIVER   STATE     URL                         SWARM   DOCKER        ERRORS
test    *        kvm      Running   tcp://192.168.42.32:2376            v18.06.1-ce
test2   -        kvm      Running   tcp://192.168.42.176:2376           v18.06.1-ce
test3   -        kvm      Running   tcp://192.168.42.64:2376            v18.06.1-ce
```

Now experiment.

Note that *test* is the active machine (because environment variables are set for this machine.

Run a container on the "*test*" machine and then verify that the container is running on test and not on test2 or test3.

## 2.6 Create machines in the Cloud



## 2.7 Destroy all the machines

Finally let's clean up for now by destroying the machines we created.

Use the docker-machine rm command for this.

Lazy or super efficient ops people can do that with the following command:
```
docker-machine rm -f $(docker-machine ls -q)
```


>>>>>>> f5b20d3a0237b4a51766873352284b41f2fbf988

Docker-machine has official drivers for several hypervisors and Clouds (e.g. Hyoer-V, VirtualBox, Azure) and also some unofficial drivers (.e.g KVM).

Problems were encountered using the KVM driver on CentOS https://github.com/dhiltgen/docker-machine-kvm so for this TP we will use
- VirtualBox on CentOS 7
- Hyper-V on Windows 10


You can find the official documentation for '*Docker Machine*' here: [https://docs.docker.com/machine/](https://docs.docker.com/machine/)

The source code for '*Docker Machine*' is available here: [https://github.com/docker/machine](https://github.com/docker/machine)

If using '*Docker Desktop*' for Windows you already have *docker-machine*' installed, you can skip to <a href="#2-using-docker-machine"> step 2</a> "*Using docker-machine*" below.

## 1. Download docker-machine on CentOS 7

Go to the page [https://github.com/docker/machine/releases](https://github.com/docker/machine/releases) and download the latest Linux binary, e.g. [docker-machine-Linux-x86_64](https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Linux-x86_64).

```
wget -O docker-machine https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Linux-x86_64
```

Copy the binary to /usr/local/bin and set execution rights:

```
sudo mv docker-machine /usr/local/bin
sudo chmod +x /usr/local/bin/docker-machine
```

The VirtualBox driver is already included in the docker-machine binary.

### 1.1 Install VirtualBox

However we need to install VirtualBox.

Perform the following steps:

#### 1.1.1 Download and install the VirtualBox rpm:

```bash
  wget https://download.virtualbox.org/virtualbox/5.2.20/VirtualBox-5.2-5.2.20_125813
_el7-1.x86_64.rpm
  sudo yum install VirtualBox-5.2-5.2.20_125813_el7-1.x86_64.rpm
```

#### 1.1.2 Configure VirtualBox


We likely need to install some packages.

First try to run vboxconfig to see what it tells us.

```bash
  sudo /sbin/vboxconfig
```

We will probably be required to install some kernel development package and headers.


We will first install gcc and make and then those kernel packages (other packages may also be needed):
```bash
  sudo yum install gcc make
  sudo yum install kernel-devel kernel-devel-3.10.0-862.14.4.el7.x86_64
```

Check again with vboxconfig:
```bash
  sudo /sbin/vboxconfig
```

Check that we can list VMs (should produce no output so far):
```bash
    VBoxManage list vms
```

If no errors were seen then we're ready to use docker-machine with VirtualBox

## 2. Using docker-machine

To see what version you have installed
```
docker-machine version
```

you should see something similar to:


```bash
docker-machine version
```

    docker-machine version 0.15.0, build b48dc28d


### 2.1 Creating a machine:

We can now create our first machine.

#### On Windows:

You will first need to create a new virtual switch.

Open the "*Hyper-V Manager*" from the Windows task bar.

Then in the right-hand Actions pane click on "*Virtual Switch Manager*".

Create a new "*virtual network switch*" of type External and call it "*ext*".

Now you can create a machine using the command:

```
docker-machine create -d hyperv --hyperv-virtual-switch ext test
```

In case of errors, use the --debug option to debug:

```
docker-machine --debug create -d hyperv --hyperv-virtual-switch ext test
```


#### On CentOS:

Now you can create a machine using the command:

```
docker-machine create test
```

In case of errors, use the --debug option to debug:

```
docker-machine create --debug test
```

**NOTE**: That machine creation can take several minutes especially for the first time as it is necessary to download the "*boot2docker.iso*" which is roughly 48M Bytes.

An example output on creating the machine on CentOS is:


```bash
docker-machine create test
```

    Running pre-create checks...
    Creating machine...
    (test) Copying /home/mjb/.docker/machine/cache/boot2docker.iso to /home/mjb/.docker/machine/machines/test/boot2docker.iso...
    (test) Creating VirtualBox VM...
    (test) Creating SSH key...
    (test) Starting the VM...
    (test) Check network to re-create if needed...
    (test) Waiting for an IP...
    Waiting for machine to be running, this may take a few minutes...
    Detecting operating system of created instance...
    Waiting for SSH to be available...
    Detecting the provisioner...
    Provisioning with boot2docker...
    Copying certs to the local machine directory...
    Copying certs to the remote machine...
    Setting Docker configuration on the remote daemon...
    
    This machine has been allocated an IP address, but Docker Machine could not
    reach it successfully.
    
    SSH for the machine should still work, but connecting to exposed ports, such as
    the Docker daemon port (usually <ip>:2376), may not work properly.
    
    You may need to add the route manually, or use another related workaround.
    
    This could be due to a VPN, proxy, or host file configuration issue.
    
    You also might want to clear any VirtualBox host only interfaces you are not using.
    Checking connection to Docker...
    Docker is up and running!
    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env test


**NOTE**: If you run the "*docker-machine ls*" command whilst the creation is performing you may see errors such as shown below:

```bash
$ docker-machine ls
NAME   ACTIVE   DRIVER       STATE     URL   SWARM   DOCKER    ERRORS
test   *        virtualbox   Running                 Unknown   ssh command error:
command : ip addr show
err     : exit status 255
output  :

```

**You may ignore those errors whilst the creation is incomplete.**



```bash
$ docker-machine ls
NAME   ACTIVE   DRIVER       STATE     URL   SWARM   DOCKER    ERRORS
test   *        virtualbox   Running                 Unknown   ssh command error:
command : ip addr show
err     : exit status 255
output  :
```

**Despite the reported error our machine was created successfully as we can see below:**


```bash
docker-machine ls
```

    NAME   ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
    test   -        virtualbox   Running   tcp://192.168.99.100:2376           v18.06.1-ce   


However we will need to know more before we can connect to the daemon.

Try running (replacing the tcp: address with your output from "*docker-machine ls*"):


```bash
docker -H tcp://192.168.99.100:2376 ps
```

    Get http://192.168.99.100:2376/v1.38/containers/json: net/http: HTTP/1.x transport connection broken: malformed HTTP response "\x15\x03\x01\x00\x02\x02".
    * Are you trying to connect to a TLS-enabled daemon without TLS?




and you see that we need certificates to access the daemon.

### 2.3 Connecting to the docker daemon

docker-machine provides 2 ways to connect to the daemon.

We can provide the parameters to the docker client either through:
- command-line parameters
- shell environment variables

#### Connecting to the docker daemon - Using command-line parameters

We can use the *config* command to get the parameters we need to pass to the docker client:


```bash
docker-machine config test
```

    --tlsverify
    --tlscacert="/home/mjb/.docker/machine/machines/test/ca.pem"
    --tlscert="/home/mjb/.docker/machine/machines/test/cert.pem"
    --tlskey="/home/mjb/.docker/machine/machines/test/key.pem"
    -H=tcp://192.168.99.100:2376


So we can pass these parameters to the docker client at each invocation as follows:


```bash
docker $(docker-machine config test) version
```

    Client:
     Version:           18.06.1-ce
     API version:       1.38
     Go version:        go1.10.3
     Git commit:        e68fc7a
     Built:             Tue Aug 21 17:23:03 2018
     OS/Arch:           linux/amd64
     Experimental:      false
    
    Server:
     Engine:
      Version:          18.06.1-ce
      API version:      1.38 (minimum version 1.12)
      Go version:       go1.10.3
      Git commit:       e68fc7a
      Built:            Tue Aug 21 17:28:38 2018
      OS/Arch:          linux/amd64
      Experimental:     false


It may not be obvious that we are accessing a "*remote*" docker daemon.

Try ```docker $(docker-machine config test) info```
instead and in the output you should see the lines
```
Kernel Version: 4.9.93-boot2docker
Operating System: Boot2Docker 18.06.1-ce (TCL 8.2.1); HEAD : c7e5c3e - Wed Aug 22 16:27:42 UTC 2018
```


```bash
docker $(docker-machine config test) info
```

    Containers: 0
     Running: 0
     Paused: 0
     Stopped: 0
    Images: 0
    Server Version: 18.06.1-ce
    Storage Driver: aufs
     Root Dir: /mnt/sda1/var/lib/docker/aufs
     Backing Filesystem: extfs
     Dirs: 0
     Dirperm1 Supported: true
    Logging Driver: json-file
    Cgroup Driver: cgroupfs
    Plugins:
     Volume: local
     Network: bridge host macvlan null overlay
     Log: awslogs fluentd gcplogs gelf journald json-file logentries splunk syslog
    Swarm: inactive
    Runtimes: runc
    Default Runtime: runc
    Init Binary: docker-init
    containerd version: 468a545b9edcd5932818eb9de8e72413e616e86e
    runc version: 69663f0bd4b60df09991c08812a60108003fa340
    init version: fec3683
    Security Options:
     seccomp
      Profile: default
    Kernel Version: 4.9.93-boot2docker
    Operating System: Boot2Docker 18.06.1-ce (TCL 8.2.1); HEAD : c7e5c3e - Wed Aug 22 16:27:42 UTC 2018
    OSType: linux
    Architecture: x86_64
    CPUs: 1
    Total Memory: 995.6MiB
    Name: test
    ID: YQLX:TMSI:IRCB:FZHY:4BX7:B272:D7ON:AU4Q:FQJS:AZX4:FH3J:MXLD
    Docker Root Dir: /mnt/sda1/var/lib/docker
    Debug Mode (client): false
    Debug Mode (server): false
    Registry: https://index.docker.io/v1/
    Labels:
     provider=virtualbox
    Experimental: false
    Insecure Registries:
     127.0.0.0/8
    Live Restore Enabled: false
    


different from your Windows or CentOS host.

This is very handy, by providing different parameters to the docker client we can switch between different environments.

#### Connecting to the docker daemon - Using environment variables

The other way to connect is by using the "*env*" sub-command:


```bash
docker-machine env test
```

    export DOCKER_TLS_VERIFY="1"
    export DOCKER_HOST="tcp://192.168.99.100:2376"
    export DOCKER_CERT_PATH="/home/mjb/.docker/machine/machines/test"
    export DOCKER_MACHINE_NAME="test"
    # Run this command to configure your shell: 
    # eval $(docker-machine env test)


So run this command to configure your shell and the following commands will use those variables whic have been set/exported:


```bash
eval $(docker-machine env test)

env | grep DOCKER
```

    [01;31m[KDOCKER[m[K_HOST=tcp://192.168.99.100:2376
    [01;31m[KDOCKER[m[K_MACHINE_NAME=test
    [01;31m[KDOCKER[m[K_TLS_VERIFY=1
    [01;31m[KDOCKER[m[K_CERT_PATH=/home/mjb/.docker/machine/machines/test


Now any docker command from *this shell* will access our docker-machine host until we unset those variables.

Check this by running
```
docker info
```

to check that you see the same lines as before:
```
Kernel Version: 4.9.93-boot2docker
Operating System: Boot2Docker 18.06.1-ce (TCL 8.2.1); HEAD : c7e5c3e - Wed Aug 22 16:27:42 UTC 2018

## 2.4 docker-machine commands

Now let's investigate more of the commands docker-machine provides us with.

Enter the command ```docker-machine help```


```bash
docker-machine help
```

    Usage: docker-machine [OPTIONS] COMMAND [arg...]
    
    Create and manage machines running Docker.
    
    Version: 0.15.0, build b48dc28d
    
    Author:
      Docker Machine Contributors - <https://github.com/docker/machine>
    
    Options:
      --debug, -D						Enable debug mode
      --storage-path, -s "/home/mjb/.docker/machine"	Configures storage path [$MACHINE_STORAGE_PATH]
      --tls-ca-cert 					CA to verify remotes against [$MACHINE_TLS_CA_CERT]
      --tls-ca-key 						Private key to generate certificates [$MACHINE_TLS_CA_KEY]
      --tls-client-cert 					Client cert to use for TLS [$MACHINE_TLS_CLIENT_CERT]
      --tls-client-key 					Private key used in client TLS auth [$MACHINE_TLS_CLIENT_KEY]
      --github-api-token 					Token to use for requests to the Github API [$MACHINE_GITHUB_API_TOKEN]
      --native-ssh						Use the native (Go-based) SSH implementation. [$MACHINE_NATIVE_SSH]
      --bugsnag-api-token 					BugSnag API token for crash reporting [$MACHINE_BUGSNAG_API_TOKEN]
      --help, -h						show help
      --version, -v						print the version
      
    Commands:
      active		Print which machine is active
      config		Print the connection config for machine
      create		Create a machine
      env			Display the commands to set up the environment for the Docker client
      inspect		Inspect information about a machine
      ip			Get the IP address of a machine
      kill			Kill a machine
      ls			List machines
      provision		Re-provision existing machines
      regenerate-certs	Regenerate TLS Certificates for a machine
      restart		Restart a machine
      rm			Remove a machine
      ssh			Log into or run a command on a machine with SSH.
      scp			Copy files between machines
      mount			Mount or unmount a directory from a machine with SSHFS.
      start			Start a machine
      status		Get the status of a machine
      stop			Stop a machine
      upgrade		Upgrade a machine to the latest version of Docker
      url			Get the URL of a machine
      version		Show the Docker Machine version or a machine docker version
      help			Shows a list of commands or help for one command
      
    Run 'docker-machine COMMAND --help' for more information on a command.


#### Experiment

Experiment with the following commands subset, try also adding the ```--debug``` flag for more information.

```
  active                Print which machine is active
  config                Print the connection config for machine
  create                Create a machine
  env                   Display the commands to set up the environment for the Docker client
  inspect               Inspect information about a machine
  ip                    Get the IP address of a machine
  ls                    List machines
  ssh                   Log into or run a command on a machine with SSH.
  scp                   Copy files between machines
  status                Get the status of a machine
  url                   Get the URL of a machine
  version               Show the Docker Machine version or a machine docker version
  help                  Shows a list of commands or help for one command
  ```
  
  e.g. try
  ``` docker-machine ssh test uptime```
  
  and
  ``` docker-machine --debug ssh test uptime```

Log into the machine with ```docker-machine ssh test``` and play with docker commands from there.

e.g.


```bash
docker-machine ssh test -- docker run hello-world
```

    
    Hello from Docker!
    This message shows that your installation appears to be working correctly.
    
    To generate this message, Docker took the following steps:
     1. The Docker client contacted the Docker daemon.
     2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
     3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
     4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.
    
    To try something more ambitious, you can run an Ubuntu container with:
     $ docker run -it ubuntu bash
    
    Share images, automate workflows, and more with a free Docker ID:
     https://hub.docker.com/
    
    For more examples and ideas, visit:
     https://docs.docker.com/get-started/
    


which is equivalent to:


```bash
docker $(docker-machine config test) run hello-world
```

    
    Hello from Docker!
    This message shows that your installation appears to be working correctly.
    
    To generate this message, Docker took the following steps:
     1. The Docker client contacted the Docker daemon.
     2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
        (amd64)
     3. The Docker daemon created a new container from that image which runs the
        executable that produces the output you are currently reading.
     4. The Docker daemon streamed that output to the Docker client, which sent it
        to your terminal.
    
    To try something more ambitious, you can run an Ubuntu container with:
     $ docker run -it ubuntu bash
    
    Share images, automate workflows, and more with a free Docker ID:
     https://hub.docker.com/
    
    For more examples and ideas, visit:
     https://docs.docker.com/get-started/
    


### 2.5 Managing multiple machines

Now let's try creating more machines.

#### Create test2, test3, ...

Now use the appropriate command for your Operating System to create some more machines.

e.g. create test2 using the --debug option:

Then use ```docker-machine ls``` to see those machines


```bash
docker-machine ls
```

    NAME    ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
    test    *        virtualbox   Running   tcp://192.168.99.100:2376           v18.06.1-ce   
    test2   -        virtualbox   Running   tcp://192.168.99.101:2376           v18.06.1-ce   
    test3   -        virtualbox   Running   tcp://192.168.99.102:2376           v18.06.1-ce   


Now experiment.

Note that *test* is the active machine (because environment variables are set for this machine.

Run a container on the "*test*" machine and then verify that the container is running on test and not on test2 or test3.

## 2.6 Create machines in the Cloud

Your instructor will provide you with credentials to connect to an account on the DigitalOcean cloud.

Use these to create machines there as shown below.

You will be using the same account so use unique names for your machines, e.g.


```bash

. ~/.digitaloceanrc

docker-machine create -d digitalocean mike1
```

    Running pre-create checks...
    Creating machine...
    (mike1) Creating SSH key...
    (mike1) Creating Digital Ocean droplet...
    (mike1) Waiting for IP address to be assigned to the Droplet...
    Waiting for machine to be running, this may take a few minutes...
    Detecting operating system of created instance...
    Waiting for SSH to be available...
    Detecting the provisioner...
    Provisioning with ubuntu(systemd)...
    Installing Docker...
    Copying certs to the local machine directory...
    Copying certs to the remote machine...
    Setting Docker configuration on the remote daemon...
    Checking connection to Docker...
    Docker is up and running!
    To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env mike1



```bash
docker-machine ls
```

    NAME    ACTIVE   DRIVER         STATE     URL                         SWARM   DOCKER        ERRORS
    mike1   -        digitalocean   Running   tcp://159.203.68.249:2376           v18.06.1-ce   
    test    *        virtualbox     Running   tcp://192.168.99.100:2376           v18.06.1-ce   
    test2   -        virtualbox     Running   tcp://192.168.99.101:2376           v18.06.1-ce   
    test3   -        virtualbox     Running   tcp://192.168.99.102:2376           v18.06.1-ce   


So now we have several machines available to us, 3 locally and 1 in the cloud ...

## 2.7 Destroy all the machines

Finally let's clean up for now by destroying the machines we created.

Use the docker-machine rm command for this.

Lazy or super efficient ops people can do that with the following command:
```
docker-machine rm -f $(docker-machine ls -q)
```

**NOTE**: Try first ```bash docker-machine ls -q``` to see that it gives the list of just the machine names


```bash
docker-machine rm -f $(docker-machine ls -q)
```

    About to remove mike1, test, test2, test3
    WARNING: This action will delete both local reference and remote instance.
    Successfully removed mike1
    Successfully removed test
    Successfully removed test2
    Successfully removed test3



```bash
docker-machine ls
```

    NAME   ACTIVE   DRIVER   STATE   URL   SWARM   DOCKER   ERRORS



```bash

```
