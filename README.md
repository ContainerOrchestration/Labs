# ContainerOrchestration-ContainerOrchestration
Repository to contain "Container Orchestration" presentations
(originally presented at LinuxCon Europe, Berlin, Oct. 2016)

## Pre-requisites
For this lab will be using HPE infrastructure.

#### Install and configure OpenVPN
You will need to install an OpenVPN client on your laptop and connect to the provided
infrastructure.
You can download OpenVPN from here:
    - https://openvpn.net/index.php/open-source/downloads.html

3 servers are available each with 20 logins, group1 ... group 20

Please choose 1 group login (for yourself or for a pair of people) on 1 server.

Please update [this spreadsheet http://bit.ly/2dw5XBt](http://bit.ly/2dw5XBt) with your name to reserve a server/login group.

###### Download configuration files to use

You need to download the openvpn certificates to be able to access the lab.

- Please see the notes in cell F2 of the above Spreadsheet.

###### Startup OpenVPN

Startup openvpn as root user using the appropriate configuration file.

- Please see the notes in cell F2 of the above Spreadsheet.

###### Connect to your chosen server as your chosen user

For example if you chose 10.3.222.31 and group7:

    ssh group7@10.3.222.3

#### Following the lab

Please then follow the lab instructor as he runs through the lab steps.

or follow the respective README files here

[DockerSwarm.md](DockerSwarm.md)
[Kubernetes.md](Kubernetes.md)
[Mesos.md](Mesos.md)

<a name="prereq_remote" />
## Pre-requisites to run on your own laptop

To run on your own laptop you will need
- 8GBy RAM
- 20 GBy free disk space
- Vagrant
    - The provided Vagrantfile has been tested on CentOS 7 ad the libvirt provider
- Ansible 2.x



