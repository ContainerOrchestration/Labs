# TP3: creation d'Images

## What images are available?

Investigate what images are already available on the system.

Let's pull some images:
```
docker pull hello-world
docker pull alpine
docker pull alpine:3.8
docker pull python:3.7-alpine
docker pull nginx
```
  
List the available images:
```
$ docker image ls
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
mjbright/docker-demo   1                   c114b78dde19        8 days ago          14.6MB
python                 3.7-alpine          408808fb1a9e        2 weeks ago         78.2MB
alpine                 3.8                 196d12cf6ab1        8 weeks ago         4.41MB
alpine                 latest              196d12cf6ab1        8 weeks ago         4.41MB
hello-world            latest              4ab4c602aa5e        2 months ago        1.84kB
```

Show them with their full sha256 id:
```
$ docker image ls --no-trunc
REPOSITORY             TAG                 IMAGE ID                                                                  CREATED             SIZE
mjbright/docker-demo   1                   sha256:c114b78dde195342d47cd21f1be12f26ae9d115096f6aafd6381fe910e6cee01   8 days ago          14.6MB
python                 3.7-alpine          sha256:408808fb1a9e38cef62186fac0480fe0fbcb2414a6f1c0b5a04a2a53a9183bdb   2 weeks ago         78.2MB
alpine                 3.8                 sha256:196d12cf6ab19273823e700516e98eb1910b03b17840f9d5509f03858484d321   8 weeks ago         4.41MB
alpine                 latest              sha256:196d12cf6ab19273823e700516e98eb1910b03b17840f9d5509f03858484d321   8 weeks ago         4.41MB
hello-world            latest              sha256:4ab4c602aa5eed5528a6620ff18a1dc4faef0e1ab3a5eddeddb410714478c67f   2 months ago        1.84kB
```

List just the alpine images:
```
$ docker image ls alpine
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
alpine              3.8                 196d12cf6ab1        8 weeks ago         4.41MB
alpine              latest              196d12cf6ab1        8 weeks ago         4.41MB
```

What other sub-commands of 'docker image' are available:
```
$ docker image

Usage:  docker image COMMAND

Manage images

Commands:
  build       Build an image from a Dockerfile
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Display detailed information on one or more images
  load        Load an image from a tar archive or STDIN
  ls          List images
  prune       Remove unused images
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rm          Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE

Run 'docker image COMMAND --help' for more information on a command.
```

Let's look at the history of the python:3.7-alpine image
```
$ docker history python:3.7-alpine
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
408808fb1a9e        2 weeks ago         /bin/sh -c #(nop)  CMD ["python3"]              0B       
<missing>           2 weeks ago         /bin/sh -c set -ex;   wget -O get-pip.py 'ht…   5.92MB   
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV PYTHON_PIP_VERSION=18…   0B       
<missing>           2 weeks ago         /bin/sh -c cd /usr/local/bin  && ln -s idle3…   32B      
<missing>           2 weeks ago         /bin/sh -c set -ex  && apk add --no-cache --…   67.3MB   
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV PYTHON_VERSION=3.7.1     0B       
<missing>           8 weeks ago         /bin/sh -c #(nop)  ENV GPG_KEY=0D96DF4D4110E…   0B       
<missing>           8 weeks ago         /bin/sh -c apk add --no-cache ca-certificates   556kB    
<missing>           8 weeks ago         /bin/sh -c #(nop)  ENV LANG=C.UTF-8             0B       
<missing>           8 weeks ago         /bin/sh -c #(nop)  ENV PATH=/usr/local/bin:/…   0B       
<missing>           8 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B       
<missing>           8 weeks ago         /bin/sh -c #(nop) ADD file:25c10b1d1b41d46a1…   4.41MB 
```

and the alpine image, notice that the last two lines are identical:
```
$ docker history alpine
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
196d12cf6ab1        8 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B       
<missing>           8 weeks ago         /bin/sh -c #(nop) ADD file:25c10b1d1b41d46a1…   4.41MB 
```

This is because each image is a stack of layers, and in this case the python:3.7-alpine image is built from the alpine image.

The last line starts with the addition ADD of a file, probably a tar archive of the minimal alpine linux.

Similarly if we look at 'hello-world' it also starts with a COPY (similar to ADD), in this case it is directly adding a static binary into the image:
```
$ docker image history hello-world
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
4ab4c602aa5e        2 months ago        /bin/sh -c #(nop)  CMD ["/hello"]               0B       
<missing>           2 months ago        /bin/sh -c #(nop) COPY file:9824c33ef192ac94…   1.84kB
```

In each case there is a layer specifying the default command to use when launching a container from this image.

We can also inspect an image for more information, including some meta information:
```
[
    {
        "Id": "sha256:4ab4c602aa5eed5528a6620ff18a1dc4faef0e1ab3a5eddeddb410714478c67f",
        "RepoTags": [
            "hello-world:latest"
        ],
        "RepoDigests": [
            "hello-world@sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788"
        ],
        "Parent": "",
        "Comment": "",
        "Created": "2018-09-07T19:25:39.809797627Z",
        "Container": "15c5544a385127276a51553acb81ed24a9429f9f61d6844db1fa34f46348e420",
        "ContainerConfig": {
            "Hostname": "15c5544a3851",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"/hello\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:9a5813f1116c2426ead0a44bbec252bfc5c3d445402cc1442ce9194fc1397027",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "DockerVersion": "17.06.2-ce",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/hello"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:9a5813f1116c2426ead0a44bbec252bfc5c3d445402cc1442ce9194fc1397027",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 1840,
        "VirtualSize": 1840,
        "GraphDriver": {
            "Data": {
                "MergedDir": "/var/lib/docker/overlay2/73a1a98b17684dff0def859797da940acde8d2a861fcdfcf8765f220017cfd3f/merged",
                "UpperDir": "/var/lib/docker/overlay2/73a1a98b17684dff0def859797da940acde8d2a861fcdfcf8765f220017cfd3f/diff",
                "WorkDir": "/var/lib/docker/overlay2/73a1a98b17684dff0def859797da940acde8d2a861fcdfcf8765f220017cfd3f/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:428c97da766c4c13b19088a471de6b622b038f3ae8efa10ec5a37d6d31a2df0b"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        }
    }
]
```

Do the same for the other images, what do you notice?

Note that the "VirtualSize" represents the total size of the image, i.e. the total size of all layers and the metadata.
(size of layers which we see easily with the 'docker image history' command).


## Finding images on Docker Hub:

There are 100's of thousands, probably a million images on Docker Hub.
Have a look, search for things of interest Python, Nginx, Apache, Ruby, Jenkins, ...

https://hub.docker.com/

Look at hello-world:
https://hub.docker.com/_/hello-world/

This is the official 'hello-world' repository.

**NOTE**: The repository is a collection of images with the same name 'hello-world' in this case with 1 or more tags.

Look at the 'Repo Info'.
In the description we can determine the github source repo from the link to issues.

Otherwise further down in the page we find a link to the repo:
'This image is a prime example of using the scratch image effectively. See hello.c in https://github.com/docker-library/hello-world for the source code of the hello binary included in this image.`

click on the 'Tags' link, you will see a list of the tagged images.

```
Scanned Images  
latestCompressed size: 977 B    Scanned 21 days ago       This image has no known vulnerabilities
linuxCompressed size:  977 B    Scanned 21 days ago       This image has no known vulnerabilities
```

Because this is an official image it is scanned for vulnerabilities.

Look also at the Python repository at https://hub.docker.com/r/library/python/tags/, we see that there are some vulnerabilities detected (as there would be in the corresponding Python binaries ... nothing to do with Docker itself).




## Finding images on command-line:

Search for images, e.g. 'hello-world' using the Docker client, e.g. 'docker image search hello-world'.





https://hub.docker.com/_/hello-world/
