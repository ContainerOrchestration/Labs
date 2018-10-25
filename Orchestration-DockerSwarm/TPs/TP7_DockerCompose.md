# TP7: Docker Compose

You can find the official documentation for '*Docker Compose*' here: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)

The source code for '*Docker Compose*' is available here: [https://github.com/docker/compose](https://github.com/docker/compose)

If using '*Docker Desktop*' for Windows you already have *docker-compose*' installed, you can skip to step 2.

## 1. Download docker-compose on CentOS 7

Go to the page [https://github.com/docker/compose/releases](https://github.com/docker/compose/releases) and download the latest Linux binary, e.g. [docker-compose-Linux-x86_64](https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-Linux-x86_64).

```
wget -O docker-compose https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-Linux-x86_64
```

Copy the binary to /usr/local/bin and set execution rights:

```
sudo mv docker-compose /usr/local/bin
sudo chmod +x /usr/local/bin/docker-compose
```


## 2. Using docker-compose

To see what version you have installed
```
docker-machine compose
```

you should see something similar to:
```
$ docker-compose version
docker-compose version 1.23.0-rc3, build ea3d406e
docker-py version: 3.5.0
CPython version: 3.6.6
OpenSSL version: OpenSSL 1.1.0f  25 May 2017
```

