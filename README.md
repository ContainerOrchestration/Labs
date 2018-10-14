# ContainerOrchestration Lab Setup

This document describes what you need to do to follow these labs
(Updated for PyConUS 2017, Portland, May 2017).

Once you're ready to come to the tutorial - meaning that either
- you decided what environment/mix of environments you'll use
- you don't know (no problem, we can advise)

to run different parts of the lab, please respond to the following anonymous survey.

This will help us to help you during the lab, to know what are your expectations, your experience and what environment you choose to use or if
you don't know what to choose.


## Pre-requisites
For this lab you will need a laptop either with specific software installed as described below or to browse to online cloud services.
- Minimum: Laptop with browser

Note that all labs can be performed online (but *may* require paid or free trial access) but you may wish to download software to run locally on your laptop.

### Running labs online

Links to online platforms are provided [BELOW](#ONLINE) with indications if fee or paid (with link to free trial).

### Running labs online
It is recommended that you download any software artifacts in advance to avoid installing over the conference network.
Links to software to install, where you choose to do so, are provided below.

We will bring most needed software for the labs, for Linux, MacOS, Windows, on USB key just in case.

Whilst the list of software is long, if you decide to install locally you will only need a subset of the software for your OS, and chosen solution.

## Choosing your environment by Lab:
There are 3 lab sections for Docker Swarm, Kubernetes and Apache Mesos and you may choose different solutions for each section, dependant upon
- What OS (Linux, MacOS, Windows prior to 10, Windows 10) you are running on your laptop
- Disk space available
- Existing cloud services you may be signed up to (e.g. Google Cloud, Micosoft Azure, Digital Ocean, AWS EC2) or wish to take a trial subscription
- Whether you want to keep the results on your laptop

<table>
<tbody>
<!-- <th bgcolor="#A0A0C0"> </th> -->
<!-- <tr bgcolor="#8080C0"> <td></td> <td></td> <td></td>  </tr> -->

<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td border=4 bgcolor="#A0A0C0"><b>   Lab      </b></td>
    <td border=4 bgcolor="#A0A0C0"><b> To run Online </b></td>
    <td border=4 bgcolor="#A0A0C0"><b> To run locally <br/>on your laptop </b></td> 
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Docker Swarm </td>
    <td>     play-with-docker</td>
    <td>
      <ul>
        <li>Linux: Use either
          <ul>
            <li>your distribution "<i>docker</i>" (>= docker-13.1)</li>
            <li>get.docker.com</li>
            <li>docker binaries</li>
          </ul>
        </li>
        <li>MacOS: Use Docker for Mac</li>
        <li>Windows before 10: Use Docker Toolkbox</li>
        <li>Windows 10: Use Docker for Windows</li>
        </ul>
        For all platforms: docker-machine
    </td>
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Kubernetes </td>
    <td>     Google Cloud</td>
    <td> Minikube, kubectl </td>
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Apache Mesos </td>
    <td>     play-with-docker<br/>(needs testing)</td>
    <td> As for Docker <br/> (TO SPECIFY: docker images to pull)</td>
</tr>
</tbody>
</table>

## Software for all Labs:
<table>
<tbody>
<tr bgcolor="#C0C0C0"> 
    <td><b>Software</b></td><td><b>Download URL</b></td><td><b> Download page </b></td> 
</tr>

<tr bgcolor="#C0C0C0"> 
    <td> Anaconda Python3 <br/>(recommended)<br/>(about 420 MBy)</td> <td> </td> <td> https://www.continuum.io/downloads </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> 'Docker' Python module <br/>(version 2.2.1)</td> <td> </td> <td> pip install docker </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> 'python-docker-machine' Python module <br/>(github)</td> <td> </td> <td> https://github.com/mjbright/python-docker-machine </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> 'Kubernetes' Python module <br/>(version 2.0)</td> <td> </td> <td> pip install kubernetes </td>
</tr>
</tbody>
</table>

## Software for Docker Lab:
<table>
<tbody>
<tr bgcolor="#C0C0C0"> 
    <td><b>Software</b></td><td><b>Download URL</b></td><td><b> Download page </b></td> 
</tr>

<tr bgcolor="#C0C0C0"> 
    <td> (Linux) get.docker.com </td> <td> (Linux) curl -sSL https://get.docker.com/ | sh</td> <td> https://docs.docker.com/engine/installation/</td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> (Linux) binaries </td> <td> https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz </td> <td> https://github.com/moby/moby/releases </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> Docker for Mac <br/>(about 110Mb)</td> <td> https://download.docker.com/mac/stable/Docker.dmg </td> <td> https://docs.docker.com/docker-for-mac/install/ </td>
</tr>
<tr bgcolor="#404040"> 
    <td> Docker Toolbox for Mac <br/>(about 200Mb)</td> <td> https://download.docker.com/mac/stable/DockerToolbox.pkg </td> <td> https://www.docker.com/products/docker-toolbox </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> Docker for Windows (10) <br/>(about 110Mb)</td> <td> https://download.docker.com/win/stable/InstallDocker.msi </td> <td> https://docs.docker.com/docker-for-windows/install/ </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> Docker Toolbox for Windows (&lt;10) <br/>(about 200Mb)</td> <td> https://download.docker.com/win/stable/DockerToolbox.exe </td> <td> https://www.docker.com/products/docker-toolbox </td>
</tr>
<tr bgcolor="#C0C0C0"> 
    <td> Docker-machine<br/>(about 24 MBy)</td> <td> https://github.com/docker/machine/releases </td> <td> https://docs.docker.com/machine/install-machine/ </td>
</tr>
</tbody>
</table>

## Software for Kubernetes Lab:
<table>
<tbody>
<tr bgcolor="#C0C0C0"> 
    <td><b>Software</b></td><td><b>Download URL</b></td><td><b> Download page </b></td> 
</tr>

<tr bgcolor="#C0C0C0">
    <td> Minikube<br/>(about 80 MBy) </td> <td>     </td> <td> https://github.com/kubernetes/minikube/releases </td>
</tr>

<tr bgcolor="#C0C0C0">
    <td> Kubectl<br/>(about 70 MBy)</td> <td>     </td> <td> https://kubernetes.io/docs/tasks/kubectl/install/ </td>
</tr>
<tr bgcolor="#C0C0C0">
    <td> Vagrant<br/>(about 80 MBy)</td> <td>     </td> <td> https://www.vagrantup.com/downloads.html </td>
</tr>
<tr bgcolor="#C0C0C0">
    <td> VirtualBox for macOS<br/>(about 90 MBy)</td> <td> http://download.virtualbox.org/virtualbox/5.1.22/VirtualBox-5.1.22-115126-OSX.dmg </td> <td> </td>
</tr>
<tr bgcolor="#C0C0C0">
    <td> VirtualBox for Windows<br/>(about 120 MBy)</td> <td> http://download.virtualbox.org/virtualbox/5.1.22/VirtualBox-5.1.22-115126-Win.exe </td> <td> </td>
</tr>

<tr bgcolor="#C0C0C0">
    <td> GCloud SDK </td> <td>     </td> <td> https://cloud.google.com/sdk/ </td>
</tr>

</tbody>
</table>

## Software for Apache Mesos Lab:
<table>
<tbody>
<tr bgcolor="#C0C0C0"> 
    <td><b>Software</b></td><td><b>Download URL</b></td><td><b> Download page </b></td> 
</tr>

<tr bgcolor="#C0C0C0">
    <td> Apache Mesos </td>
    <td>  TO SPECIFY: docker images</td>
    <td> </td>
</tr>
</tbody>
</table>


<a name="ONLINE" />

## Online platforms
<table>
<tbody>
<!-- <th bgcolor="#A0A0C0"> </th> -->
<!-- <tr bgcolor="#8080C0"> <td></td> <td></td> <td></td>  </tr> -->

<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td border=4 bgcolor="#A0A0C0"><b>   Platform      </b></td>
    <td border=4 bgcolor="#A0A0C0"><b> Free or Paid </b></td>
    <td border=4 bgcolor="#A0A0C0"><b> Free trial link </b></td> 
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Play-with-docker <br/>https://labs.play-with-docker.com </td> <td>     Free</td>  <td> N/A </td>
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Digital Ocean </td><td>Paid</td> <td> https://cloud.digitalocean.com/registrations/new </td>
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Google Cloud </td><td>   Paid  </td>
    <td> Google Cloud Platform with a $300 free credit for 12 months https://cloud.google.com/free/<br/>Best to install Google Cloud SDK</td>
</tr>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> Microsoft Azure </td><td> Paid </td><td> You receive 170 € of Azure credits with the Free Trial.   https://azure.microsoft.com/fr-fr/offers/ms-azr-0044p/ </td>
</tr>
</tbody>
<tr bgcolor="#C0C0C0"> <!-- Future Talk -->
    <td> AWS EC2 <br/> (difficulties with docker-machine) </td><td> Paid </td><td> 12 months free, https://aws.amazon.com/free/ </td>
</tr>
</tbody>
</table>

