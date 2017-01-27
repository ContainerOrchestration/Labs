layout: false
class: center, middle, inverse

##Container Orchestration: Which Conductor?
[.green.bold[The Lab]]
###Devconf.cz, Brno, Czech Republic, Jan 2017
<h3> <img width=120 src="images/Hewlett_Packard_Enterprise_whiteText_logo.svg" /> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Mike Bright, <img src="images/Twitter_Bird.svg" width=24 /> @mjbright </h3>
<h3> <img width=93 height=30 src="images/RedHat_whiteText_logo.svg" /> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Mario Loriedo, <img src="images/Twitter_Bird.svg" width=24 /> @mariolet </h3>
<h4>... and absent friends ...</h4>
<h4> <img width=93 height=30 src="images/RedHat_whiteText_logo.svg" /> &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp; Haikel Guemar, <img src="images/Twitter_Bird.svg" width=24 /> @hguemar </h4>


---
class: middle
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Agenda
We will look at each of
- Docker Swarm mode
- Kubernetes
- Apache Mesos

In less than 2 hours you won't become an expert but you will get good hands on experience.
]

---
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Pre-requisites for this lab:

To run these labs on your own machine you'll need
- a suitable hypervisor (VBox, libvirt).
- a recent docker client (>= docker1.12).
- docker-machine
- MINIKUBE for the Kubernetes lab

Lab instructions are here:
https://github.com/ContainerOrchestration/Labs/

These slides are here:
https://containerorchestration.github.io/Labs/Lab_remark.html

**NOTE:** The Docker Swarm lab can be run online on 
<a href="http://play-with-docker.com/"> http://play-with-docker.com </a> in which case you only need a web browser
]

---
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Pre-requisites for this lab:
Docker Swarm lab can be run either
- On your machine using docker-machine
    - See instructions <a href="https://github.com/ContainerOrchestration/Labs/blob/master/Orchestration-DockerSwarm/DockerSwarm.md">here</a>
- On <a href="http://play-with-docker.com/"> http://play-with-docker.com </a>
    - See instructions <a href="https://containerorchestration.github.io/Labs/Orchestration-DockerSwarm/DockerSwarm_PWD.html" >here</a>

Kubernetes lab can be run
  - On your machine using minikube (https://github.com/kubernetes/minikube/releases)
    - See instructions <a href="https://github.com/ContainerOrchestration/Labs/blob/master/Orchestration-Kubernetes/Kubernetes.md" >here</a>
  - On your machine using Haikel's Vagrant+Ansible scripts
    - See instructions <a href="https://github.com/mjbright/LinuxConEU-ContainerOrchestration" >here</a>

Apache Mesos can be run
  - On your machine using docker-machine
    - See instructions <a href="https://github.com/ContainerOrchestration/Labs/blob/master/Orchestration-ApacheMesos/Mesos.md" >here</a>

<!-- ... or other options ... -->
]

---
exclude:true
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Pre-requisites to run in the HPE infrastructure (recommended for this lab session)

To run in the HPE infrastructure you will need
- laptop
- OpenVPN client installed
    - https://openvpn.net/index.php/open-source/downloads.html

We will provide connection instructions on the day.
]

---
exclude:true
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Pre-requisites to run on your own laptop

To run on your own laptop you will need
- 8GBy RAM
- 20 GBy free disk space
- Vagrant
    - The provided Vagrantfile has been tested on CentOS 7 ad the libvirt provider
- Ansible 2.x

]

---
exclude:true
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Setup instructions to use the HPE Infrastructure
We will provide instructions on how to connect using OpenVPN on the day.

## Setup instructions to use your own laptop
Intructions are available here
https://github.com/mjbright/LinuxConEU-ContainerOrchestration/README.md#setup

Vagrant Box (to be provided - details at the above link)
]

---
.left-column[
## Lab
.footnote[.gray[ @hguemar @mjbright @mariolet ]]
]

.right-column[
## Lab contributions and Presentations

All materials are at
https://github.com/ContainerOrchestration/

Contributions are welcome !

In particular I'd love to be able to run Kubernetes and Mesos labs as multi-node under play-with-docker ...

Any extensions to these labs are welcome

]

---
name: section_docker
layout: false
class: center, middle, inverse
## Docker Swarm Lab
  <img src=images/docker.png width=100 /><br/>

???
SpeakerNotes:

---
name: section_docker
layout: false
class: center, middle
## Docker Swarm Architecture
  <img src=images/DockerSwarmArchi.svg width=800 />

???
SpeakerNotes:

---
name: section_docker
layout: false
class: center, middle
exclude: true
## Docker Swarm Lab Setup
- xx
- xx
- xx

???
SpeakerNotes:

---
name: section_docker
layout: false
class: center, middle
## Docker Swarm Lab


Docker Swarm lab can be run either
- On your machine using docker-machine
    - See instructions <a href="https://github.com/ContainerOrchestration/Labs/blob/master/Orchestration-DockerSwarm/DockerSwarm.md">here</a>
- On <a href="http://play-with-docker.com/"> http://play-with-docker.com </a>
    - See instructions <a href="https://containerorchestration.github.io/Labs/Orchestration-DockerSwarm/DockerSwarm_PWD.html" >here</a>


???
SpeakerNotes:

---
name: section_kube
layout: false
class: center, middle, inverse
## Kubernetes Lab
  <img src=images/kubernetes.png width=100 /><br/>


???
SpeakerNotes:

---
name: section_kube
layout: false
class: center, middle
## Kubernetes Architecture
  <img src=images/KubernetesArchi.svg width=800 />


???
SpeakerNotes:
---
name: section_kube
layout: false
class: center, middle
exclude: true
## Kubernetes Lab Setup
- xx
- xx
- xx

???
SpeakerNotes:


---
name: section_kube
layout: false
class: center, middle
## Kubernetes Lab

Kubernetes lab can be run
  - On your machine using minikube (https://github.com/kubernetes/minikube/releases)
    - See instructions <a href="https://github.com/ContainerOrchestration/Labs/blob/master/Orchestration-Kubernetes/Kubernetes.md" >here</a>
  - On your machine using Haikel's Vagrant+Ansible scripts
    - See instructions <a href="https://github.com/mjbright/LinuxConEU-ContainerOrchestration" >here</a>


???
SpeakerNotes:


---
name: section_mesos
layout: false
class: center, middle, inverse
## Apache Mesos Lab
  <img src=images/mesos-logo.png width=100 /><br/>

???
SpeakerNotes:

---
name: section_mesos
layout: false
class: center, middle
## Apache Mesos Architecture
  <img src=images/MesosArchi.svg width=800 />

???
SpeakerNotes:

---
name: section_mesos
layout: false
class: center, middle
exclude: true
## Apache Mesos Lab Setup
- xx
- xx
- xx

???
SpeakerNotes:


---
name: section_mesos
layout: false
class: center, middle
## Apache Mesos Lab


Apache Mesos can be run
  - On your machine using docker-machine
    - See instructions <a href="https://github.com/ContainerOrchestration/Labs/blob/master/Orchestration-ApacheMesos/Mesos.md" >here</a>

???
SpeakerNotes:


---
name: last-page
class: center, middle, inverse

# Questions?
<br/> <br/>

# Thank you
<br/> <br/>

<!--
<h3> <img width=120 src="images/Hewlett_Packard_Enterprise_whiteText_logo.svg" /> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; thanks to HPE for lending their infrastructure @HPE </h3>
<br/> <br/>
-->


.gray[ [Slideshow created using [remark](http://github.com/gnab/remark). ]]

.footnote[.gray[ @hguemar @mjbright @mariolet ]]

