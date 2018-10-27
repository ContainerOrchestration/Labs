# TP6: Docker Machine

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


