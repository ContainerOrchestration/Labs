# TP6: Docker Machine

You can find the official documentation for '*Docker Machine*' here: [https://docs.docker.com/machine/](https://docs.docker.com/machine/)

The source code for '*Docker Machine*' is available here: [https://github.com/docker/machine](https://github.com/docker/machine)

If using '*Docker Desktop*' for Windows you already have *docker-machine*' installed, you can skip to step 2.

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
