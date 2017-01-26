


## - Kubernetes Lab




```bash
cd /home/mjb/MINIKUBE
#ls -altr
```


```bash
. minikube.rc
```

    minikubeVM: [01;31m[KStopped[m[K
    minikube is not running, docker-env not set



```bash
which docker; docker version
```

    ~/MINIKUBE/bin_0.14.0/docker
    Client:
     Version:      1.12.1
     API version:  1.24
     Go version:   go1.6.3
     Git commit:   23cf638
     Built:        Thu Aug 18 17:52:38 2016
     OS/Arch:      linux/amd64
    Error response from daemon: client is newer than server (client API version: 1.24, server API version: 1.22)





```bash
which minikube; minikube version
```

    ~/MINIKUBE/bin_0.14.0/minikube
    minikube version: v0.14.0



```bash
which kubectl; kubectl version
```

    ~/MINIKUBE/bin_0.14.0/kubectl
    Client Version: version.Info{Major:"1", Minor:"5", GitVersion:"v1.5.1", GitCommit:"82450d03cb057bab0950214ef122b67c83fb11df", GitTreeState:"clean", BuildDate:"2016-12-14T00:57:05Z", GoVersion:"go1.7.4", Compiler:"gc", Platform:"linux/amd64"}
    Unable to connect to the server: dial tcp 192.168.99.101:8443: i/o timeout





```bash
minikube status
```

    minikubeVM: Stopped
    localkube: N/A



```bash
minikube delete
```

    Deleting local Kubernetes cluster...
    Machine deleted.



```bash
#. minikube.rc
```

# 0. Kubernetes Cluster Creation

Using the minikube tool we can create a single-node Kubernetes cluster.

The cluster runs within a VirtualBox VM running the boot2docker.iso image.

To use this cluster we need just 3 executables:
- minikube itself
- the docker client
- the kubectl client


```bash
which minikube; which docker; which kubectl
ls -altrh $(which minikube)
```

    ~/MINIKUBE/bin_0.14.0/minikube
    ~/MINIKUBE/bin_0.14.0/docker
    ~/MINIKUBE/bin_0.14.0/kubectl
    -rwxrwxr-x. 1 mjb mjb 83M Dec 19 19:09 [0m[38;5;40m/home/mjb/MINIKUBE/bin_0.14.0/minikube[0m



```bash
docker version; minikube version; kubectl version
```

    Client:
     Version:      1.12.1
     API version:  1.24
     Go version:   go1.6.3
     Git commit:   23cf638
     Built:        Thu Aug 18 17:52:38 2016
     OS/Arch:      linux/amd64
    Error response from daemon: client is newer than server (client API version: 1.24, server API version: 1.22)
    minikube version: v0.14.0
    Client Version: version.Info{Major:"1", Minor:"5", GitVersion:"v1.5.1", GitCommit:"82450d03cb057bab0950214ef122b67c83fb11df", GitTreeState:"clean", BuildDate:"2016-12-14T00:57:05Z", GoVersion:"go1.7.4", Compiler:"gc", Platform:"linux/amd64"}
    Unable to connect to the server: dial tcp 192.168.99.101:8443: i/o timeout




minikube should not be already running:


```bash
minikube status
```

    minikubeVM: Does Not Exist
    localkube: N/A



```bash
minikube start
```

    Starting local Kubernetes cluster...
    Kubectl is now configured to use the cluster.


Once the cluster is started we can obtain the environment variables needed to allow our docker client to communicate with the cluster.


```bash
minikube docker-env
```

    export DOCKER_TLS_VERIFY="1"
    export DOCKER_HOST="tcp://192.168.99.100:2376"
    export DOCKER_CERT_PATH="/home/mjb/.minikube/certs"
    export DOCKER_API_VERSION="1.23"
    # Run this command to configure your shell: 
    # eval $(minikube docker-env)



```bash
eval $(minikube docker-env)
```

Running ```docker ps``` we can see the containers used to implement the cluster.


```bash
docker ps 
```

    CONTAINER ID        IMAGE                                              COMMAND                 CREATED             STATUS              PORTS               NAMES
    adf455d7a7b8        gcr.io/google-containers/kube-addon-manager:v6.1   "/opt/kube-addons.sh"   34 seconds ago      Up 33 seconds                           k8s_kube-addon-manager.96c28b3c_kube-addon-manager-minikube_kube-system_014fb8f91f3d52450a942179a984bc15_063a7c3c
    ea4fae0bfdef        gcr.io/google_containers/pause-amd64:3.0           "/pause"                47 seconds ago      Up 47 seconds                           k8s_POD.d8dbe16c_kube-addon-manager-minikube_kube-system_014fb8f91f3d52450a942179a984bc15_b8dd070a


We can also connect to the node (VM) on which the cluster is running by using the command

```minikube ssh```


```bash
minikube ssh uptime
```

     20:40:37 up 1 min,  1 users,  load average: 0.80, 0.64, 0.26



```bash
minikube ssh hostname
```

    minikube


Let's first cleanup any Pods, Services, Deployments whch may be running

(there should be none if we just started the cluster).


```bash
bash -x ./cleanup.sh
```

    ++ kubectl get deploy
    ++ tail -n +2
    ++ awk '{ print $1; }'
    No resources found.
    + DEPLOYMENTS=
    ++ kubectl get svc
    ++ tail -n +2
    ++ awk '{ print $1; }'
    ++ grep -v kubernetes
    + SERVICES=
    ++ kubectl get pods
    ++ tail -n +2
    ++ awk '{ print $1; }'
    No resources found.
    + PODS=
    + DELETE=0
    + DELETE=1
    + '[' '!' -z '' ']'
    + '[' '!' -z '' ']'
    + '[' '!' -z '' ']'
    + exit 0



```bash
kubectl get nodes
```

    NAME       STATUS    AGE
    minikube   Ready     2m



```bash
kubectl get pods
```

    No resources found.



```bash
kubectl get service
```

    NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
    kubernetes   10.0.0.1     <none>        443/TCP   2m



```bash
kubectl get deployments
```

    No resources found.


# Demo start

# 1. Creating a Cluster with minikube

The minikube executable is a tool created by the kubernetes project for performing demos/tutorials of a single-node kubernetes cluster.

# kubectl

kubectl is the kubernetes tool used for managing a cluster from the command-line.
It is based on the kubernetes API.

kubectl commands are of the form:

    kubectl <verb> <noun>
    
e.g.

    kubectl get nodes

to see what nodes exist in the cluster.


```bash
kubectl get nodes
```

    NAME       STATUS    AGE
    minikube   Ready     2m


Note that abbreviations exist, e.g. no for nodes

## 1. kubectl commands

We can get a list of available kubectl commands (verbs) just by typing kubectl


```bash
kubectl
```

    kubectl controls the Kubernetes cluster manager. 
    
    Find more information at https://github.com/kubernetes/kubernetes.
    
    Basic Commands (Beginner):
      create         Create a resource by filename or stdin
      expose         Take a replication controller, service, deployment or pod and
    expose it as a new Kubernetes Service
      run            Run a particular image on the cluster
      set            Set specific features on objects
    
    Basic Commands (Intermediate):
      get            Display one or many resources
      explain        Documentation of resources
      edit           Edit a resource on the server
      delete         Delete resources by filenames, stdin, resources and names, or
    by resources and label selector
    
    Deploy Commands:
      rollout        Manage a deployment rollout
      rolling-update Perform a rolling update of the given ReplicationController
      scale          Set a new size for a Deployment, ReplicaSet, Replication
    Controller, or Job
      autoscale      Auto-scale a Deployment, ReplicaSet, or ReplicationController
    
    Cluster Management Commands:
      certificate    Modify certificate resources.
      cluster-info   Display cluster info
      top            Display Resource (CPU/Memory/Storage) usage
      cordon         Mark node as unschedulable
      uncordon       Mark node as schedulable
      drain          Drain node in preparation for maintenance
      taint          Update the taints on one or more nodes
    
    Troubleshooting and Debugging Commands:
      describe       Show details of a specific resource or group of resources
      logs           Print the logs for a container in a pod
      attach         Attach to a running container
      exec           Execute a command in a container
      port-forward   Forward one or more local ports to a pod
      proxy          Run a proxy to the Kubernetes API server
      cp             Copy files and directories to and from containers.
    
    Advanced Commands:
      apply          Apply a configuration to a resource by filename or stdin
      patch          Update field(s) of a resource using strategic merge patch
      replace        Replace a resource by filename or stdin
      convert        Convert config files between different API versions
    
    Settings Commands:
      label          Update the labels on a resource
      annotate       Update the annotations on a resource
      completion     Output shell completion code for the given shell (bash or zsh)
    
    Other Commands:
      api-versions   Print the supported API versions on the server, in the form of
    "group/version"
      config         Modify kubeconfig files
      help           Help about any command
      version        Print the client and server version information
    
    Use "kubectl <command> --help" for more information about a given command.
    Use "kubectl options" for a list of global command-line options (applies to all
    commands).


Similarly we can get a list of subcommands (nouns) to which they can be applied.

```kubectl get```

will show us what items we can 'get':


```bash
kubectl get
```

    You must specify the type of resource to get. Valid resource types include:
    
        * clusters (valid only for federation apiservers)
        * componentstatuses (aka 'cs')
        * configmaps (aka 'cm')
        * daemonsets (aka 'ds')
        * deployments (aka 'deploy')
        * endpoints (aka 'ep')
        * events (aka 'ev')
        * horizontalpodautoscalers (aka 'hpa')
        * ingresses (aka 'ing')
        * jobs
        * limitranges (aka 'limits')
        * namespaces (aka 'ns')
        * networkpolicies
        * nodes (aka 'no')
        * persistentvolumeclaims (aka 'pvc')
        * persistentvolumes (aka 'pv')
        * pods (aka 'po')
        * podsecuritypolicies (aka 'psp')
        * podtemplates
        * replicasets (aka 'rs')
        * replicationcontrollers (aka 'rc')
        * resourcequotas (aka 'quota')
        * secrets
        * serviceaccounts (aka 'sa')
        * services (aka 'svc')
        * statefulsets
        * storageclasses
        * thirdpartyresources
        error: Required resource not specified.
    Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
    See 'kubectl get -h' for help and examples.





```bash
kubectl describe
```

    You must specify the type of resource to describe. Valid resource types include:
    
        * clusters (valid only for federation apiservers)
        * componentstatuses (aka 'cs')
        * configmaps (aka 'cm')
        * daemonsets (aka 'ds')
        * deployments (aka 'deploy')
        * endpoints (aka 'ep')
        * events (aka 'ev')
        * horizontalpodautoscalers (aka 'hpa')
        * ingresses (aka 'ing')
        * jobs
        * limitranges (aka 'limits')
        * namespaces (aka 'ns')
        * networkpolicies
        * nodes (aka 'no')
        * persistentvolumeclaims (aka 'pvc')
        * persistentvolumes (aka 'pv')
        * pods (aka 'po')
        * podsecuritypolicies (aka 'psp')
        * podtemplates
        * replicasets (aka 'rs')
        * replicationcontrollers (aka 'rc')
        * resourcequotas (aka 'quota')
        * secrets
        * serviceaccounts (aka 'sa')
        * services (aka 'svc')
        * statefulsets
        * storageclasses
        * thirdpartyresources
        error: Required resource not specified.
    See 'kubectl describe -h' for help and examples.





```bash
kubectl get nodes
```

    NAME       STATUS    AGE
    minikube   Ready     3m



```bash
kubectl describe nodes
```

    Name:			minikube
    Role:			
    Labels:			beta.kubernetes.io/arch=amd64
    			beta.kubernetes.io/os=linux
    			kubernetes.io/hostname=minikube
    Taints:			<none>
    CreationTimestamp:	Thu, 26 Jan 2017 21:39:37 +0100
    Phase:			
    Conditions:
      Type			Status	LastHeartbeatTime			LastTransitionTime			Reason				Message
      ----			------	-----------------			------------------			------				-------
      OutOfDisk 		False 	Thu, 26 Jan 2017 21:42:48 +0100 	Thu, 26 Jan 2017 21:39:37 +0100 	KubeletHasSufficientDisk 	kubelet has sufficient disk space available
      MemoryPressure 	False 	Thu, 26 Jan 2017 21:42:48 +0100 	Thu, 26 Jan 2017 21:39:37 +0100 	KubeletHasSufficientMemory 	kubelet has sufficient memory available
      DiskPressure 		False 	Thu, 26 Jan 2017 21:42:48 +0100 	Thu, 26 Jan 2017 21:39:37 +0100 	KubeletHasNoDiskPressure 	kubelet has no disk pressure
      Ready 		True 	Thu, 26 Jan 2017 21:42:48 +0100 	Thu, 26 Jan 2017 21:39:37 +0100 	KubeletReady 			kubelet is posting ready status
    Addresses:		192.168.99.100,192.168.99.100,minikube
    Capacity:
     alpha.kubernetes.io/nvidia-gpu:	0
     cpu:					2
     memory:				2050272Ki
     pods:					110
    Allocatable:
     alpha.kubernetes.io/nvidia-gpu:	0
     cpu:					2
     memory:				2050272Ki
     pods:					110
    System Info:
     Machine ID:			
     System UUID:			62940803-5658-462C-9E13-7BE6808A294E
     Boot ID:			e1b410fb-f669-45a4-a58c-a419ce09aff1
     Kernel Version:		4.4.14-boot2docker
     OS Image:			Boot2Docker 1.11.1 (TCL 7.1); master : 901340f - Fri Jul  1 22:52:19 UTC 2016
     Operating System:		linux
     Architecture:			amd64
     Container Runtime Version:	docker://1.11.1
     Kubelet Version:		v1.5.1
     Kube-Proxy Version:		v1.5.1
    ExternalID:			minikube
    Non-terminated Pods:		(5 in total)
      Namespace			Name					CPU Requests	CPU Limits	Memory Requests	Memory Limits
      ---------			----					------------	----------	---------------	-------------
      kube-system			heapster-zw4jl				0 (0%)		0 (0%)		0 (0%)		0 (0%)
      kube-system			influxdb-grafana-nmrrs			0 (0%)		0 (0%)		0 (0%)		0 (0%)
      kube-system			kube-addon-manager-minikube		5m (0%)		0 (0%)		50Mi (2%)	0 (0%)
      kube-system			kube-dns-v20-64cp0			110m (5%)	0 (0%)		120Mi (5%)	220Mi (10%)
      kube-system			kubernetes-dashboard-6gjbr		0 (0%)		0 (0%)		0 (0%)		0 (0%)
    Allocated resources:
      (Total limits may be over 100 percent, i.e., overcommitted.
      CPU Requests	CPU Limits	Memory Requests	Memory Limits
      ------------	----------	---------------	-------------
      115m (5%)	0 (0%)		170Mi (8%)	220Mi (10%)
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----			-------------	--------	------			-------
      3m		3m		1	{kube-proxy minikube}			Normal		Starting		Starting kube-proxy.
      3m		3m		1	{kubelet minikube}			Normal		Starting		Starting kubelet.
      3m		3m		1	{kubelet minikube}			Warning		ImageGCFailed		unable to find data for container /
      3m		3m		2	{kubelet minikube}			Normal		NodeHasSufficientDisk	Node minikube status is now: NodeHasSufficientDisk
      3m		3m		2	{kubelet minikube}			Normal		NodeHasSufficientMemory	Node minikube status is now: NodeHasSufficientMemory
      3m		3m		2	{kubelet minikube}			Normal		NodeHasNoDiskPressure	Node minikube status is now: NodeHasNoDiskPressure



```bash
kubectl get pods
```

    No resources found.



```bash
kubectl describe pods
```

We can get detailed help on the "get" command:


```bash
kubectl get --help
```

    Display one or many resources. 
    
    Valid resource types include: 
    
      * clusters (valid only for federation apiservers)  
      * componentstatuses (aka 'cs')  
      * configmaps (aka 'cm')  
      * daemonsets (aka 'ds')  
      * deployments (aka 'deploy')  
      * endpoints (aka 'ep')  
      * events (aka 'ev')  
      * horizontalpodautoscalers (aka 'hpa')  
      * ingresses (aka 'ing')  
      * jobs  
      * limitranges (aka 'limits')  
      * namespaces (aka 'ns')  
      * networkpolicies  
      * nodes (aka 'no')  
      * persistentvolumeclaims (aka 'pvc')  
      * persistentvolumes (aka 'pv')  
      * pods (aka 'po')  
      * podsecuritypolicies (aka 'psp')  
      * podtemplates  
      * replicasets (aka 'rs')  
      * replicationcontrollers (aka 'rc')  
      * resourcequotas (aka 'quota')  
      * secrets  
      * serviceaccounts (aka 'sa')  
      * services (aka 'svc')  
      * statefulsets  
      * storageclasses  
      * thirdpartyresources  
    
    This command will hide resources that have completed. For instance, pods that
    are in the Succeeded or Failed phases. You can see the full results for any
    resource by providing the '--show-all' flag. 
    
    By specifying the output as 'template' and providing a Go template as the value
    of the --template flag, you can filter the attributes of the fetched
    resource(s).
    
    Examples:
      # List all pods in ps output format.
      kubectl get pods
      
      # List all pods in ps output format with more information (such as node name).
      kubectl get pods -o wide
      
      # List a single replication controller with specified NAME in ps output
    format.
      kubectl get replicationcontroller web
      
      # List a single pod in JSON output format.
      kubectl get -o json pod web-pod-13je7
      
      # List a pod identified by type and name specified in "pod.yaml" in JSON
    output format.
      kubectl get -f pod.yaml -o json
      
      # Return only the phase value of the specified pod.
      kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
      
      # List all replication controllers and services together in ps output format.
      kubectl get rc,services
      
      # List one or more resources by their type and names.
      kubectl get rc/web service/frontend pods/web-pod-13je7
    
    Options:
          --all-namespaces=false: If present, list the requested object(s) across
    all namespaces. Namespace in current context is ignored even if specified with
    --namespace.
          --export=false: If true, use 'export' for the resources.  Exported
    resources are stripped of cluster-specific information.
      -f, --filename=[]: Filename, directory, or URL to files identifying the
    resource to get from a server.
          --include-extended-apis=true: If true, include definitions of new APIs via
    calls to the API server. [default true]
      -L, --label-columns=[]: Accepts a comma separated list of labels that are
    going to be presented as columns. Names are case-sensitive. You can also use
    multiple flag options like -L label1 -L label2...
          --no-headers=false: When using the default or custom-column output format,
    don't print headers.
      -o, --output='': Output format. One of:
    json|yaml|wide|name|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...
    See custom columns
    [http://kubernetes.io/docs/user-guide/kubectl-overview/#custom-columns], golang
    template [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath
    template [http://kubernetes.io/docs/user-guide/jsonpath].
          --output-version='': Output the formatted object with the given group
    version (for ex: 'extensions/v1beta1').
          --raw='': Raw URI to request from the server.  Uses the transport
    specified by the kubeconfig file.
      -R, --recursive=false: Process the directory used in -f, --filename
    recursively. Useful when you want to manage related manifests organized within
    the same directory.
      -l, --selector='': Selector (label query) to filter on
      -a, --show-all=false: When printing, show all resources (default hide
    terminated pods.)
          --show-kind=false: If present, list the resource type for the requested
    object(s).
          --show-labels=false: When printing, show all labels as the last column
    (default hide labels column)
          --sort-by='': If non-empty, sort list types using this field
    specification.  The field specification is expressed as a JSONPath expression
    (e.g. '{.metadata.name}'). The field in the API resource specified by this
    JSONPath expression must be an integer or a string.
          --template='': Template string or path to template file to use when
    -o=go-template, -o=go-template-file. The template format is golang templates
    [http://golang.org/pkg/text/template/#pkg-overview].
      -w, --watch=false: After listing/getting the requested object, watch for
    changes.
          --watch-only=false: Watch for changes to the requested object(s), without
    listing/getting first.
    
    Usage:
      kubectl get
    [(-o|--output=)json|yaml|wide|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...]
    (TYPE [NAME | -l label] | TYPE/NAME ...) [flags] [options]
    
    Use "kubectl options" for a list of global command-line options (applies to all
    commands).



```bash
kubectl version
```

    Client Version: version.Info{Major:"1", Minor:"5", GitVersion:"v1.5.1", GitCommit:"82450d03cb057bab0950214ef122b67c83fb11df", GitTreeState:"clean", BuildDate:"2016-12-14T00:57:05Z", GoVersion:"go1.7.4", Compiler:"gc", Platform:"linux/amd64"}
    Server Version: version.Info{Major:"1", Minor:"5", GitVersion:"v1.5.1", GitCommit:"82450d03cb057bab0950214ef122b67c83fb11df", GitTreeState:"clean", BuildDate:"1970-01-01T00:00:00Z", GoVersion:"go1.7.1", Compiler:"gc", Platform:"linux/amd64"}



```bash
kubectl cluster-info
```

    [0;32mKubernetes master[0m is running at [0;33mhttps://192.168.99.100:8443[0m
    [0;32mheapster[0m is running at [0;33mhttps://192.168.99.100:8443/api/v1/proxy/namespaces/kube-system/services/heapster[0m
    [0;32mKubeDNS[0m is running at [0;33mhttps://192.168.99.100:8443/api/v1/proxy/namespaces/kube-system/services/kube-dns[0m
    [0;32mkubernetes-dashboard[0m is running at [0;33mhttps://192.168.99.100:8443/api/v1/proxy/namespaces/kube-system/services/kubernetes-dashboard[0m
    [0;32mmonitoring-grafana[0m is running at [0;33mhttps://192.168.99.100:8443/api/v1/proxy/namespaces/kube-system/services/monitoring-grafana[0m
    [0;32mmonitoring-influxdb[0m is running at [0;33mhttps://192.168.99.100:8443/api/v1/proxy/namespaces/kube-system/services/monitoring-influxdb[0m
    
    To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.


## Opening the kubernetes dashboard


```bash
minikube dashboard
```

    Opening kubernetes dashboard in default browser...


# 2. Creating a Pod/Service/Deployment


### Kubernetes Deployments
Once you have a running Kubernetes cluster, you can deploy your containerized applications on top of it. To do so, you create a Kubernetes Deployment. The Deployment is responsible for creating and updating instances of your application. Once you've created a Deployment, the Kubernetes master schedules the application instances that the Deployment creates onto individual Nodes in the cluster.

Once the application instances are created, a Kubernetes Deployment Controller continuously monitors those instances. The Deployment controller replaces an instance if the Node hosting it goes down or it is deleted. This provides a self-healing mechanism to address machine failure or maintenance.

In a pre-orchestration world, installation scripts would often be used to start applications, but they did not allow recovery from machine failure. By both creating your application instances and keeping them running across Nodes, Kubernetes Deployments provide a fundamentally different approach to application management.


You can create and manage a Deployment by using the Kubernetes command line interface, Kubectl. Kubectl uses the Kubernetes API to interact with the cluster. In this module, you'll learn the most common Kubectl commands needed to create Deployments that run your applications on a Kubernetes cluster.

When you create a Deployment, you'll need to specify the container image for your application and the number of replicas that you want to run. You can change that information later by updating your Deployment; Modules 5 and 6 of the bootcamp discuss how you can scale and update your Deployments.

Applications need to be packaged into one of the supported container formats in order to be deployed on Kubernetes

For our first Deployment, we'll use a Node.js application packaged in a Docker container. The source code and the Dockerfile are available in the GitHub repository for the Kubernetes Bootcamp.

Now that you know what Deployments are, let's go to the online tutorial and deploy our first app!



Inspired by https://media-glass.es/launching-a-local-kubernetes-lab-using-minikube-39560f792889#.3h0n2dh3f

## 2.1 Deploying an app



```bash
kubectl run my-nginx --image=nginx --replicas=2 --port=80
```

    deployment "my-nginx" created


It may take some time for the pods to start as the node downloads the nginx image for the first time


```bash
kubectl get pods
```

    NAME                       READY     STATUS              RESTARTS   AGE
    my-nginx-379829228-bb8kr   0/1       ContainerCreating   0          2s
    my-nginx-379829228-qjtbt   0/1       ContainerCreating   0          2s



```bash
kubectl get pods
```

    NAME                       READY     STATUS    RESTARTS   AGE
    my-nginx-379829228-bb8kr   1/1       Running   0          1m
    my-nginx-379829228-qjtbt   1/1       Running   0          1m



```bash
kubectl describe deploy my-nginx
```

    Name:			my-nginx
    Namespace:		default
    CreationTimestamp:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:			run=my-nginx
    Selector:		run=my-nginx
    Replicas:		2 updated | 2 total | 2 available | 0 unavailable
    StrategyType:		RollingUpdate
    MinReadySeconds:	0
    RollingUpdateStrategy:	1 max unavailable, 1 max surge
    Conditions:
      Type		Status	Reason
      ----		------	------
      Available 	True	MinimumReplicasAvailable
    OldReplicaSets:	<none>
    NewReplicaSet:	my-nginx-379829228 (2/2 replicas created)
    Events:
      FirstSeen	LastSeen	Count	From				SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----				-------------	--------	------			-------
      37m		37m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled up replica set my-nginx-379829228 to 2


## 2.2 Accessing the app via kube-proxy

By default deployed applications are visible only inside the Kubernetes cluster. Exposing our application externally will be covered in Module 4. To view the application output without exposing it externally, we’ll create a route between our terminal and the Kubernetes cluster using a proxy:

By default deployed applications are visible only inside the Kubernetes cluster. Exposing our application externally will be covered in Module 4. To view the application output without exposing it externally, we’ll create a route between our terminal and the Kubernetes cluster using a proxy:

**In another terminal window launch**:
```
    kubectl proxy```
    
We now have a connection between our host (the online terminal) and the Kubernetes cluster. The started proxy enables direct access to the API. The app runs inside a Pod (we'll cover the Pod concept in next module). Get the name of the Pod and store it in the POD_NAME environment variable:



```bash
# In another windowkubectl proxy

export POD_NAMES=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Names of the Pods: $POD_NAMES
```

    Names of the Pods: my-nginx-379829228-bb8kr my-nginx-379829228-qjtbt



```bash
for POD_NAME in $POD_NAMES; do
    curl http://localhost:8001/api/v1/proxy/namespaces/default/pods/$POD_NAME/
    break
done
```

    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>
    
    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>
    
    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>


## 2.3 Service creation from kubectl


Exposing our deployment with type NodePort to make it available as a service on each cluster node


```bash
kubectl expose deployment my-nginx --type=NodePort
```

    service "my-nginx" exposed



```bash
kubectl get pods
```

    NAME                       READY     STATUS    RESTARTS   AGE
    my-nginx-379829228-bb8kr   1/1       Running   0          2m
    my-nginx-379829228-qjtbt   1/1       Running   0          2m



```bash
kubectl get deploy
```

    NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    my-nginx   2         2         2            2           3m


Now let's obtain the url of our 'my-nginx' service


```bash
minikube service my-nginx --url
```

    http://192.168.99.100:31155


#open $(minikube service my-nginx --url)

We can now access this url from our host, using curl or a web-browser:


```bash
curl $(minikube service my-nginx --url)
```

    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>
    
    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>
    
    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>


# 3. Viewing Pods


```bash
kubectl get pods
```

    NAME                       READY     STATUS    RESTARTS   AGE
    my-nginx-379829228-bb8kr   1/1       Running   0          21m
    my-nginx-379829228-qjtbt   1/1       Running   0          21m



```bash
kubectl describe pods
```

    Name:		my-nginx-379829228-bb8kr
    Namespace:	default
    Node:		minikube/192.168.99.100
    Start Time:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:		pod-template-hash=379829228
    		run=my-nginx
    Status:		Running
    IP:		172.17.0.7
    Controllers:	ReplicaSet/my-nginx-379829228
    Containers:
      my-nginx:
        Container ID:	docker://89e863b1d2d68b032d41bd7066e4a0216b0c75accccc4f0c2459a4ee241f705b
        Image:		nginx
        Image ID:		docker://sha256:cc1b614067128cd2f5cdafb258b0a4dd25760f14562bcce516c13f760c3b79c4
        Port:		80/TCP
        State:		Running
          Started:		Thu, 26 Jan 2017 21:59:30 +0100
        Ready:		True
        Restart Count:	0
        Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-rklxb (ro)
        Environment Variables:	<none>
    Conditions:
      Type		Status
      Initialized 	True 
      Ready 	True 
      PodScheduled 	True 
    Volumes:
      default-token-rklxb:
        Type:	Secret (a volume populated by a Secret)
        SecretName:	default-token-rklxb
    QoS Class:	BestEffort
    Tolerations:	<none>
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath			Type		Reason		Message
      ---------	--------	-----	----			-------------			--------	------		-------
      21m		21m		1	{default-scheduler }					Normal		Scheduled	Successfully assigned my-nginx-379829228-bb8kr to minikube
      21m		21m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulling		pulling image "nginx"
      20m		20m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulled		Successfully pulled image "nginx"
      20m		20m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Created		Created container with docker id 89e863b1d2d6; Security:[seccomp=unconfined]
      20m		20m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Started		Started container with docker id 89e863b1d2d6
    
    
    Name:		my-nginx-379829228-qjtbt
    Namespace:	default
    Node:		minikube/192.168.99.100
    Start Time:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:		pod-template-hash=379829228
    		run=my-nginx
    Status:		Running
    IP:		172.17.0.6
    Controllers:	ReplicaSet/my-nginx-379829228
    Containers:
      my-nginx:
        Container ID:	docker://3603cf070044df1bff255c1b36ea75119d0337dade08f244b1ab15a391f83959
        Image:		nginx
        Image ID:		docker://sha256:cc1b614067128cd2f5cdafb258b0a4dd25760f14562bcce516c13f760c3b79c4
        Port:		80/TCP
        State:		Running
          Started:		Thu, 26 Jan 2017 21:59:28 +0100
        Ready:		True
        Restart Count:	0
        Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-rklxb (ro)
        Environment Variables:	<none>
    Conditions:
      Type		Status
      Initialized 	True 
      Ready 	True 
      PodScheduled 	True 
    Volumes:
      default-token-rklxb:
        Type:	Secret (a volume populated by a Secret)
        SecretName:	default-token-rklxb
    QoS Class:	BestEffort
    Tolerations:	<none>
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath			Type		Reason		Message
      ---------	--------	-----	----			-------------			--------	------		-------
      21m		21m		1	{default-scheduler }					Normal		Scheduled	Successfully assigned my-nginx-379829228-qjtbt to minikube
      21m		21m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulling		pulling image "nginx"
      20m		20m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulled		Successfully pulled image "nginx"
      20m		20m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Created		Created container with docker id 3603cf070044; Security:[seccomp=unconfined]
      20m		20m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Started		Started container with docker id 3603cf070044



```bash
kubectl logs $POD_NAME
```

    172.17.0.1 - - [26/Jan/2017:21:24:23 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.49.0" "127.0.0.1"



```bash
kubectl exec $POD_NAME env
```

    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    HOSTNAME=my-nginx-379829228-bb8kr
    KUBERNETES_PORT_443_TCP_PROTO=tcp
    KUBERNETES_PORT_443_TCP_PORT=443
    KUBERNETES_PORT_443_TCP_ADDR=10.0.0.1
    KUBERNETES_SERVICE_HOST=10.0.0.1
    KUBERNETES_SERVICE_PORT=443
    KUBERNETES_SERVICE_PORT_HTTPS=443
    KUBERNETES_PORT=tcp://10.0.0.1:443
    KUBERNETES_PORT_443_TCP=tcp://10.0.0.1:443
    NGINX_VERSION=1.11.9-1~jessie
    HOME=/root



```bash
kubectl exec $POD_NAME hostname
```

    my-nginx-379829228-bb8kr


We can see the ip address of a pod (same ip address for all containers in that pod):


```bash
kubectl exec $POD_NAME ip a
```

    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host 
           valid_lft forever preferred_lft forever
    17: eth0@if18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
        link/ether 02:42:ac:11:00:07 brd ff:ff:ff:ff:ff:ff
        inet 172.17.0.7/16 scope global eth0
           valid_lft forever preferred_lft forever
        inet6 fe80::42:acff:fe11:7/64 scope link tentative dadfailed 
           valid_lft forever preferred_lft forever


# 4. Inspecting our service

A Service provides load balancing of traffic across the contained set of Pods. This is useful when a service is created to group all Pods from a specific Deployment (our application will make use of this in the next module, when we'll have multiple instances running).

Services are also responsible for service-discovery within the cluster (covered in Accessing the Service). This will for example allow a frontend service (like a web server) to receive traffic from a backend service (like a database) without worrying about Pods.

Services match a set of Pods using Label Selectors, a grouping primitive that allows logical operation on Labels.

Labels are key/value pairs that are attached to objects, such as Pods and you can think of them as hashtags from social media. They are used to organize related objects in a way meaningful to the users like:

Production environment (production, test, dev)
Application version (beta, v1.3)
Type of service/server (frontend, backend, database)
Labels are key/value pairs that are attached to objects


We have a Service called kubernetes that is created by default when minikube starts the cluster. To create a new service and expose it to external traffic we’ll use the expose command with NodePort as parameter (minikube does not support the LoadBalancer option yet)


```bash
kubectl get svc
```

    NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
    kubernetes   10.0.0.1     <none>        443/TCP        1h
    my-nginx     10.0.0.134   <nodes>       80:31155/TCP   38m



```bash
kubectl get services/my-nginx
```

    NAME       CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
    my-nginx   10.0.0.134   <nodes>       80:31155/TCP   38m


We can ssh into our minikube node to find it's eth1 ip address.
This is the address we will use to access our service (the address used for $DOCKER_HOST):


```bash
minikube ssh ip a show dev eth1
```

    4: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
        link/ether 08:00:27:20:27:96 brd ff:ff:ff:ff:ff:ff
        inet 192.168.99.100/24 brd 192.168.99.255 scope global eth1
           valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:fe20:2796/64 scope link 
           valid_lft forever preferred_lft forever



```bash
echo $DOCKER_HOST
```

    tcp://192.168.99.100:2376



```bash
HOST_IP=$(echo $DOCKER_HOST | sed -e 's/.*:\/\///' -e 's/:.*//')
echo HOST_IP=$HOST_IP
```

    HOST_IP=192.168.99.100


We can then use the describe service command to see which port (NodePort) is to be used:


```bash
kubectl describe svc my-nginx
```

    Name:			my-nginx
    Namespace:		default
    Labels:			run=my-nginx
    Selector:		run=my-nginx
    Type:			NodePort
    IP:			10.0.0.134
    Port:			<unset>	80/TCP
    NodePort:		<unset>	31155/TCP
    Endpoints:		172.17.0.6:80,172.17.0.7:80
    Session Affinity:	None
    No events.


So now we know on which port of our node we can access our service:

Let's access the port automatically


```bash
export NODE_PORT=$(kubectl get services/my-nginx -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT

#export NODE_IP=$(kubectl get services/my-nginx -o go-template='{{(index .spec.clusterIP)}}')
#echo NODE_IP=$NODE_IP
```

    NODE_PORT=31155



```bash
echo curl http://${HOST_IP}:${NODE_PORT}
curl http://${HOST_IP}:${NODE_PORT}
```

    curl http://192.168.99.100:31155
    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>
    
    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>
    
    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>



```bash
kubectl describe deploy
```

    Name:			my-nginx
    Namespace:		default
    CreationTimestamp:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:			run=my-nginx
    Selector:		run=my-nginx
    Replicas:		2 updated | 2 total | 2 available | 0 unavailable
    StrategyType:		RollingUpdate
    MinReadySeconds:	0
    RollingUpdateStrategy:	1 max unavailable, 1 max surge
    Conditions:
      Type		Status	Reason
      ----		------	------
      Available 	True	MinimumReplicasAvailable
    OldReplicaSets:	<none>
    NewReplicaSet:	my-nginx-379829228 (2/2 replicas created)
    Events:
      FirstSeen	LastSeen	Count	From				SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----				-------------	--------	------			-------
      42m		42m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled up replica set my-nginx-379829228 to 2


# 5. Accessing objects using label selectors

We saw above that all my-nginx pods have the label run=my-nginx.

We can use this to select only those pods:


```bash
kubectl get pods -l run=my-nginx
```

    NAME                       READY     STATUS    RESTARTS   AGE
    my-nginx-379829228-bb8kr   1/1       Running   0          43m
    my-nginx-379829228-qjtbt   1/1       Running   0          43m


#### Setting labels

We can also set labels on any object.

Let's set a label '*app=v1*' on just one of our nginx pods:



```bash
kubectl label pod $POD_NAME app=v1
```

    pod "my-nginx-379829228-bb8kr" labeled


Now running describe pod, we see both pods but only one of them has the '*app=v1*' label:


```bash
kubectl describe pod
```

    Name:		my-nginx-379829228-bb8kr
    Namespace:	default
    Node:		minikube/192.168.99.100
    Start Time:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:		app=v1
    		pod-template-hash=379829228
    		run=my-nginx
    Status:		Running
    IP:		172.17.0.7
    Controllers:	ReplicaSet/my-nginx-379829228
    Containers:
      my-nginx:
        Container ID:	docker://89e863b1d2d68b032d41bd7066e4a0216b0c75accccc4f0c2459a4ee241f705b
        Image:		nginx
        Image ID:		docker://sha256:cc1b614067128cd2f5cdafb258b0a4dd25760f14562bcce516c13f760c3b79c4
        Port:		80/TCP
        State:		Running
          Started:		Thu, 26 Jan 2017 21:59:30 +0100
        Ready:		True
        Restart Count:	0
        Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-rklxb (ro)
        Environment Variables:	<none>
    Conditions:
      Type		Status
      Initialized 	True 
      Ready 	True 
      PodScheduled 	True 
    Volumes:
      default-token-rklxb:
        Type:	Secret (a volume populated by a Secret)
        SecretName:	default-token-rklxb
    QoS Class:	BestEffort
    Tolerations:	<none>
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath			Type		Reason		Message
      ---------	--------	-----	----			-------------			--------	------		-------
      45m		45m		1	{default-scheduler }					Normal		Scheduled	Successfully assigned my-nginx-379829228-bb8kr to minikube
      45m		45m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulling		pulling image "nginx"
      43m		43m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulled		Successfully pulled image "nginx"
      43m		43m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Created		Created container with docker id 89e863b1d2d6; Security:[seccomp=unconfined]
      43m		43m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Started		Started container with docker id 89e863b1d2d6
    
    
    Name:		my-nginx-379829228-qjtbt
    Namespace:	default
    Node:		minikube/192.168.99.100
    Start Time:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:		pod-template-hash=379829228
    		run=my-nginx
    Status:		Running
    IP:		172.17.0.6
    Controllers:	ReplicaSet/my-nginx-379829228
    Containers:
      my-nginx:
        Container ID:	docker://3603cf070044df1bff255c1b36ea75119d0337dade08f244b1ab15a391f83959
        Image:		nginx
        Image ID:		docker://sha256:cc1b614067128cd2f5cdafb258b0a4dd25760f14562bcce516c13f760c3b79c4
        Port:		80/TCP
        State:		Running
          Started:		Thu, 26 Jan 2017 21:59:28 +0100
        Ready:		True
        Restart Count:	0
        Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-rklxb (ro)
        Environment Variables:	<none>
    Conditions:
      Type		Status
      Initialized 	True 
      Ready 	True 
      PodScheduled 	True 
    Volumes:
      default-token-rklxb:
        Type:	Secret (a volume populated by a Secret)
        SecretName:	default-token-rklxb
    QoS Class:	BestEffort
    Tolerations:	<none>
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath			Type		Reason		Message
      ---------	--------	-----	----			-------------			--------	------		-------
      45m		45m		1	{default-scheduler }					Normal		Scheduled	Successfully assigned my-nginx-379829228-qjtbt to minikube
      45m		45m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulling		pulling image "nginx"
      43m		43m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Pulled		Successfully pulled image "nginx"
      43m		43m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Created		Created container with docker id 3603cf070044; Security:[seccomp=unconfined]
      43m		43m		1	{kubelet minikube}	spec.containers{my-nginx}	Normal		Started		Started container with docker id 3603cf070044


Now we can select just pods with '*app=v1*':


```bash
kubectl get pod -l app=v1
```

    NAME                       READY     STATUS    RESTARTS   AGE
    my-nginx-379829228-bb8kr   1/1       Running   0          46m



```bash
kubectl delete service -l run=my-nginx
```

    No resources found



```bash
kubectl get service
```

    NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
    kubernetes   10.0.0.1     <none>        443/TCP   1h


# 4. Scaling an app


```bash
kubectl scale deployments/my-nginx --replicas=4
```

    deployment "my-nginx" scaled



```bash
kubectl get deploy
```

    NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    my-nginx   4         4         4            2           46m



```bash
kubectl get deploy
```

    NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    my-nginx   4         4         4            4           50m



```bash
kubectl get pods -o wide
```

    NAME                       READY     STATUS    RESTARTS   AGE       IP           NODE
    my-nginx-379829228-32kd8   1/1       Running   0          3m        172.17.0.9   minikube
    my-nginx-379829228-bb8kr   1/1       Running   0          50m       172.17.0.7   minikube
    my-nginx-379829228-qjtbt   1/1       Running   0          50m       172.17.0.6   minikube
    my-nginx-379829228-w5h0c   1/1       Running   0          3m        172.17.0.8   minikube



```bash
kubectl describe deploy/my-nginx
```

    Name:			my-nginx
    Namespace:		default
    CreationTimestamp:	Thu, 26 Jan 2017 21:58:01 +0100
    Labels:			run=my-nginx
    Selector:		run=my-nginx
    Replicas:		4 updated | 4 total | 4 available | 0 unavailable
    StrategyType:		RollingUpdate
    MinReadySeconds:	0
    RollingUpdateStrategy:	1 max unavailable, 1 max surge
    Conditions:
      Type		Status	Reason
      ----		------	------
      Available 	True	MinimumReplicasAvailable
    OldReplicaSets:	<none>
    NewReplicaSet:	my-nginx-379829228 (4/4 replicas created)
    Events:
      FirstSeen	LastSeen	Count	From				SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----				-------------	--------	------			-------
      52m		52m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled up replica set my-nginx-379829228 to 2
      5m		5m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled up replica set my-nginx-379829228 to 4



```bash
kubectl describe services/my-nginx
```

    Error from server (NotFound): services "my-nginx" not found





```bash
kubectl expose deployment my-nginx --type=NodePort
```

    service "my-nginx" exposed



```bash
kubectl describe services/my-nginx
```

    Name:			my-nginx
    Namespace:		default
    Labels:			run=my-nginx
    Selector:		run=my-nginx
    Type:			NodePort
    IP:			10.0.0.54
    Port:			<unset>	80/TCP
    NodePort:		<unset>	31715/TCP
    Endpoints:		172.17.0.6:80,172.17.0.7:80,172.17.0.8:80 + 1 more...
    Session Affinity:	None
    No events.



```bash
export NODE_PORT=$(kubectl get services/my-nginx -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT

HOST_IP=$(echo $DOCKER_HOST | sed -e 's/.*:\/\///' -e 's/:.*//')
```

    NODE_PORT=31715



```bash
curl $HOST_IP:$NODE_PORT
```

    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>
    
    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>
    
    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>



```bash
kubectl scale deployments/my-nginx --replicas=2
```

    deployment "my-nginx" scaled



```bash
kubectl get pods -o wide
```

    NAME                       READY     STATUS    RESTARTS   AGE       IP           NODE
    my-nginx-379829228-bb8kr   1/1       Running   0          53m       172.17.0.7   minikube
    my-nginx-379829228-qjtbt   1/1       Running   0          53m       172.17.0.6   minikube



```bash
kubectl get deploy
```

    NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    my-nginx   2         2         2            2           53m


# 5. Performing a Rolling Update

Updating an application
Users expect applications to be available all the time and developers are expected to deploy new versions of them several times a day. In Kubernetes this is done with rolling updates. Rolling updates allow Deployments' update to take place with zero downtime by incrementally updating Pods instances with new ones. The new Pods will be scheduled on Nodes with available resources.

In the previous module we scaled our application to run multiple instances. This is a requirement for performing updates without affecting application availability. By default, the maximum number of Pods that can be unavailable during the update and the maximum number of new Pods that can be created, is one. Both options can be configured to either numbers or percentages (of Pods). In Kubernetes, updates are versioned and any Deployment update can be reverted to previous (stable) version.

Similar to application Scaling, If a Deployment is exposed publicly, the Service will load-balance the traffic only to available Pods during the update. An available Pod is an instance that is available to the users of the application.

Rolling updates allow the following actions:

- Promote an application from one environment to another (via container image updates)
- Rollback to previous versions
- Continuous Integration and Continuous Delivery of applications with zero downtime



```bash
kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080
kubectl get deployments
```

    deployment "kubernetes-bootcamp" created
    NAME                  DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    kubernetes-bootcamp   1         1         1            0           0s
    my-nginx              2         2         2            2           53m


Wait until the pod is deployed - may need to download the *kubernetes-bootcamp* image:


```bash
kubectl get pods
```

    NAME                                  READY     STATUS              RESTARTS   AGE
    kubernetes-bootcamp-390780338-ch32m   0/1       ContainerCreating   0          3s
    my-nginx-379829228-bb8kr              1/1       Running             0          53m
    my-nginx-379829228-qjtbt              1/1       Running             0          53m



```bash
kubectl get pods
```

    NAME                                  READY     STATUS    RESTARTS   AGE
    kubernetes-bootcamp-390780338-ch32m   1/1       Running   0          6m
    my-nginx-379829228-bb8kr              1/1       Running   0          59m
    my-nginx-379829228-qjtbt              1/1       Running   0          59m


Now we can expose our deployment as a service


```bash
kubectl expose deployment kubernetes-bootcamp --type=NodePort --port=8080
```

    Error from server (AlreadyExists): services "kubernetes-bootcamp" already exists





```bash
kubectl describe services/kubernetes-bootcamp
```

    Name:			kubernetes-bootcamp
    Namespace:		default
    Labels:			run=kubernetes-bootcamp
    Selector:		run=kubernetes-bootcamp
    Type:			NodePort
    IP:			10.0.0.159
    Port:			<unset>	8080/TCP
    NodePort:		<unset>	30882/TCP
    Endpoints:		172.17.0.8:8080
    Session Affinity:	None
    No events.


Let's obtain the NODE_PORT so we can access the new '*bootcamp*' service:


```bash
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
```

    NODE_PORT=30882



```bash
curl $HOST_IP:$NODE_PORT
```

    Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-390780338-ch32m | v=1


### Perform the rolling update from v1 to v2


```bash
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
```

    deployment "kubernetes-bootcamp" image updated



```bash
kubectl rollout status deployments/kubernetes-bootcamp
```

    Waiting for rollout to finish: 0 of 1 updated replicas are available...
    deployment "kubernetes-bootcamp" successfully rolled out


Using '*kubectl describe*' we can see that initially when we created the deployment (1st event below) that version of '*kubernetes-bootcamp*' was scaled to 1.

Then when we performed the rollout we see the new version of '*kubernetes-bootcamp*' was scaled to 1 and once this was achieved, the old version was scaled back to 0, disabling the old version.


```bash
kubectl describe deployments/kubernetes-bootcamp
```

    Name:			kubernetes-bootcamp
    Namespace:		default
    CreationTimestamp:	Thu, 26 Jan 2017 22:51:28 +0100
    Labels:			run=kubernetes-bootcamp
    Selector:		run=kubernetes-bootcamp
    Replicas:		1 updated | 1 total | 1 available | 0 unavailable
    StrategyType:		RollingUpdate
    MinReadySeconds:	0
    RollingUpdateStrategy:	1 max unavailable, 1 max surge
    Conditions:
      Type		Status	Reason
      ----		------	------
      Available 	True	MinimumReplicasAvailable
    OldReplicaSets:	<none>
    NewReplicaSet:	kubernetes-bootcamp-2100875782 (1/1 replicas created)
    Events:
      FirstSeen	LastSeen	Count	From				SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----				-------------	--------	------			-------
      9m		9m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled up replica set kubernetes-bootcamp-390780338 to 1
      2m		2m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled up replica set kubernetes-bootcamp-2100875782 to 1
      2m		2m		1	{deployment-controller }			Normal		ScalingReplicaSet	Scaled down replica set kubernetes-bootcamp-390780338 to 0



```bash
kubectl rollout status deployments/kubernetes-bootcamp
```

    deployment "kubernetes-bootcamp" successfully rolled out

