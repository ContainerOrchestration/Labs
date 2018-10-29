
# TP2 Creation de Conteneurs

Commencons par demarrer quelques conteneurs de differents types.

# 1. docker run

## 1.1 hello-world

D'abord **lancez un container en utilisant le hello-world image** avec la commande ```docker run hello-world```

Ceci est un exemple d'une binaire statique de petite taille, nous verrons plutard de quoi il est constitue.


```bash
docker run hello-world
```

    Unable to find image 'hello-world:latest' locally
    latest: Pulling from library/hello-world
    
    [1BDigest: sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788
    Status: Downloaded newer image for hello-world:latest
    
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
    


Vous voyez que le telechargement de l'image est rapide car l'image est petite, il a moins de 2ko


```bash
docker images hello-world
```

    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    hello-world         latest              4ab4c602aa5e        7 weeks ago         1.84kB


**Lancer le container une 2eme fois** ca devrait etre encore plus rapide car il n'y a plus besoin de telecharge l'image.

Les images sont caches localement..

## 1.2 docker-demo

Cette fois-ci vous allez lancer un autre binaire statique.

Cette fois-ci vous allez le lancer
- en mode detache, en utilisant l'option -d ou --detach
- en specifiant d'exposer le port 8080 sur le port 8080 de la hote



```bash
docker run -d -p 8080:8080 mjbright/docker-demo:1
```

    7026c5d0520e375f7e1378f88a87161601718e9567864a176c8bda80f7d5908c


Vouz avez lance le container en mode detache.

Nous sommes informe du sha256 hash qui identifie notre container.

Regardez les processus qui tournent:


```bash
docker ps
```

    CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                    NAMES
    7026c5d0520e        mjbright/docker-demo:1   "/app/docker-demo -l…"   47 seconds ago      Up 45 seconds       0.0.0.0:8080->8080/tcp   stupefied_euclid


**Remarquez**:
- le colonne 'CONTAINER ID' montre le meme sha256 hash en forme tronque
- le dernier colonne 'NAMES' nous montre le nom auto-assigne par Docker
- qu'un mapping a ete cree entre le port de la hote 0.0.0.0:8080 vers le container 8080

**NOTE**: sans le port mapping on ne peut acceder au container qu'en connaissant son adresse IP (plutard)

Essayez d'acceder au container:


```bash
curl -sL http://127.0.0.1:8080
```

    
    
    
    [1;34m
                                                    .---------.                                          
                                                   .///++++/:.                                          
                                                   .///+++//:.                                          
                                                   .///+++//:.                                          
                                 ``````````````````.:///////:.                       `                  
                                 .-///////:://+++//::///////-.                      .--.                
                                 .:::///:::///+++///:::///:::.                     .:ss+-`              
                                 .:::///:::///+++///:::///:::.                    `.ossss:.             
                                 .:///////:/+++oo++/:///////:.                    .-ssssss:.            
                        .-:::::::--///////--:::::::--///////--:::::::-.           `-sssssso.........``  
                        .::////:::://+++///:::///:::///+++//:/::////::.           `.+ssssss/++ooooo+/:.`
                        .::////:::://+++///:::///:::///+++//:/::////::.            `.+sssooooooooooo/-` 
                        .::////:::://+++///:::///:::///+++//:/::////::.           ``.:osoooooooo+/:-.`  
                ````````.-:::::::--///////--:::::::-:///////--:::::::-.``````...-:/+ssoo+:-----..``     
                .-+++oooooooooooooooooooooooooooooooooooooooooooooooooooooooosssssssoooo-.              
          `     .-ooossssssssssssssssssssssss+ssssssssssssssssossssssssssssssssssoooooo:.        `      
        ``...```.-+++++/:--/+oosssssssoo++/:-.-:+oosssssso+/:..-:/+oossssssssoo+:--://-.`   ```...`     
     ````````````.-:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::-..```````````````  
                 .-////++++++++++++++++++++++++++++++++++++++++++++++++++//////////:.`                  
                 `.:////++++++++++++++++oss+++++++++++++++++++++++++++///////////:-.                    
                  `.:////++++++++++++++os.+h+++++++++++++++++++++++/////////////-.`                     
                   `.://///++++++++++//+soos+++++++++++++++++++///////////////-.`                       
                    `.--------:::://+o/+++++++++++++++++++/////////////////:-.`                         
                      `-sdmmmmmmmNNNNNmo+++++++++++/////////////////////:-.``                           
                        `-+hmmmmmmmmmmmms///////////////////////////::-.``                              
                          ``-+ydmmmmmmmmmds////////////////////::--.``                                  
                             ``.-/oshdmmmmmmho+////////::::--..```                                      
                                  ````..-:::///---.....````                                             
    
    [0m
    
    Served from container [1;33m7026c5d0520e[0;0m
    Using image mjbright/docker-demo:1


### 1.2.1 Acceder directement a l'adresse IP du container

Avec la commande ```docker inspect <container>``` on peut determiner l'adresse IP du container meme et se connecter directement au port 8080.

**NOTE**: C'est un exercise pour demontrer comment faire mais ce n'est pas reellement comme ca qu'on souhaite acceder aux applications.  Les containers sont ephemeres, ils peuvent mourir pour tant de raisons donc de s'adresser directement a un container par son adresse IP n'est pas une solution fiable.  Plutard nous regarderon l'utilisation de services comme solution fiable pour acceder a une groupe de containers qui peuvent tourner sur multiple hotes.

Determinez d'abord que le dernier container lancer ```docker ps -l```


```bash
docker ps -l
```

    CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                    NAMES
    c96abc4908a8        mjbright/docker-demo:1   "/app/docker-demo -l…"   13 seconds ago      Up 11 seconds       0.0.0.0:8080->8080/tcp   affectionate_darwin


On peut utiliser cette valeur pour inspecter le container et recuperer son adresse IP

**Executez la commande** ```docker inspect $(docker ps -ql)``` et examinez les informations fournis.

Maintenant on va recuperer explicitement l'adresse IP du container:


```bash
docker inspect $(docker ps -ql) | grep IPA
```


```bash
curl -sL 172.17.0.4:8080
```

    
    
    
    [1;34m
                                                    .---------.                                          
                                                   .///++++/:.                                          
                                                   .///+++//:.                                          
                                                   .///+++//:.                                          
                                 ``````````````````.:///////:.                       `                  
                                 .-///////:://+++//::///////-.                      .--.                
                                 .:::///:::///+++///:::///:::.                     .:ss+-`              
                                 .:::///:::///+++///:::///:::.                    `.ossss:.             
                                 .:///////:/+++oo++/:///////:.                    .-ssssss:.            
                        .-:::::::--///////--:::::::--///////--:::::::-.           `-sssssso.........``  
                        .::////:::://+++///:::///:::///+++//:/::////::.           `.+ssssss/++ooooo+/:.`
                        .::////:::://+++///:::///:::///+++//:/::////::.            `.+sssooooooooooo/-` 
                        .::////:::://+++///:::///:::///+++//:/::////::.           ``.:osoooooooo+/:-.`  
                ````````.-:::::::--///////--:::::::-:///////--:::::::-.``````...-:/+ssoo+:-----..``     
                .-+++oooooooooooooooooooooooooooooooooooooooooooooooooooooooosssssssoooo-.              
          `     .-ooossssssssssssssssssssssss+ssssssssssssssssossssssssssssssssssoooooo:.        `      
        ``...```.-+++++/:--/+oosssssssoo++/:-.-:+oosssssso+/:..-:/+oossssssssoo+:--://-.`   ```...`     
     ````````````.-:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::-..```````````````  
                 .-////++++++++++++++++++++++++++++++++++++++++++++++++++//////////:.`                  
                 `.:////++++++++++++++++oss+++++++++++++++++++++++++++///////////:-.                    
                  `.:////++++++++++++++os.+h+++++++++++++++++++++++/////////////-.`                     
                   `.://///++++++++++//+soos+++++++++++++++++++///////////////-.`                       
                    `.--------:::://+o/+++++++++++++++++++/////////////////:-.`                         
                      `-sdmmmmmmmNNNNNmo+++++++++++/////////////////////:-.``                           
                        `-+hmmmmmmmmmmmms///////////////////////////::-.``                              
                          ``-+ydmmmmmmmmmds////////////////////::--.``                                  
                             ``.-/oshdmmmmmmho+////////::::--..```                                      
                                  ````..-:::///---.....````                                             
    
    [0m
    
    Served from container [1;33mc96abc4908a8[0;0m
    Using image mjbright/docker-demo:1


## 1.3 Alpine Linux dans un container

Comme 3eme exemple lancer l'image '*officiel*' d'Alpine Linux avec la commande
```docker run -it alpine uptime```


```bash
docker run -it alpine uptime
```

    Unable to find image 'alpine:latest' locally
    latest: Pulling from library/alpine
    
    [1BDigest: sha256:621c2f39f8133acb8e64023a94dbdf0d5ca81896102b9e57c0dc184cadaf5528
    Status: Downloaded newer image for alpine:latest
     09:59:11 up 1 day, 21:06,  load average: 0.40, 0.37, 0.39


On peut **observer plusieurs choses**:
- on tire un image, une petite image d'ailleurs de taille **4.41 Mo** - un Linux miniature (busybox)
- nous specifions le mode interactive/tty avec options -i et -t (pas encore besoin pour uptime)
- nous specifions la commande '*uptime*' a executer
- L'uptime ne correspond pas a la vie de notre container qui viend d'etre lancer mais a la hote (CentOS).

Maintenant **lancez la meme commande** sans specifier '*uptime*':
```docker run -it alpine```

Vous allez vous trouvez dans un shell Linux.

*Essayez differentes commandes**:
- pwd
- ls
- df
- grep Free /proc/meminfo
- ip a
- hostname

**Comparer les valeurs** avec les meme commandes execute sur la hote.

**Vous en pensez quoi?**

Et pour une grande finale, essayer la commande (**attention dans le container - pas sur la hote!!**)
``` rm -rf /*```

ensuite vous ne peut plus faire grande choses ... plus de ls ou quoi que ce soit ...

### 1.3.1 Relancer Alpine Linux

Maintenant **relancer un container alpine linux**.
```docker run -it alpine```

Tout va bien a nouveau, pourquoi?

### 1.3.2 Le cycle de vie des containers

Nous avons lance plusieurs containers sans souci.

**Listez les containers qui tournent** avec ```docker ps```

maintenant **listez tous les containers**, y compris ce qui sont a l'arret, avec ```docker ps -a```

On voit que qu'on quitte un container, ou le container meurt il n'est que dans un etat "Exited".

**Identifie** le container dans lequel vous avez fait ```rm``` et reconnecte avec
    ```docker start <container>```
ou '*&lt;container&gt;*' represent soit le container id (ou les premieres characteres), ou le container name (pas l'image name).

# 2. Docker cli

## 2.1 Docker run options

On peut rajouter differents options aux containers.

**Essayez** ```docker run --help```

## 2.2 Ancien et nouveau style de commandes

Jusqu'a present nous avons utilise les commandes ```docker run```, ```docker ps```, ```docker images``` mais c'est des anciennes formes de commandes - mais plus court.

La nouvelle forme des commandes a ete introduit debut 2017 avec la sortie de Docker 1.13
[Whats new in Docker 1.13](https://blog.docker.com/2017/01/whats-new-in-docker-1-13/)

La nouvelle forme de ```docker run``` est ```docker container run```

Ils ont les memes options.

La nouvelle forme de ```docker ps``` est ```docker container list``` (ou ```docker container ls```)
La nouvelle forme de ```docker images``` est ```docker image list``` (ou ```docker image ls```)

**NOTE**: Ces changements sont au niveau du docker client, et n'affectent pas l'API.  Par contre la nouvelles forme

### 2.2.1 Investiguer les commandes du docker client

**Tapez la commande** ```docker help```


```bash
docker help
```

    
    Usage:	docker [OPTIONS] COMMAND
    
    A self-sufficient runtime for containers
    
    Options:
          --config string      Location of client config files (default
                               "/home/mjb/.docker")
      -D, --debug              Enable debug mode
      -H, --host list          Daemon socket(s) to connect to
      -l, --log-level string   Set the logging level
                               ("debug"|"info"|"warn"|"error"|"fatal")
                               (default "info")
          --tls                Use TLS; implied by --tlsverify
          --tlscacert string   Trust certs signed only by this CA (default
                               "/home/mjb/.docker/ca.pem")
          --tlscert string     Path to TLS certificate file (default
                               "/home/mjb/.docker/cert.pem")
          --tlskey string      Path to TLS key file (default
                               "/home/mjb/.docker/key.pem")
          --tlsverify          Use TLS and verify the remote
      -v, --version            Print version information and quit
    
    Management Commands:
      config      Manage Docker configs
      container   Manage containers
      image       Manage images
      network     Manage networks
      node        Manage Swarm nodes
      plugin      Manage plugins
      secret      Manage Docker secrets
      service     Manage services
      stack       Manage Docker stacks
      swarm       Manage Swarm
      system      Manage Docker
      trust       Manage trust on Docker images
      volume      Manage volumes
    
    Commands:
      attach      Attach local standard input, output, and error streams to a running container
      build       Build an image from a Dockerfile
      commit      Create a new image from a container's changes
      cp          Copy files/folders between a container and the local filesystem
      create      Create a new container
      diff        Inspect changes to files or directories on a container's filesystem
      events      Get real time events from the server
      exec        Run a command in a running container
      export      Export a container's filesystem as a tar archive
      history     Show the history of an image
      images      List images
      import      Import the contents from a tarball to create a filesystem image
      info        Display system-wide information
      inspect     Return low-level information on Docker objects
      kill        Kill one or more running containers
      load        Load an image from a tar archive or STDIN
      login       Log in to a Docker registry
      logout      Log out from a Docker registry
      logs        Fetch the logs of a container
      pause       Pause all processes within one or more containers
      port        List port mappings or a specific mapping for the container
      ps          List containers
      pull        Pull an image or a repository from a registry
      push        Push an image or a repository to a registry
      rename      Rename a container
      restart     Restart one or more containers
      rm          Remove one or more containers
      rmi         Remove one or more images
      run         Run a command in a new container
      save        Save one or more images to a tar archive (streamed to STDOUT by default)
      search      Search the Docker Hub for images
      start       Start one or more stopped containers
      stats       Display a live stream of container(s) resource usage statistics
      stop        Stop one or more running containers
      tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
      top         Display the running processes of a container
      unpause     Unpause all processes within one or more containers
      update      Update configuration of one or more containers
      version     Show the Docker version information
      wait        Block until one or more containers stop, then print their exit codes
    
    Run 'docker COMMAND --help' for more information on a command.


Choissisez un des management commandes est regarder le help, e.g.


```bash
docker container help
```

    
    Usage:	docker container COMMAND
    
    Manage containers
    
    Commands:
      attach      Attach local standard input, output, and error streams to a running container
      commit      Create a new image from a container's changes
      cp          Copy files/folders between a container and the local filesystem
      create      Create a new container
      diff        Inspect changes to files or directories on a container's filesystem
      exec        Run a command in a running container
      export      Export a container's filesystem as a tar archive
      inspect     Display detailed information on one or more containers
      kill        Kill one or more running containers
      logs        Fetch the logs of a container
      ls          List containers
      pause       Pause all processes within one or more containers
      port        List port mappings or a specific mapping for the container
      prune       Remove all stopped containers
      rename      Rename a container
      restart     Restart one or more containers
      rm          Remove one or more containers
      run         Run a command in a new container
      start       Start one or more stopped containers
      stats       Display a live stream of container(s) resource usage statistics
      stop        Stop one or more running containers
      top         Display the running processes of a container
      unpause     Unpause all processes within one or more containers
      update      Update configuration of one or more containers
      wait        Block until one or more containers stop, then print their exit codes
    
    Run 'docker container COMMAND --help' for more information on a command.




**Investiguer le *run* command** avec ```docker container run --help```


```bash
docker container run --help
```

    
    Usage:	docker container run [OPTIONS] IMAGE [COMMAND] [ARG...]
    
    Run a command in a new container
    
    Options:
          --add-host list                  Add a custom host-to-IP mapping
                                           (host:ip)
      -a, --attach list                    Attach to STDIN, STDOUT or STDERR
          --blkio-weight uint16            Block IO (relative weight),
                                           between 10 and 1000, or 0 to
                                           disable (default 0)
          --blkio-weight-device list       Block IO weight (relative device
                                           weight) (default [])
          --cap-add list                   Add Linux capabilities
          --cap-drop list                  Drop Linux capabilities
          --cgroup-parent string           Optional parent cgroup for the
                                           container
          --cidfile string                 Write the container ID to the file
          --cpu-period int                 Limit CPU CFS (Completely Fair
                                           Scheduler) period
          --cpu-quota int                  Limit CPU CFS (Completely Fair
                                           Scheduler) quota
          --cpu-rt-period int              Limit CPU real-time period in
                                           microseconds
          --cpu-rt-runtime int             Limit CPU real-time runtime in
                                           microseconds
      -c, --cpu-shares int                 CPU shares (relative weight)
          --cpus decimal                   Number of CPUs
          --cpuset-cpus string             CPUs in which to allow execution
                                           (0-3, 0,1)
          --cpuset-mems string             MEMs in which to allow execution
                                           (0-3, 0,1)
      -d, --detach                         Run container in background and
                                           print container ID
          --detach-keys string             Override the key sequence for
                                           detaching a container
          --device list                    Add a host device to the container
          --device-cgroup-rule list        Add a rule to the cgroup allowed
                                           devices list
          --device-read-bps list           Limit read rate (bytes per second)
                                           from a device (default [])
          --device-read-iops list          Limit read rate (IO per second)
                                           from a device (default [])
          --device-write-bps list          Limit write rate (bytes per
                                           second) to a device (default [])
          --device-write-iops list         Limit write rate (IO per second)
                                           to a device (default [])
          --disable-content-trust          Skip image verification (default true)
          --dns list                       Set custom DNS servers
          --dns-option list                Set DNS options
          --dns-search list                Set custom DNS search domains
          --entrypoint string              Overwrite the default ENTRYPOINT
                                           of the image
      -e, --env list                       Set environment variables
          --env-file list                  Read in a file of environment variables
          --expose list                    Expose a port or a range of ports
          --group-add list                 Add additional groups to join
          --health-cmd string              Command to run to check health
          --health-interval duration       Time between running the check
                                           (ms|s|m|h) (default 0s)
          --health-retries int             Consecutive failures needed to
                                           report unhealthy
          --health-start-period duration   Start period for the container to
                                           initialize before starting
                                           health-retries countdown
                                           (ms|s|m|h) (default 0s)
          --health-timeout duration        Maximum time to allow one check to
                                           run (ms|s|m|h) (default 0s)
          --help                           Print usage
      -h, --hostname string                Container host name
          --init                           Run an init inside the container
                                           that forwards signals and reaps
                                           processes
      -i, --interactive                    Keep STDIN open even if not attached
          --ip string                      IPv4 address (e.g., 172.30.100.104)
          --ip6 string                     IPv6 address (e.g., 2001:db8::33)
          --ipc string                     IPC mode to use
          --isolation string               Container isolation technology
          --kernel-memory bytes            Kernel memory limit
      -l, --label list                     Set meta data on a container
          --label-file list                Read in a line delimited file of labels
          --link list                      Add link to another container
          --link-local-ip list             Container IPv4/IPv6 link-local
                                           addresses
          --log-driver string              Logging driver for the container
          --log-opt list                   Log driver options
          --mac-address string             Container MAC address (e.g.,
                                           92:d0:c6:0a:29:33)
      -m, --memory bytes                   Memory limit
          --memory-reservation bytes       Memory soft limit
          --memory-swap bytes              Swap limit equal to memory plus
                                           swap: '-1' to enable unlimited swap
          --memory-swappiness int          Tune container memory swappiness
                                           (0 to 100) (default -1)
          --mount mount                    Attach a filesystem mount to the
                                           container
          --name string                    Assign a name to the container
          --network string                 Connect a container to a network
                                           (default "default")
          --network-alias list             Add network-scoped alias for the
                                           container
          --no-healthcheck                 Disable any container-specified
                                           HEALTHCHECK
          --oom-kill-disable               Disable OOM Killer
          --oom-score-adj int              Tune host's OOM preferences (-1000
                                           to 1000)
          --pid string                     PID namespace to use
          --pids-limit int                 Tune container pids limit (set -1
                                           for unlimited)
          --privileged                     Give extended privileges to this
                                           container
      -p, --publish list                   Publish a container's port(s) to
                                           the host
      -P, --publish-all                    Publish all exposed ports to
                                           random ports
          --read-only                      Mount the container's root
                                           filesystem as read only
          --restart string                 Restart policy to apply when a
                                           container exits (default "no")
          --rm                             Automatically remove the container
                                           when it exits
          --runtime string                 Runtime to use for this container
          --security-opt list              Security Options
          --shm-size bytes                 Size of /dev/shm
          --sig-proxy                      Proxy received signals to the
                                           process (default true)
          --stop-signal string             Signal to stop a container
                                           (default "SIGTERM")
          --stop-timeout int               Timeout (in seconds) to stop a
                                           container
          --storage-opt list               Storage driver options for the
                                           container
          --sysctl map                     Sysctl options (default map[])
          --tmpfs list                     Mount a tmpfs directory
      -t, --tty                            Allocate a pseudo-TTY
          --ulimit ulimit                  Ulimit options (default [])
      -u, --user string                    Username or UID (format:
                                           <name|uid>[:<group|gid>])
          --userns string                  User namespace to use
          --uts string                     UTS namespace to use
      -v, --volume list                    Bind mount a volume
          --volume-driver string           Optional volume driver for the
                                           container
          --volumes-from list              Mount volumes from the specified
                                           container(s)
      -w, --workdir string                 Working directory inside the container


**Experimentez*** avec la commande ```docker container run```

Lance le container image mjbright/docker-demo:1 a nouveau mais avec l'option '*-P*' cette fois-ci.

**Comment** acceder au container?


