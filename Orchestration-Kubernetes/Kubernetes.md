
# Kubernetes lab

First move to the source directory where you already downloaded the git repo sources:

git clone https://github.com/mjbright/LinuxConEU-ContainerOrchestration


```bash
pwd
```

    /home/group20/2016-Oct-31/LinuxConEU-ContainerOrchestration



```bash
git remote -v
```

    origin	https://github.com/mjbright/LinuxConEU-ContainerOrchestration (fetch)
    origin	https://github.com/mjbright/LinuxConEU-ContainerOrchestration (push)



```bash
cd labs
```

    


```bash
ls
```

    playbook.k8s  playbook.mesos  roles  Vagrantfile.multi	Vagrantfile.single


We first create symbolic links to use the appropriate playbook and Vagrantfile


```bash
ln -s playbook.k8s       playbook.yml
ln -s Vagrantfile.single Vagrantfile
```

    


```bash
ls -al
```

    total 28
    drwxrwxr-x. 3 group20 group20 4096 Oct 31 11:47 .
    drwxrwxr-x. 9 group20 group20 4096 Oct 31 11:46 ..
    -rw-rw-r--. 1 group20 group20  265 Oct 31 10:47 playbook.k8s
    -rw-rw-r--. 1 group20 group20  165 Oct 31 10:47 playbook.mesos
    lrwxrwxrwx. 1 group20 group20   12 Oct 31 11:47 playbook.yml -> playbook.k8s
    drwxrwxr-x. 9 group20 group20 4096 Oct 31 10:47 roles
    lrwxrwxrwx. 1 group20 group20   18 Oct 31 11:47 Vagrantfile -> Vagrantfile.single
    -rw-rw-r--. 1 group20 group20 1956 Oct 31 10:47 Vagrantfile.multi
    -rw-rw-r--. 1 group20 group20 1720 Oct 31 10:47 Vagrantfile.single


# Create our lab environment using Vagrant

Now we have selected which Vagrantfile we use we can let Vagrant startup our virtual machine.

The
```shell
vagrant up```
command will take several minutes to complete and will invoke ansible to provision Kubernetes on our node as show below:


```bash
vagrant up
```

    [0mBringing machine 'node1' up with 'virtualbox' provider...[0m
    [1m==> node1: Box 'centos/7' could not be found. Attempting to find and install...[0m
    [0m    node1: Box Provider: virtualbox[0m
    [0m    node1: Box Version: >= 0[0m
    [1m==> node1: Loading metadata for box 'centos/7'[0m
    [0m    node1: URL: https://atlas.hashicorp.com/centos/7[0m
    [1m==> node1: Adding box 'centos/7' (v1609.01) for provider: virtualbox[0m
    [0m    node1: Downloading: https://atlas.hashicorp.com/centos/boxes/7/versions/1609.01/providers/virtualbox.box[0m
    [K[0m[1;32m==> node1: Successfully added box 'centos/7' (v1609.01) for 'virtualbox'![0m
    [1m==> node1: Importing base box 'centos/7'...[0m
    [K[0m[1m==> node1: Matching MAC address for NAT networking...[0m
    [1m==> node1: Checking if box 'centos/7' is up to date...[0m
    [1m==> node1: Setting the name of the VM: labs_node1_1477910979585_72722[0m
    [1m==> node1: Clearing any previously set network interfaces...[0m
    [1m==> node1: Preparing network interfaces based on configuration...[0m
    [0m    node1: Adapter 1: nat[0m
    [1m==> node1: Forwarding ports...[0m
    [0m    node1: 80 (guest) => 8080 (host) (adapter 1)[0m
    [0m    node1: 6080 (guest) => 6080 (host) (adapter 1)[0m
    [0m    node1: 22 (guest) => 2222 (host) (adapter 1)[0m
    [1m==> node1: Booting VM...[0m
    [1m==> node1: Waiting for machine to boot. This may take a few minutes...[0m
    [0m    node1: SSH address: 127.0.0.1:2222[0m
    [0m    node1: SSH username: vagrant[0m
    [0m    node1: SSH auth method: private key[0m
    [0m    node1: 
        node1: Vagrant insecure key detected. Vagrant will automatically replace
        node1: this with a newly generated keypair for better security.[0m
    [0m    node1: 
        node1: Inserting generated public key within guest...[0m
    [0m    node1: Removing insecure key from the guest if it's present...[0m
    [0m    node1: Key inserted! Disconnecting and reconnecting using new SSH key...[0m
    [1m==> node1: Machine booted and ready![0m
    [1m==> node1: Checking for guest additions in VM...[0m
    [0m    node1: No guest additions were detected on the base box for this VM! Guest
        node1: additions are required for forwarded ports, shared folders, host only
        node1: networking, and more. If SSH fails on this machine, please install
        node1: the guest additions and repackage the box to continue.
        node1: 
        node1: This is not an error message; everything may continue to work properly,
        node1: in which case you may ignore this message.[0m
    [1m==> node1: Setting hostname...[0m
    [1m==> node1: Rsyncing folder: /home/group20/2016-Oct-31/LinuxConEU-ContainerOrchestration/labs/ => /vagrant[0m
    [1m==> node1: Running provisioner: ansible...[0m
    [0m    node1: Running ansible-playbook...[0m
    [0mPYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ANSIBLE_HOST_KEY_CHECKING=false ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o ControlMaster=auto -o ControlPersist=60s' ansible-playbook --connection=ssh --timeout=30 --limit="node1" --inventory-file=/home/group20/2016-Oct-31/LinuxConEU-ContainerOrchestration/labs/.vagrant/provisioners/ansible/inventory -v playbook.yml[0m
    [0mUsing /etc/ansible/ansible.cfg as config file
    [0m[0m
    PLAY [all] *********************************************************************
    [0m[0m
    TASK [setup] *******************************************************************
    [0m[0m[0;32mok: [node1][0m
    [0m[0m
    TASK [base : install epel repository] ******************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "msg": "warning: /var/cache/yum/x86_64/7/extras/packages/epel-release-7-6.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY\nImporting GPG key 0xF4A80EB5:\n Userid     : \"CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>\"\n Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5\n Package    : centos-release-7-2.1511.el7.centos.2.10.x86_64 (@anaconda)\n From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\n", "rc": 0, "results": ["Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: miroir.univ-paris13.fr\n * extras: centos.quelquesmots.fr\n * updates: centos.quelquesmots.fr\nResolving Dependencies\n--> Running transaction check\n---> Package epel-release.noarch 0:7-6 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package                Arch             Version         Repository        Size\n================================================================================\nInstalling:\n epel-release           noarch           7-6             extras            14 k\n\nTransaction Summary\n================================================================================\nInstall  1 Package\n\nTotal download size: 14 k\nInstalled size: 24 k\nDownloading packages:\nPublic key for epel-release-7-6.noarch.rpm is not installed\nRetrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : epel-release-7-6.noarch                                      1/1 \n  Verifying  : epel-release-7-6.noarch                                      1/1 \n\nInstalled:\n  epel-release.noarch 0:7-6                                                     \n\nComplete!\n"]}[0m
    [0m[0m
    TASK [base : install utilities] ************************************************
    [0m[0m[0;33mchanged: [node1] => (item=[u'emacs-nox', u'git', u'tmux', u'zsh', u'yum-utils', u'bash-completion', u'crudini']) => {"changed": true, "item": ["emacs-nox", "git", "tmux", "zsh", "yum-utils", "bash-completion", "crudini"], "msg": "warning: /var/cache/yum/x86_64/7/epel/packages/crudini-0.7-1.el7.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY\nImporting GPG key 0x352C64E5:\n Userid     : \"Fedora EPEL (7) <epel@fedoraproject.org>\"\n Fingerprint: 91e9 7d7c 4a5e 96f1 7f3e 888f 6a2f aea2 352c 64e5\n Package    : epel-release-7-6.noarch (@extras)\n From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7\n", "rc": 0, "results": ["yum-utils-1.1.31-34.el7.noarch providing yum-utils is already installed", "bash-completion-1:2.1-6.el7.noarch providing bash-completion is already installed", "Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: miroir.univ-paris13.fr\n * epel: epel.mirrors.ovh.net\n * extras: centos.quelquesmots.fr\n * updates: centos.quelquesmots.fr\nResolving Dependencies\n--> Running transaction check\n---> Package crudini.noarch 0:0.7-1.el7 will be installed\n---> Package emacs-nox.x86_64 1:24.3-18.el7 will be installed\n--> Processing Dependency: emacs-common = 1:24.3-18.el7 for package: 1:emacs-nox-24.3-18.el7.x86_64\n--> Processing Dependency: libgpm.so.2()(64bit) for package: 1:emacs-nox-24.3-18.el7.x86_64\n---> Package git.x86_64 0:1.8.3.1-6.el7_2.1 will be installed\n--> Processing Dependency: perl-Git = 1.8.3.1-6.el7_2.1 for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl >= 5.008 for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(warnings) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(vars) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(strict) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(lib) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(Term::ReadKey) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(Git) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(Getopt::Long) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::stat) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::Temp) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::Spec) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::Path) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::Find) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::Copy) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(File::Basename) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(Exporter) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: perl(Error) for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: /usr/bin/perl for package: git-1.8.3.1-6.el7_2.1.x86_64\n--> Processing Dependency: libgnome-keyring.so.0()(64bit) for package: git-1.8.3.1-6.el7_2.1.x86_64\n---> Package tmux.x86_64 0:1.8-4.el7 will be installed\n---> Package zsh.x86_64 0:5.0.2-14.el7_2.2 will be installed\n--> Running transaction check\n---> Package emacs-common.x86_64 1:24.3-18.el7 will be installed\n--> Processing Dependency: emacs-filesystem for package: 1:emacs-common-24.3-18.el7.x86_64\n--> Processing Dependency: liblockfile.so.1()(64bit) for package: 1:emacs-common-24.3-18.el7.x86_64\n---> Package gpm-libs.x86_64 0:1.20.7-5.el7 will be installed\n---> Package libgnome-keyring.x86_64 0:3.8.0-3.el7 will be installed\n---> Package perl.x86_64 4:5.16.3-286.el7 will be installed\n--> Processing Dependency: perl-libs = 4:5.16.3-286.el7 for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Socket) >= 1.3 for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Scalar::Util) >= 1.10 for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl-macros for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl-libs for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(threads::shared) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(threads) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(constant) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Time::Local) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Time::HiRes) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Storable) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Socket) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Scalar::Util) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Pod::Simple::XHTML) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Pod::Simple::Search) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Filter::Util::Call) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: perl(Carp) for package: 4:perl-5.16.3-286.el7.x86_64\n--> Processing Dependency: libperl.so()(64bit) for package: 4:perl-5.16.3-286.el7.x86_64\n---> Package perl-Error.noarch 1:0.17020-2.el7 will be installed\n---> Package perl-Exporter.noarch 0:5.68-3.el7 will be installed\n---> Package perl-File-Path.noarch 0:2.09-2.el7 will be installed\n---> Package perl-File-Temp.noarch 0:0.23.01-3.el7 will be installed\n---> Package perl-Getopt-Long.noarch 0:2.40-2.el7 will be installed\n--> Processing Dependency: perl(Pod::Usage) >= 1.14 for package: perl-Getopt-Long-2.40-2.el7.noarch\n--> Processing Dependency: perl(Text::ParseWords) for package: perl-Getopt-Long-2.40-2.el7.noarch\n---> Package perl-Git.noarch 0:1.8.3.1-6.el7_2.1 will be installed\n---> Package perl-PathTools.x86_64 0:3.40-5.el7 will be installed\n---> Package perl-TermReadKey.x86_64 0:2.30-20.el7 will be installed\n--> Running transaction check\n---> Package emacs-filesystem.noarch 1:24.3-18.el7 will be installed\n---> Package liblockfile.x86_64 0:1.08-17.el7 will be installed\n---> Package perl-Carp.noarch 0:1.26-244.el7 will be installed\n---> Package perl-Filter.x86_64 0:1.49-3.el7 will be installed\n---> Package perl-Pod-Simple.noarch 1:3.28-4.el7 will be installed\n--> Processing Dependency: perl(Pod::Escapes) >= 1.04 for package: 1:perl-Pod-Simple-3.28-4.el7.noarch\n--> Processing Dependency: perl(Encode) for package: 1:perl-Pod-Simple-3.28-4.el7.noarch\n---> Package perl-Pod-Usage.noarch 0:1.63-3.el7 will be installed\n--> Processing Dependency: perl(Pod::Text) >= 3.15 for package: perl-Pod-Usage-1.63-3.el7.noarch\n--> Processing Dependency: perl-Pod-Perldoc for package: perl-Pod-Usage-1.63-3.el7.noarch\n---> Package perl-Scalar-List-Utils.x86_64 0:1.27-248.el7 will be installed\n---> Package perl-Socket.x86_64 0:2.010-3.el7 will be installed\n---> Package perl-Storable.x86_64 0:2.45-3.el7 will be installed\n---> Package perl-Text-ParseWords.noarch 0:3.29-4.el7 will be installed\n---> Package perl-Time-HiRes.x86_64 4:1.9725-3.el7 will be installed\n---> Package perl-Time-Local.noarch 0:1.2300-2.el7 will be installed\n---> Package perl-constant.noarch 0:1.27-2.el7 will be installed\n---> Package perl-libs.x86_64 4:5.16.3-286.el7 will be installed\n---> Package perl-macros.x86_64 4:5.16.3-286.el7 will be installed\n---> Package perl-threads.x86_64 0:1.87-4.el7 will be installed\n---> Package perl-threads-shared.x86_64 0:1.43-6.el7 will be installed\n--> Running transaction check\n---> Package perl-Encode.x86_64 0:2.51-7.el7 will be installed\n---> Package perl-Pod-Escapes.noarch 1:1.04-286.el7 will be installed\n---> Package perl-Pod-Perldoc.noarch 0:3.20-4.el7 will be installed\n--> Processing Dependency: perl(parent) for package: perl-Pod-Perldoc-3.20-4.el7.noarch\n--> Processing Dependency: perl(HTTP::Tiny) for package: perl-Pod-Perldoc-3.20-4.el7.noarch\n---> Package perl-podlators.noarch 0:2.5.1-3.el7 will be installed\n--> Running transaction check\n---> Package perl-HTTP-Tiny.noarch 0:0.033-3.el7 will be installed\n---> Package perl-parent.noarch 1:0.225-244.el7 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package                    Arch       Version                Repository   Size\n================================================================================\nInstalling:\n crudini                    noarch     0.7-1.el7              epel         23 k\n emacs-nox                  x86_64     1:24.3-18.el7          base        2.4 M\n git                        x86_64     1.8.3.1-6.el7_2.1      updates     4.4 M\n tmux                       x86_64     1.8-4.el7              base        243 k\n zsh                        x86_64     5.0.2-14.el7_2.2       updates     2.4 M\nInstalling for dependencies:\n emacs-common               x86_64     1:24.3-18.el7          base         20 M\n emacs-filesystem           noarch     1:24.3-18.el7          base         58 k\n gpm-libs                   x86_64     1.20.7-5.el7           base         32 k\n libgnome-keyring           x86_64     3.8.0-3.el7            base        109 k\n liblockfile                x86_64     1.08-17.el7            base         21 k\n perl                       x86_64     4:5.16.3-286.el7       base        8.0 M\n perl-Carp                  noarch     1.26-244.el7           base         19 k\n perl-Encode                x86_64     2.51-7.el7             base        1.5 M\n perl-Error                 noarch     1:0.17020-2.el7        base         32 k\n perl-Exporter              noarch     5.68-3.el7             base         28 k\n perl-File-Path             noarch     2.09-2.el7             base         26 k\n perl-File-Temp             noarch     0.23.01-3.el7          base         56 k\n perl-Filter                x86_64     1.49-3.el7             base         76 k\n perl-Getopt-Long           noarch     2.40-2.el7             base         56 k\n perl-Git                   noarch     1.8.3.1-6.el7_2.1      updates      53 k\n perl-HTTP-Tiny             noarch     0.033-3.el7            base         38 k\n perl-PathTools             x86_64     3.40-5.el7             base         82 k\n perl-Pod-Escapes           noarch     1:1.04-286.el7         base         50 k\n perl-Pod-Perldoc           noarch     3.20-4.el7             base         87 k\n perl-Pod-Simple            noarch     1:3.28-4.el7           base        216 k\n perl-Pod-Usage             noarch     1.63-3.el7             base         27 k\n perl-Scalar-List-Utils     x86_64     1.27-248.el7           base         36 k\n perl-Socket                x86_64     2.010-3.el7            base         49 k\n perl-Storable              x86_64     2.45-3.el7             base         77 k\n perl-TermReadKey           x86_64     2.30-20.el7            base         31 k\n perl-Text-ParseWords       noarch     3.29-4.el7             base         14 k\n perl-Time-HiRes            x86_64     4:1.9725-3.el7         base         45 k\n perl-Time-Local            noarch     1.2300-2.el7           base         24 k\n perl-constant              noarch     1.27-2.el7             base         19 k\n perl-libs                  x86_64     4:5.16.3-286.el7       base        687 k\n perl-macros                x86_64     4:5.16.3-286.el7       base         43 k\n perl-parent                noarch     1:0.225-244.el7        base         12 k\n perl-podlators             noarch     2.5.1-3.el7            base        112 k\n perl-threads               x86_64     1.87-4.el7             base         49 k\n perl-threads-shared        x86_64     1.43-6.el7             base         39 k\n\nTransaction Summary\n================================================================================\nInstall  5 Packages (+35 Dependent packages)\n\nTotal download size: 42 M\nInstalled size: 146 M\nDownloading packages:\nPublic key for crudini-0.7-1.el7.noarch.rpm is not installed\n--------------------------------------------------------------------------------\nTotal                                              7.6 MB/s |  42 MB  00:05     \nRetrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7\nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : 1:perl-parent-0.225-244.el7.noarch                          1/40 \n  Installing : perl-HTTP-Tiny-0.033-3.el7.noarch                           2/40 \n  Installing : perl-podlators-2.5.1-3.el7.noarch                           3/40 \n  Installing : perl-Pod-Perldoc-3.20-4.el7.noarch                          4/40 \n  Installing : 1:perl-Pod-Escapes-1.04-286.el7.noarch                      5/40 \n  Installing : perl-Encode-2.51-7.el7.x86_64                               6/40 \n  Installing : perl-Text-ParseWords-3.29-4.el7.noarch                      7/40 \n  Installing : perl-Pod-Usage-1.63-3.el7.noarch                            8/40 \n  Installing : 4:perl-libs-5.16.3-286.el7.x86_64                           9/40 \n  Installing : 4:perl-macros-5.16.3-286.el7.x86_64                        10/40 \n  Installing : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                      11/40 \n  Installing : perl-Exporter-5.68-3.el7.noarch                            12/40 \n  Installing : perl-constant-1.27-2.el7.noarch                            13/40 \n  Installing : perl-Time-Local-1.2300-2.el7.noarch                        14/40 \n  Installing : perl-Socket-2.010-3.el7.x86_64                             15/40 \n  Installing : perl-Carp-1.26-244.el7.noarch                              16/40 \n  Installing : perl-Storable-2.45-3.el7.x86_64                            17/40 \n  Installing : perl-PathTools-3.40-5.el7.x86_64                           18/40 \n  Installing : perl-Scalar-List-Utils-1.27-248.el7.x86_64                 19/40 \n  Installing : 1:perl-Pod-Simple-3.28-4.el7.noarch                        20/40 \n  Installing : perl-File-Temp-0.23.01-3.el7.noarch                        21/40 \n  Installing : perl-File-Path-2.09-2.el7.noarch                           22/40 \n  Installing : perl-threads-shared-1.43-6.el7.x86_64                      23/40 \n  Installing : perl-threads-1.87-4.el7.x86_64                             24/40 \n  Installing : perl-Filter-1.49-3.el7.x86_64                              25/40 \n  Installing : perl-Getopt-Long-2.40-2.el7.noarch                         26/40 \n  Installing : 4:perl-5.16.3-286.el7.x86_64                               27/40 \n  Installing : 1:perl-Error-0.17020-2.el7.noarch                          28/40 \n  Installing : perl-TermReadKey-2.30-20.el7.x86_64                        29/40 \n  Installing : libgnome-keyring-3.8.0-3.el7.x86_64                        30/40 \n  Installing : perl-Git-1.8.3.1-6.el7_2.1.noarch                          31/40 \n  Installing : git-1.8.3.1-6.el7_2.1.x86_64                               32/40 \n  Installing : 1:emacs-filesystem-24.3-18.el7.noarch                      33/40 \n  Installing : gpm-libs-1.20.7-5.el7.x86_64                               34/40 \n  Installing : liblockfile-1.08-17.el7.x86_64                             35/40 \n  Installing : 1:emacs-common-24.3-18.el7.x86_64                          36/40 \n  Installing : 1:emacs-nox-24.3-18.el7.x86_64                             37/40 \n  Installing : zsh-5.0.2-14.el7_2.2.x86_64                                38/40 \n  Installing : crudini-0.7-1.el7.noarch                                   39/40 \n  Installing : tmux-1.8-4.el7.x86_64                                      40/40 \n  Verifying  : perl-HTTP-Tiny-0.033-3.el7.noarch                           1/40 \n  Verifying  : perl-Git-1.8.3.1-6.el7_2.1.noarch                           2/40 \n  Verifying  : perl-threads-shared-1.43-6.el7.x86_64                       3/40 \n  Verifying  : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                       4/40 \n  Verifying  : perl-Exporter-5.68-3.el7.noarch                             5/40 \n  Verifying  : perl-constant-1.27-2.el7.noarch                             6/40 \n  Verifying  : perl-PathTools-3.40-5.el7.x86_64                            7/40 \n  Verifying  : 4:perl-libs-5.16.3-286.el7.x86_64                           8/40 \n  Verifying  : 4:perl-macros-5.16.3-286.el7.x86_64                         9/40 \n  Verifying  : 1:perl-Pod-Escapes-1.04-286.el7.noarch                     10/40 \n  Verifying  : 1:perl-parent-0.225-244.el7.noarch                         11/40 \n  Verifying  : perl-TermReadKey-2.30-20.el7.x86_64                        12/40 \n  Verifying  : tmux-1.8-4.el7.x86_64                                      13/40 \n  Verifying  : liblockfile-1.08-17.el7.x86_64                             14/40 \n  Verifying  : perl-File-Temp-0.23.01-3.el7.noarch                        15/40 \n  Verifying  : crudini-0.7-1.el7.noarch                                   16/40 \n  Verifying  : 1:perl-Pod-Simple-3.28-4.el7.noarch                        17/40 \n  Verifying  : perl-Time-Local-1.2300-2.el7.noarch                        18/40 \n  Verifying  : gpm-libs-1.20.7-5.el7.x86_64                               19/40 \n  Verifying  : perl-Pod-Perldoc-3.20-4.el7.noarch                         20/40 \n  Verifying  : perl-Socket-2.010-3.el7.x86_64                             21/40 \n  Verifying  : 1:emacs-common-24.3-18.el7.x86_64                          22/40 \n  Verifying  : 1:emacs-filesystem-24.3-18.el7.noarch                      23/40 \n  Verifying  : perl-Carp-1.26-244.el7.noarch                              24/40 \n  Verifying  : zsh-5.0.2-14.el7_2.2.x86_64                                25/40 \n  Verifying  : 1:perl-Error-0.17020-2.el7.noarch                          26/40 \n  Verifying  : perl-Storable-2.45-3.el7.x86_64                            27/40 \n  Verifying  : perl-Scalar-List-Utils-1.27-248.el7.x86_64                 28/40 \n  Verifying  : libgnome-keyring-3.8.0-3.el7.x86_64                        29/40 \n  Verifying  : perl-Pod-Usage-1.63-3.el7.noarch                           30/40 \n  Verifying  : perl-Encode-2.51-7.el7.x86_64                              31/40 \n  Verifying  : 1:emacs-nox-24.3-18.el7.x86_64                             32/40 \n  Verifying  : perl-podlators-2.5.1-3.el7.noarch                          33/40 \n  Verifying  : perl-Getopt-Long-2.40-2.el7.noarch                         34/40 \n  Verifying  : perl-File-Path-2.09-2.el7.noarch                           35/40 \n  Verifying  : perl-threads-1.87-4.el7.x86_64                             36/40 \n  Verifying  : perl-Filter-1.49-3.el7.x86_64                              37/40 \n  Verifying  : perl-Text-ParseWords-3.29-4.el7.noarch                     38/40 \n  Verifying  : git-1.8.3.1-6.el7_2.1.x86_64                               39/40 \n  Verifying  : 4:perl-5.16.3-286.el7.x86_64                               40/40 \n\nInstalled:\n  crudini.noarch 0:0.7-1.el7             emacs-nox.x86_64 1:24.3-18.el7        \n  git.x86_64 0:1.8.3.1-6.el7_2.1         tmux.x86_64 0:1.8-4.el7               \n  zsh.x86_64 0:5.0.2-14.el7_2.2         \n\nDependency Installed:\n  emacs-common.x86_64 1:24.3-18.el7                                             \n  emacs-filesystem.noarch 1:24.3-18.el7                                         \n  gpm-libs.x86_64 0:1.20.7-5.el7                                                \n  libgnome-keyring.x86_64 0:3.8.0-3.el7                                         \n  liblockfile.x86_64 0:1.08-17.el7                                              \n  perl.x86_64 4:5.16.3-286.el7                                                  \n  perl-Carp.noarch 0:1.26-244.el7                                               \n  perl-Encode.x86_64 0:2.51-7.el7                                               \n  perl-Error.noarch 1:0.17020-2.el7                                             \n  perl-Exporter.noarch 0:5.68-3.el7                                             \n  perl-File-Path.noarch 0:2.09-2.el7                                            \n  perl-File-Temp.noarch 0:0.23.01-3.el7                                         \n  perl-Filter.x86_64 0:1.49-3.el7                                               \n  perl-Getopt-Long.noarch 0:2.40-2.el7                                          \n  perl-Git.noarch 0:1.8.3.1-6.el7_2.1                                           \n  perl-HTTP-Tiny.noarch 0:0.033-3.el7                                           \n  perl-PathTools.x86_64 0:3.40-5.el7                                            \n  perl-Pod-Escapes.noarch 1:1.04-286.el7                                        \n  perl-Pod-Perldoc.noarch 0:3.20-4.el7                                          \n  perl-Pod-Simple.noarch 1:3.28-4.el7                                           \n  perl-Pod-Usage.noarch 0:1.63-3.el7                                            \n  perl-Scalar-List-Utils.x86_64 0:1.27-248.el7                                  \n  perl-Socket.x86_64 0:2.010-3.el7                                              \n  perl-Storable.x86_64 0:2.45-3.el7                                             \n  perl-TermReadKey.x86_64 0:2.30-20.el7                                         \n  perl-Text-ParseWords.noarch 0:3.29-4.el7                                      \n  perl-Time-HiRes.x86_64 4:1.9725-3.el7                                         \n  perl-Time-Local.noarch 0:1.2300-2.el7                                         \n  perl-constant.noarch 0:1.27-2.el7                                             \n  perl-libs.x86_64 4:5.16.3-286.el7                                             \n  perl-macros.x86_64 4:5.16.3-286.el7                                           \n  perl-parent.noarch 1:0.225-244.el7                                            \n  perl-podlators.noarch 0:2.5.1-3.el7                                           \n  perl-threads.x86_64 0:1.87-4.el7                                              \n  perl-threads-shared.x86_64 0:1.43-6.el7                                       \n\nComplete!\n"]}[0m
    [0m[0m
    TASK [base : disable SELinux] **************************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "configfile": "/etc/selinux/config", "msg": "runtime state changed from 'enforcing' to 'permissive', config state changed from 'enforcing' to 'permissive'", "policy": "targeted", "state": "permissive"}[0m
    [0m[0m
    TASK [base : disable firewalld] ************************************************
    [0m[0m[0;32mok: [node1] => {"changed": false, "enabled": false, "name": "firewalld", "state": "stopped"}[0m
    [0m[0m
    TASK [base : check if /etc/hosts.orig exists] **********************************
    [0m[0m[0;32mok: [node1] => {"changed": false, "stat": {"exists": false}}[0m
    [0m[0m
    TASK [base : backup original /etc/hosts] ***************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "cmd": ["cp", "/etc/hosts", "/etc/hosts.orig"], "delta": "0:00:00.003166", "end": "2016-10-31 10:50:43.708023", "rc": 0, "start": "2016-10-31 10:50:43.704857", "stderr": "", "stdout": "", "stdout_lines": [], "warnings": []}[0m
    [0m[0m
    TASK [base : generate /etc/hosts] **********************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "checksum": "77cd9f1a1318284ec53f8fdb6ae3ecd42d0df8cf", "dest": "/etc/hosts", "gid": 0, "group": "root", "md5sum": "cf2e0855e349f300cf0934be89df31ad", "mode": "0644", "owner": "root", "secontext": "system_u:object_r:net_conf_t:s0", "size": 467, "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1477911045.38-171465368981744/source", "state": "file", "uid": 0}[0m
    [0m[0m
    TASK [base : setup docker repository] ******************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "repo": "docker", "state": "present"}[0m
    [0m[0m
    TASK [base : remove docker packages from CentOS] *******************************
    [0m[0m[0;36mskipping: [node1] => {"changed": false, "skip_reason": "Conditional check failed", "skipped": true}[0m
    [0m[0m
    TASK [base : install docker engine] ********************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "msg": "", "rc": 0, "results": ["Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: miroir.univ-paris13.fr\n * epel: mirror.ibcp.fr\n * extras: centos.quelquesmots.fr\n * updates: centos.quelquesmots.fr\nResolving Dependencies\n--> Running transaction check\n---> Package docker.x86_64 0:1.10.3-46.el7.centos.14 will be installed\n--> Processing Dependency: docker-common = 1.10.3-46.el7.centos.14 for package: docker-1.10.3-46.el7.centos.14.x86_64\n--> Processing Dependency: oci-systemd-hook >= 1:0.1.4-4 for package: docker-1.10.3-46.el7.centos.14.x86_64\n--> Processing Dependency: oci-register-machine >= 1:0-1.8 for package: docker-1.10.3-46.el7.centos.14.x86_64\n--> Processing Dependency: docker-selinux >= 1.10.3-46.el7.centos.14 for package: docker-1.10.3-46.el7.centos.14.x86_64\n--> Processing Dependency: libseccomp.so.2()(64bit) for package: docker-1.10.3-46.el7.centos.14.x86_64\n--> Running transaction check\n---> Package docker-common.x86_64 0:1.10.3-46.el7.centos.14 will be installed\n---> Package docker-selinux.x86_64 0:1.10.3-46.el7.centos.14 will be installed\n--> Processing Dependency: policycoreutils-python for package: docker-selinux-1.10.3-46.el7.centos.14.x86_64\n---> Package libseccomp.x86_64 0:2.2.1-1.el7 will be installed\n---> Package oci-register-machine.x86_64 1:0-1.8.gitaf6c129.el7 will be installed\n---> Package oci-systemd-hook.x86_64 1:0.1.4-4.git41491a3.el7 will be installed\n--> Processing Dependency: libyajl.so.2()(64bit) for package: 1:oci-systemd-hook-0.1.4-4.git41491a3.el7.x86_64\n--> Running transaction check\n---> Package policycoreutils-python.x86_64 0:2.2.5-20.el7 will be installed\n--> Processing Dependency: libsemanage-python >= 2.1.10-1 for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: audit-libs-python >= 2.1.3-4 for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: python-IPy for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: libqpol.so.1(VERS_1.4)(64bit) for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: libqpol.so.1(VERS_1.2)(64bit) for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: libcgroup for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: libapol.so.4(VERS_4.0)(64bit) for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: checkpolicy for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: libqpol.so.1()(64bit) for package: policycoreutils-python-2.2.5-20.el7.x86_64\n--> Processing Dependency: libapol.so.4()(64bit) for package: policycoreutils-python-2.2.5-20.el7.x86_64\n---> Package yajl.x86_64 0:2.0.4-4.el7 will be installed\n--> Running transaction check\n---> Package audit-libs-python.x86_64 0:2.4.1-5.el7 will be installed\n---> Package checkpolicy.x86_64 0:2.1.12-6.el7 will be installed\n---> Package libcgroup.x86_64 0:0.41-8.el7 will be installed\n---> Package libsemanage-python.x86_64 0:2.1.10-18.el7 will be installed\n---> Package python-IPy.noarch 0:0.75-6.el7 will be installed\n---> Package setools-libs.x86_64 0:3.3.7-46.el7 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package                  Arch     Version                       Repository\n                                                                           Size\n================================================================================\nInstalling:\n docker                   x86_64   1.10.3-46.el7.centos.14       extras   9.5 M\nInstalling for dependencies:\n audit-libs-python        x86_64   2.4.1-5.el7                   base      69 k\n checkpolicy              x86_64   2.1.12-6.el7                  base     247 k\n docker-common            x86_64   1.10.3-46.el7.centos.14       extras    61 k\n docker-selinux           x86_64   1.10.3-46.el7.centos.14       extras    79 k\n libcgroup                x86_64   0.41-8.el7                    base      64 k\n libseccomp               x86_64   2.2.1-1.el7                   base      49 k\n libsemanage-python       x86_64   2.1.10-18.el7                 base      94 k\n oci-register-machine     x86_64   1:0-1.8.gitaf6c129.el7        extras   1.1 M\n oci-systemd-hook         x86_64   1:0.1.4-4.git41491a3.el7      extras    27 k\n policycoreutils-python   x86_64   2.2.5-20.el7                  base     435 k\n python-IPy               noarch   0.75-6.el7                    base      32 k\n setools-libs             x86_64   3.3.7-46.el7                  base     485 k\n yajl                     x86_64   2.0.4-4.el7                   base      39 k\n\nTransaction Summary\n================================================================================\nInstall  1 Package (+13 Dependent packages)\n\nTotal download size: 12 M\nInstalled size: 53 M\nDownloading packages:\n--------------------------------------------------------------------------------\nTotal                                              5.6 MB/s |  12 MB  00:02     \nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : libsemanage-python-2.1.10-18.el7.x86_64                     1/14 \n  Installing : audit-libs-python-2.4.1-5.el7.x86_64                        2/14 \n  Installing : yajl-2.0.4-4.el7.x86_64                                     3/14 \n  Installing : 1:oci-systemd-hook-0.1.4-4.git41491a3.el7.x86_64            4/14 \n  Installing : 1:oci-register-machine-0-1.8.gitaf6c129.el7.x86_64          5/14 \n  Installing : libseccomp-2.2.1-1.el7.x86_64                               6/14 \n  Installing : python-IPy-0.75-6.el7.noarch                                7/14 \n  Installing : checkpolicy-2.1.12-6.el7.x86_64                             8/14 \n  Installing : libcgroup-0.41-8.el7.x86_64                                 9/14 \n  Installing : docker-common-1.10.3-46.el7.centos.14.x86_64               10/14 \n  Installing : setools-libs-3.3.7-46.el7.x86_64                           11/14 \n  Installing : policycoreutils-python-2.2.5-20.el7.x86_64                 12/14 \n  Installing : docker-selinux-1.10.3-46.el7.centos.14.x86_64              13/14 \n  Installing : docker-1.10.3-46.el7.centos.14.x86_64                      14/14 \n  Verifying  : setools-libs-3.3.7-46.el7.x86_64                            1/14 \n  Verifying  : docker-common-1.10.3-46.el7.centos.14.x86_64                2/14 \n  Verifying  : docker-1.10.3-46.el7.centos.14.x86_64                       3/14 \n  Verifying  : libcgroup-0.41-8.el7.x86_64                                 4/14 \n  Verifying  : 1:oci-systemd-hook-0.1.4-4.git41491a3.el7.x86_64            5/14 \n  Verifying  : checkpolicy-2.1.12-6.el7.x86_64                             6/14 \n  Verifying  : python-IPy-0.75-6.el7.noarch                                7/14 \n  Verifying  : libseccomp-2.2.1-1.el7.x86_64                               8/14 \n  Verifying  : 1:oci-register-machine-0-1.8.gitaf6c129.el7.x86_64          9/14 \n  Verifying  : docker-selinux-1.10.3-46.el7.centos.14.x86_64              10/14 \n  Verifying  : yajl-2.0.4-4.el7.x86_64                                    11/14 \n  Verifying  : audit-libs-python-2.4.1-5.el7.x86_64                       12/14 \n  Verifying  : policycoreutils-python-2.2.5-20.el7.x86_64                 13/14 \n  Verifying  : libsemanage-python-2.1.10-18.el7.x86_64                    14/14 \n\nInstalled:\n  docker.x86_64 0:1.10.3-46.el7.centos.14                                       \n\nDependency Installed:\n  audit-libs-python.x86_64 0:2.4.1-5.el7                                        \n  checkpolicy.x86_64 0:2.1.12-6.el7                                             \n  docker-common.x86_64 0:1.10.3-46.el7.centos.14                                \n  docker-selinux.x86_64 0:1.10.3-46.el7.centos.14                               \n  libcgroup.x86_64 0:0.41-8.el7                                                 \n  libseccomp.x86_64 0:2.2.1-1.el7                                               \n  libsemanage-python.x86_64 0:2.1.10-18.el7                                     \n  oci-register-machine.x86_64 1:0-1.8.gitaf6c129.el7                            \n  oci-systemd-hook.x86_64 1:0.1.4-4.git41491a3.el7                              \n  policycoreutils-python.x86_64 0:2.2.5-20.el7                                  \n  python-IPy.noarch 0:0.75-6.el7                                                \n  setools-libs.x86_64 0:3.3.7-46.el7                                            \n  yajl.x86_64 0:2.0.4-4.el7                                                     \n\nComplete!\n"]}[0m
    [0m[0m
    TASK [base : include_vars] *****************************************************
    [0m[0m[0;36mskipping: [node1] => {"changed": false, "skip_reason": "Conditional check failed", "skipped": true}[0m
    [0m[0m
    TASK [base : install mesos repository] *****************************************
    [0m[0m[0;36mskipping: [node1] => {"changed": false, "skip_reason": "Conditional check failed", "skipped": true}[0m
    [0m[0m
    TASK [base : Set IP address variables] *****************************************
    [0m[0m[0;32mok: [node1] => {"ansible_facts": {"etcd_ip_address": "10.0.2.15", "kubemaster_ip_address": "10.0.2.15"}, "changed": false}[0m
    [0m[0m
    PLAY [etcd] ********************************************************************
    [0m[0m
    TASK [setup] *******************************************************************
    [0m[0m[0;32mok: [node1][0m
    [0m[0m
    TASK [etcd : install etcd] *****************************************************
    [0m[0m[0;33mchanged: [node1] => (item=[u'etcd']) => {"changed": true, "item": ["etcd"], "msg": "", "rc": 0, "results": ["Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: miroir.univ-paris13.fr\n * epel: epel.mirrors.ovh.net\n * extras: centos.quelquesmots.fr\n * updates: centos.quelquesmots.fr\nResolving Dependencies\n--> Running transaction check\n---> Package etcd.x86_64 0:2.3.7-4.el7 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package        Arch             Version                 Repository        Size\n================================================================================\nInstalling:\n etcd           x86_64           2.3.7-4.el7             extras           6.5 M\n\nTransaction Summary\n================================================================================\nInstall  1 Package\n\nTotal download size: 6.5 M\nInstalled size: 31 M\nDownloading packages:\nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : etcd-2.3.7-4.el7.x86_64                                      1/1 \n  Verifying  : etcd-2.3.7-4.el7.x86_64                                      1/1 \n\nInstalled:\n  etcd.x86_64 0:2.3.7-4.el7                                                     \n\nComplete!\n"]}[0m
    [0m[0m
    TASK [etcd : configure etcd] ***************************************************
    [0m[0m[0;33mchanged: [node1] => (item=member ETCD_NAME default) => {"changed": true, "cmd": ["crudini", "--set", "/etc/etcd/etcd.conf", "member", "ETCD_NAME", "default"], "delta": "0:00:00.028809", "end": "2016-10-31 10:51:07.259594", "item": "member ETCD_NAME default", "rc": 0, "start": "2016-10-31 10:51:07.230785", "stderr": "", "stdout": "", "stdout_lines": [], "warnings": []}[0m
    [0m[0m[0;33mchanged: [node1] => (item=member ETCD_DATA_DIR /var/lib/etcd/default.etcd) => {"changed": true, "cmd": ["crudini", "--set", "/etc/etcd/etcd.conf", "member", "ETCD_DATA_DIR", "/var/lib/etcd/default.etcd"], "delta": "0:00:00.028142", "end": "2016-10-31 10:51:07.476822", "item": "member ETCD_DATA_DIR /var/lib/etcd/default.etcd", "rc": 0, "start": "2016-10-31 10:51:07.448680", "stderr": "", "stdout": "", "stdout_lines": [], "warnings": []}[0m
    [0m[0m[0;33mchanged: [node1] => (item=member ETCD_LISTEN_CLIENT_URLS http://0.0.0.0:2379) => {"changed": true, "cmd": ["crudini", "--set", "/etc/etcd/etcd.conf", "member", "ETCD_LISTEN_CLIENT_URLS", "http://0.0.0.0:2379"], "delta": "0:00:00.028178", "end": "2016-10-31 10:51:07.687873", "item": "member ETCD_LISTEN_CLIENT_URLS http://0.0.0.0:2379", "rc": 0, "start": "2016-10-31 10:51:07.659695", "stderr": "", "stdout": "", "stdout_lines": [], "warnings": []}[0m
    [0m[0m[0;33mchanged: [node1] => (item=cluster ETCD_ADVERTISE_CLIENT_URLS http://0.0.0.0:2379) => {"changed": true, "cmd": ["crudini", "--set", "/etc/etcd/etcd.conf", "cluster", "ETCD_ADVERTISE_CLIENT_URLS", "http://0.0.0.0:2379"], "delta": "0:00:00.028322", "end": "2016-10-31 10:51:07.901940", "item": "cluster ETCD_ADVERTISE_CLIENT_URLS http://0.0.0.0:2379", "rc": 0, "start": "2016-10-31 10:51:07.873618", "stderr": "", "stdout": "", "stdout_lines": [], "warnings": []}[0m
    [0m[0m
    TASK [etcd : start etcd] *******************************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "name": "etcd", "state": "started"}[0m
    [0m[0m
    TASK [etcd : wait etcd to start] ***********************************************
    [0m[0m[0;32mok: [node1] => {"changed": false, "elapsed": 10, "path": null, "port": 2379, "search_regex": null, "state": "started"}[0m
    [0m[0m
    TASK [etcd : clean flannel configuration] **************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "cmd": "etcdctl rm /atomic.io/network/config ||:", "delta": "0:00:00.012862", "end": "2016-10-31 10:51:18.702529", "rc": 0, "start": "2016-10-31 10:51:18.689667", "stderr": "Error:  100: Key not found (/atomic.io) [3]", "stdout": "", "stdout_lines": [], "warnings": []}[0m
    [0m[0m
    TASK [etcd : configure flannel network] ****************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "cmd": ["etcdctl", "mk", "/atomic.io/network/config", "{\"Network\":\"172.17.0.0/16\"}"], "delta": "0:00:00.010895", "end": "2016-10-31 10:51:18.918713", "rc": 0, "start": "2016-10-31 10:51:18.907818", "stderr": "", "stdout": "{\"Network\":\"172.17.0.0/16\"}", "stdout_lines": ["{\"Network\":\"172.17.0.0/16\"}"], "warnings": []}[0m
    [0m[0m
    RUNNING HANDLER [etcd : restart etcd] ******************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "name": "etcd", "state": "started"}[0m
    [0m[0m
    PLAY [all] *********************************************************************
    [0m[0m
    TASK [setup] *******************************************************************
    [0m[0m[0;32mok: [node1][0m
    [0m[0m
    TASK [flannel : install flannel] ***********************************************
    [0m[0m[0;33mchanged: [node1] => (item=[u'flannel']) => {"changed": true, "item": ["flannel"], "msg": "", "rc": 0, "results": ["Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: miroir.univ-paris13.fr\n * epel: mirror.ibcp.fr\n * extras: centos.quelquesmots.fr\n * updates: centos.quelquesmots.fr\nResolving Dependencies\n--> Running transaction check\n---> Package flannel.x86_64 0:0.5.3-9.el7 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package          Arch            Version                 Repository       Size\n================================================================================\nInstalling:\n flannel          x86_64          0.5.3-9.el7             extras          1.7 M\n\nTransaction Summary\n================================================================================\nInstall  1 Package\n\nTotal download size: 1.7 M\nInstalled size: 7.5 M\nDownloading packages:\nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : flannel-0.5.3-9.el7.x86_64                                   1/1 \n  Verifying  : flannel-0.5.3-9.el7.x86_64                                   1/1 \n\nInstalled:\n  flannel.x86_64 0:0.5.3-9.el7                                                  \n\nComplete!\n"]}[0m
    [0m[0m
    TASK [flannel : configure flanneld] ********************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "checksum": "4afd1bcb305942f6aa0250a92e33b14f03e7343c", "dest": "/etc/sysconfig/flanneld", "gid": 0, "group": "root", "md5sum": "4b55c7b039a09c5febecc88af00da158", "mode": "0644", "owner": "root", "secontext": "system_u:object_r:etc_t:s0", "size": 347, "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1477911083.44-85044740443843/source", "state": "file", "uid": 0}[0m
    [0m[0m
    TASK [flannel : start flanneld] ************************************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "name": "flanneld", "state": "started"}[0m
    [0m[0m
    PLAY [kubemaster] **************************************************************
    [0m[0m
    TASK [setup] *******************************************************************
    [0m[0m[0;32mok: [node1][0m
    [0m[0m
    TASK [kubernetes-master : install kubernetes master] ***************************
    [0m[0m[0;33mchanged: [node1] => (item=[u'kubernetes', u'flannel']) => {"changed": true, "item": ["kubernetes", "flannel"], "msg": "", "rc": 0, "results": ["flannel-0.5.3-9.el7.x86_64 providing flannel is already installed", "Loaded plugins: fastestmirror\nLoading mirror speeds from cached hostfile\n * base: miroir.univ-paris13.fr\n * epel: mirror.ibcp.fr\n * extras: centos.quelquesmots.fr\n * updates: centos.quelquesmots.fr\nResolving Dependencies\n--> Running transaction check\n---> Package kubernetes.x86_64 0:1.2.0-0.13.gitec7364b.el7 will be installed\n--> Processing Dependency: kubernetes-node = 1.2.0-0.13.gitec7364b.el7 for package: kubernetes-1.2.0-0.13.gitec7364b.el7.x86_64\n--> Processing Dependency: kubernetes-master = 1.2.0-0.13.gitec7364b.el7 for package: kubernetes-1.2.0-0.13.gitec7364b.el7.x86_64\n--> Running transaction check\n---> Package kubernetes-master.x86_64 0:1.2.0-0.13.gitec7364b.el7 will be installed\n--> Processing Dependency: kubernetes-client = 1.2.0-0.13.gitec7364b.el7 for package: kubernetes-master-1.2.0-0.13.gitec7364b.el7.x86_64\n---> Package kubernetes-node.x86_64 0:1.2.0-0.13.gitec7364b.el7 will be installed\n--> Processing Dependency: socat for package: kubernetes-node-1.2.0-0.13.gitec7364b.el7.x86_64\n--> Running transaction check\n---> Package kubernetes-client.x86_64 0:1.2.0-0.13.gitec7364b.el7 will be installed\n---> Package socat.x86_64 0:1.7.2.2-5.el7 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package              Arch      Version                         Repository\n                                                                           Size\n================================================================================\nInstalling:\n kubernetes           x86_64    1.2.0-0.13.gitec7364b.el7       extras     35 k\nInstalling for dependencies:\n kubernetes-client    x86_64    1.2.0-0.13.gitec7364b.el7       extras    9.7 M\n kubernetes-master    x86_64    1.2.0-0.13.gitec7364b.el7       extras     17 M\n kubernetes-node      x86_64    1.2.0-0.13.gitec7364b.el7       extras    9.6 M\n socat                x86_64    1.7.2.2-5.el7                   base      255 k\n\nTransaction Summary\n================================================================================\nInstall  1 Package (+4 Dependent packages)\n\nTotal download size: 36 M\nInstalled size: 177 M\nDownloading packages:\n--------------------------------------------------------------------------------\nTotal                                              8.0 MB/s |  36 MB  00:04     \nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : kubernetes-client-1.2.0-0.13.gitec7364b.el7.x86_64           1/5 \n  Installing : kubernetes-master-1.2.0-0.13.gitec7364b.el7.x86_64           2/5 \n  Installing : socat-1.7.2.2-5.el7.x86_64                                   3/5 \n  Installing : kubernetes-node-1.2.0-0.13.gitec7364b.el7.x86_64             4/5 \n  Installing : kubernetes-1.2.0-0.13.gitec7364b.el7.x86_64                  5/5 \n  Verifying  : kubernetes-master-1.2.0-0.13.gitec7364b.el7.x86_64           1/5 \n  Verifying  : kubernetes-node-1.2.0-0.13.gitec7364b.el7.x86_64             2/5 \n  Verifying  : kubernetes-client-1.2.0-0.13.gitec7364b.el7.x86_64           3/5 \n  Verifying  : kubernetes-1.2.0-0.13.gitec7364b.el7.x86_64                  4/5 \n  Verifying  : socat-1.7.2.2-5.el7.x86_64                                   5/5 \n\nInstalled:\n  kubernetes.x86_64 0:1.2.0-0.13.gitec7364b.el7                                 \n\nDependency Installed:\n  kubernetes-client.x86_64 0:1.2.0-0.13.gitec7364b.el7                          \n  kubernetes-master.x86_64 0:1.2.0-0.13.gitec7364b.el7                          \n  kubernetes-node.x86_64 0:1.2.0-0.13.gitec7364b.el7                            \n  socat.x86_64 0:1.7.2.2-5.el7                                                  \n\nComplete!\n"]}[0m
    [0m[0m
    TASK [kubernetes-master : configure kubernetes] ********************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "checksum": "bec368e3bb8d2f05a8412b6b159962e64ee2bb36", "dest": "/etc/kubernetes/config", "gid": 0, "group": "root", "md5sum": "046727bb8755cbb39afb69822c3ae2de", "mode": "0644", "owner": "root", "secontext": "system_u:object_r:etc_t:s0", "size": 655, "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1477911096.26-189619640482568/source", "state": "file", "uid": 0}[0m
    [0m[0m
    TASK [kubernetes-master : configure kube-apiserver] ****************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "checksum": "b67374b7b17cd406e3c41e2ff820e68088f679bb", "dest": "/etc/kubernetes/apiserver", "gid": 0, "group": "root", "md5sum": "2add5424a74e664479a159ee2f7bca9f", "mode": "0644", "owner": "root", "secontext": "system_u:object_r:etc_t:s0", "size": 730, "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1477911096.69-30079728723120/source", "state": "file", "uid": 0}[0m
    [0m[0m
    TASK [kubernetes-master : start kubernetes master services] ********************
    [0m[0m[0;33mchanged: [node1] => (item=kube-apiserver) => {"changed": true, "enabled": true, "item": "kube-apiserver", "name": "kube-apiserver", "state": "started"}[0m
    [0m[0m[0;33mchanged: [node1] => (item=kube-controller-manager) => {"changed": true, "enabled": true, "item": "kube-controller-manager", "name": "kube-controller-manager", "state": "started"}[0m
    [0m[0m[0;33mchanged: [node1] => (item=kube-scheduler) => {"changed": true, "enabled": true, "item": "kube-scheduler", "name": "kube-scheduler", "state": "started"}[0m
    [0m[0m
    TASK [kubernetes-master : wait k8s apiserver to start] *************************
    [0m[0m[0;32mok: [node1] => {"changed": false, "elapsed": 10, "path": null, "port": 8080, "search_regex": null, "state": "started"}[0m
    [0m[0m
    PLAY [kubeminions] *************************************************************
    [0m[0m
    TASK [setup] *******************************************************************
    [0m[0m[0;32mok: [node1][0m
    [0m[0m
    TASK [kubernetes-minion : install kubernetes minion] ***************************
    [0m[0m[0;32mok: [node1] => (item=[u'kubernetes-node']) => {"changed": false, "item": ["kubernetes-node"], "msg": "", "rc": 0, "results": ["kubernetes-node-1.2.0-0.13.gitec7364b.el7.x86_64 providing kubernetes-node is already installed"]}[0m
    [0m[0m
    TASK [kubernetes-minion : configure base kubernetes] ***************************
    [0m[0m[0;32mok: [node1] => {"changed": false, "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/etc/kubernetes/config", "secontext": "system_u:object_r:etc_t:s0", "size": 655, "state": "file", "uid": 0}[0m
    [0m[0m
    TASK [kubernetes-minion : configure kubelet] ***********************************
    [0m[0m[0;33mchanged: [node1] => {"changed": true, "checksum": "bc0c8ded6da1921b8d80f8419084d6a515b0fa54", "dest": "/etc/kubernetes/kubelet", "gid": 0, "group": "root", "md5sum": "71cb00d8be06064f37dfb460b60e0317", "mode": "0644", "owner": "root", "secontext": "system_u:object_r:etc_t:s0", "size": 584, "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1477911109.73-188914707995522/source", "state": "file", "uid": 0}[0m
    [0m[0m
    TASK [kubernetes-minion : start kubernetes minion services] ********************
    [0m[0m[0;33mchanged: [node1] => (item=kube-proxy) => {"changed": true, "enabled": true, "item": "kube-proxy", "name": "kube-proxy", "state": "started"}[0m
    [0m[0m[0;33mchanged: [node1] => (item=kubelet) => {"changed": true, "enabled": true, "item": "kubelet", "name": "kubelet", "state": "started"}[0m
    [0m[0m[0;33mchanged: [node1] => (item=docker) => {"changed": true, "enabled": true, "item": "docker", "name": "docker", "state": "started"}[0m
    [0m[0m
    PLAY RECAP *********************************************************************
    [0m[0m[0;33mnode1[0m                      : [0;32mok[0m[0;32m=[0m[0;32m34[0m   [0;33mchanged[0m[0;33m=[0m[0;33m22[0m   unreachable=0    failed=0   
    
    [0m

Let's use

```shell
vagrant status
```
to show the status of the virtual machine


```bash
vagrant status
```

    [0mCurrent machine states:
    
    node1                     running (virtualbox)
    
    The VM is running. To stop this VM, you can run `vagrant halt` to
    shut it down forcefully, or you can run `vagrant suspend` to simply
    suspend the virtual machine. In either case, to restart it again,
    simply run `vagrant up`.[0m


We can now use the

```shell
vagrant ssh
```
command to connect to that node, as an interactive session, to to run a specific command as below:


```bash
vagrant ssh node1 -c "ls -al /tmp/" 
```

    total 16
    drwxrwxrwt.  7 root root 4096 Oct 31 10:54 .
    dr-xr-xr-x. 18 root root 4096 Oct 31 10:50 ..
    drwxrwxrwt.  2 root root    6 Oct  3 13:39 .font-unix
    drwxrwxrwt.  2 root root    6 Oct  3 13:39 .ICE-unix
    -rwx------.  1 root root 2326 Oct  3 13:48 ks-script-nDh093
    -rwx------.  1 root root  827 Oct  3 13:49 ks-script-SstNaF
    drwxrwxrwt.  2 root root    6 Oct  3 13:39 .Test-unix
    drwxrwxrwt.  2 root root    6 Oct  3 13:39 .X11-unix
    drwxrwxrwt.  2 root root    6 Oct  3 13:39 .XIM-unix
    -rw-------.  1 root root    0 Oct  3 13:34 yum.log
    


On your master host, check out the kubernetes git repository, and change into the guestbook directory:

**Connect to the virtual machine using**
vagrant ssh node1


The following commands are all to be run within the virtual machine

Note: This lab was run with revision ddce7c305aca9c99bfd448c978da48169109bf93

you can check it out using:

git checkout ddce7c305aca9c99bfd448c978da48169109bf93

**NOTE**: All commands below should be run from within an ssh session on the node1 created using
```bash
vagrant ssh node1
```

No need to precede each command by ```bash vagrant ssh node1 -c '<cmd>'``` as done below (only necessary in this notebook format)

#### Running the Guestbook example

The following is all taken from

https://github.com/kubernetes/kubernetes/tree/master/examples/guestbook

and this specific revision at:
https://github.com/kubernetes/kubernetes/tree/ddce7c305aca9c99bfd448c978da48169109bf93/examples/guestbook



```bash
vagrant ssh node1 -c "git clone https://github.com/GoogleCloudPlatform/kubernetes.git""
```

    Cloning into 'kubernetes'...
    remote: Counting objects: 367224, done.[K
    remote: Compressing objects: 100% (5/5), done.[K
    Receiving objects: 100% (367224/367224), 337.70 MiB | 4.78 MiB/s, done.
    remote: Total 367224 (delta 0), reused 0 (delta 0), pack-reused 367219[K
    Resolving deltas: 100% (241123/241123), done.
    


## Check the Kubernetes cluster status

By running the *kubectl cluster-info* command we should obtain output similar to below


```bash
vagrant ssh node1 -c "kubectl cluster-info"
```

    [0;32mKubernetes master[0m is running at [0;33mhttp://localhost:8080[0m
    


### Start the guestbook application - Quick Start

Below are the contents of the yaml file we will use to start the guestbook application under Kubernetes:


```bash
vagrant ssh node1 -c "cat kubernetes/examples/guestbook/all-in-one/guestbook-all-in-one.yaml"
```

    apiVersion: v1
    kind: Service
    metadata:
      name: redis-master
      labels:
        app: redis
        tier: backend
        role: master
    spec:
      ports:
        # the port that this service should serve on
      - port: 6379
        targetPort: 6379
      selector:
        app: redis
        tier: backend
        role: master
    ---
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: redis-master
      # these labels can be applied automatically
      # from the labels in the pod template if not set
      # labels:
      #   app: redis
      #   role: master
      #   tier: backend
    spec:
      # this replicas value is default
      # modify it according to your case
      replicas: 1
      # selector can be applied automatically
      # from the labels in the pod template if not set
      # selector:
      #   matchLabels:
      #     app: guestbook
      #     role: master
      #     tier: backend
      template:
        metadata:
          labels:
            app: redis
            role: master
            tier: backend
        spec:
          containers:
          - name: master
            image: gcr.io/google_containers/redis:e2e  # or just image: redis
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
            ports:
            - containerPort: 6379
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: redis-slave
      labels:
        app: redis
        tier: backend
        role: slave
    spec:
      ports:
        # the port that this service should serve on
      - port: 6379
      selector:
        app: redis
        tier: backend
        role: slave
    ---
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: redis-slave
      # these labels can be applied automatically
      # from the labels in the pod template if not set
      # labels:
      #   app: redis
      #   role: slave
      #   tier: backend
    spec:
      # this replicas value is default
      # modify it according to your case
      replicas: 2
      # selector can be applied automatically
      # from the labels in the pod template if not set
      # selector:
      #   matchLabels:
      #     app: guestbook
      #     role: slave
      #     tier: backend
      template:
        metadata:
          labels:
            app: redis
            role: slave
            tier: backend
        spec:
          containers:
          - name: slave
            image: gcr.io/google_samples/gb-redisslave:v1
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
            env:
            - name: GET_HOSTS_FROM
              value: dns
              # If your cluster config does not include a dns service, then to
              # instead access an environment variable to find the master
              # service's host, comment out the 'value: dns' line above, and
              # uncomment the line below.
              # value: env
            ports:
            - containerPort: 6379
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      # if your cluster supports it, uncomment the following to automatically create
      # an external load-balanced IP for the frontend service.
      # type: LoadBalancer
      ports:
        # the port that this service should serve on
      - port: 80
      selector:
        app: guestbook
        tier: frontend
    ---
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: frontend
      # these labels can be applied automatically
      # from the labels in the pod template if not set
      # labels:
      #   app: guestbook
      #   tier: frontend
    spec:
      # this replicas value is default
      # modify it according to your case
      replicas: 3
      # selector can be applied automatically
      # from the labels in the pod template if not set
      # selector:
      #   matchLabels:
      #     app: guestbook
      #     tier: frontend
      template:
        metadata:
          labels:
            app: guestbook
            tier: frontend
        spec:
          containers:
          - name: php-redis
            image: gcr.io/google-samples/gb-frontend:v4
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
            env:
            - name: GET_HOSTS_FROM
              value: dns
              # If your cluster config does not include a dns service, then to
              # instead access environment variables to find service host
              # info, comment out the 'value: dns' line above, and uncomment the
              # line below.
              # value: env
            ports:
            - containerPort: 80
    



```bash
vagrant ssh node1 -c "cd kubernetes; kubectl create -f examples/guestbook/all-in-one/guestbook-all-in-one.yaml"
```

    service "redis-master" created
    deployment "redis-master" created
    service "redis-slave" created
    deployment "redis-slave" created
    service "frontend" created
    deployment "frontend" created
    


vagrant ssh node1 -c "kubectl get services"


```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME           CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    frontend       10.254.225.118   <none>        80/TCP     8m
    kubernetes     10.254.0.1       <none>        443/TCP    25m
    redis-master   10.254.116.79    <none>        6379/TCP   8m
    redis-slave    10.254.139.216   <none>        6379/TCP   8m
    



```bash
vagrant ssh node1 -c "curl http://10.254.225.118:80"
```

    <html ng-app="redis">
      <head>
        <title>Guestbook</title>
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.12/angular.min.js"></script>
        <script src="controllers.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.13.0/ui-bootstrap-tpls.js"></script>
      </head>
      <body ng-controller="RedisCtrl">
        <div style="width: 50%; margin-left: 20px">
          <h2>Guestbook</h2>
        <form>
        <fieldset>
        <input ng-model="msg" placeholder="Messages" class="form-control" type="text" name="input"><br>
        <button type="button" class="btn btn-primary" ng-click="controller.onRedis()">Submit</button>
        </fieldset>
        </form>
        <div>
          <div ng-repeat="msg in messages track by $index">
            {{msg}}
          </div>
        </div>
        </div>
      </body>
    </html>
    





```bash
vagrant ssh node1 -c "cd kubernetes; kubectl delete -f examples/guestbook/all-in-one/guestbook-all-in-one.yaml"
```

    service "redis-master" deleted
    deployment "redis-master" deleted
    service "redis-slave" deleted
    deployment "redis-slave" deleted
    service "frontend" deleted
    deployment "frontend" deleted
    



```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
    kubernetes   10.254.0.1   <none>        443/TCP   1h
    


#### Step1: Start the Redis Master

We will start the Redis Master using the deployment file listed below


```bash
vagrant ssh node1 -c "cat kubernetes/examples/guestbook/redis-master-service.yaml"
```

    apiVersion: v1
    kind: Service
    metadata:
      name: redis-master
      labels:
        app: redis
        role: master
        tier: backend
    spec:
      ports:
        # the port that this service should serve on
      - port: 6379
        targetPort: 6379
      selector:
        app: redis
        role: master
        tier: backend
    



```bash
vagrant ssh node1 -c "kubectl create -f kubernetes/examples/guestbook/redis-master-service.yaml"
```

    service "redis-master" created
    


We can now see below that the *'redis-master'* service has been created:


```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME           CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    kubernetes     10.254.0.1       <none>        443/TCP    1h
    redis-master   10.254.193.146   <none>        6379/TCP   6s
    



```bash
vagrant ssh node1 -c "kubectl create -f kubernetes/examples/guestbook/redis-master-deployment.yaml"
```

    deployment "redis-master" created
    



```bash
vagrant ssh node1 -c "kubectl get deployments"
```

    NAME           DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    redis-master   1         1         1            1           7s
    



```bash
vagrant ssh node1 -c "kubectl get pods"
```

    NAME                            READY     STATUS    RESTARTS   AGE
    redis-master-2353460263-bd47e   1/1       Running   0          29s
    



```bash
vagrant ssh node1 -c "kubectl get pods --all-namespaces"
```

    NAMESPACE   NAME                            READY     STATUS    RESTARTS   AGE
    default     redis-master-2353460263-bd47e   1/1       Running   0          1m
    



```bash
vagrant ssh node1 -c "kubectl describe pods redis-master-2353460263-bd47e"
```

    Name:		redis-master-2353460263-bd47e
    Namespace:	default
    Node:		node1/10.0.2.15
    Start Time:	Mon, 31 Oct 2016 12:54:49 +0000
    Labels:		app=redis,pod-template-hash=2353460263,role=master,tier=backend
    Status:		Running
    IP:		172.17.96.2
    Controllers:	ReplicaSet/redis-master-2353460263
    Containers:
      master:
        Container ID:	docker://0d00c2bb0b2c572603ac25c3d3e94a746c5fbe8a81007d18f55b1d0af0277c56
        Image:		gcr.io/google_containers/redis:e2e
        Image ID:		docker://sha256:e5e67996c442f903cda78dd983ea6e94bb4e542950fd2eba666b44cbd303df42
        Port:		6379/TCP
        QoS Tier:
          cpu:	Burstable
          memory:	Burstable
        Requests:
          cpu:		100m
          memory:		100Mi
        State:		Running
          Started:		Mon, 31 Oct 2016 12:54:50 +0000
        Ready:		True
        Restart Count:	0
        Environment Variables:
    Conditions:
      Type		Status
      Ready 	True 
    No volumes.
    Events:
      FirstSeen	LastSeen	Count	From			SubobjectPath		Type		Reason			Message
      ---------	--------	-----	----			-------------		--------	------			-------
      2m		2m		1	{default-scheduler }				Normal		Scheduled		Successfully assigned redis-master-2353460263-bd47e to node1
      2m		2m		2	{kubelet node1}					Warning		MissingClusterDNS	kubelet does not have ClusterDNS IP configured and cannot create Pod using "ClusterFirst" policy. Falling back to DNSDefault policy.
      2m		2m		1	{kubelet node1}		spec.containers{master}	Normal		Pulled			Container image "gcr.io/google_containers/redis:e2e" already present on machine
      2m		2m		1	{kubelet node1}		spec.containers{master}	Normal		Created			Created container with docker id 0d00c2bb0b2c
      2m		2m		1	{kubelet node1}		spec.containers{master}	Normal		Started			Started container with docker id 0d00c2bb0b2c
    
    
    



```bash
vagrant ssh node1 -c "kubectl logs redis-master-2353460263-bd47e"
```

                    _._                                                  
               _.-``__ ''-._                                             
          _.-``    `.  `_.  ''-._           Redis 2.8.19 (00000000/0) 64 bit
      .-`` .-```.  ```\/    _.,_ ''-._                                   
     (    '      ,       .-`  | `,    )     Running in stand alone mode
     |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
     |    `-._   `._    /     _.-'    |     PID: 1
      `-._    `-._  `-./  _.-'    _.-'                                   
     |`-._`-._    `-.__.-'    _.-'_.-'|                                  
     |    `-._`-._        _.-'_.-'    |           http://redis.io        
      `-._    `-._`-.__.-'_.-'    _.-'                                   
     |`-._`-._    `-.__.-'    _.-'_.-'|                                  
     |    `-._`-._        _.-'_.-'    |                                  
      `-._    `-._`-.__.-'_.-'    _.-'                                   
          `-._    `-.__.-'    _.-'                                       
              `-._        _.-'                                           
                  `-.__.-'                                               
    [1] 31 Oct 12:54:50.121 # Server started, Redis version 2.8.19
    [1] 31 Oct 12:54:50.126 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
    [1] 31 Oct 12:54:50.126 * The server is now ready to accept connections on port 6379
    


#### Step2: Start the Redis Slave

We will start the Redis Slave using the deployment file listed below


```bash
vagrant ssh node1 -c "cat kubernetes/examples/guestbook/redis-slave-service.yaml"
```

    apiVersion: v1
    kind: Service
    metadata:
      name: redis-slave
      labels:
        app: redis
        role: slave
        tier: backend
    spec:
      ports:
        # the port that this service should serve on
      - port: 6379
      selector:
        app: redis
        role: slave
        tier: backend
    



```bash
vagrant ssh node1 -c "kubectl create -f kubernetes/examples/guestbook/redis-slave-service.yaml"
```

    service "redis-slave" created
    



```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME           CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    kubernetes     10.254.0.1       <none>        443/TCP    2h
    redis-master   10.254.193.146   <none>        6379/TCP   17m
    redis-slave    10.254.110.110   <none>        6379/TCP   50s
    



```bash
vagrant ssh node1 -c "kubectl create -f kubernetes/examples/guestbook/redis-slave-deployment.yaml"
```

    deployment "redis-slave" created
    



```bash
vagrant ssh node1 -c "kubectl get deployments"
```

    NAME           DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    redis-master   1         1         1            1           10m
    redis-slave    2         2         2            2           4s
    



```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME           CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    kubernetes     10.254.0.1       <none>        443/TCP    2h
    redis-master   10.254.193.146   <none>        6379/TCP   18m
    redis-slave    10.254.110.110   <none>        6379/TCP   2m
    



```bash
vagrant ssh node1 -c "kubectl get pods"
```

    NAME                            READY     STATUS    RESTARTS   AGE
    redis-master-2353460263-bd47e   1/1       Running   0          10m
    redis-slave-1691881626-1okos    1/1       Running   0          28s
    redis-slave-1691881626-1u22e    1/1       Running   0          28s
    


#### Start the Guestbook frontend:


```bash
vagrant ssh node1 -c "cat kubernetes/examples/guestbook/all-in-one/frontend.yaml"
```

    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      # if your cluster supports it, uncomment the following to automatically create
      # an external load-balanced IP for the frontend service.
      # type: LoadBalancer
      ports:
        # the port that this service should serve on
      - port: 80
      selector:
        app: guestbook
        tier: frontend
    ---
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: frontend
      # these labels can be applied automatically
      # from the labels in the pod template if not set
      # labels:
      #   app: guestbook
      #   tier: frontend
    spec:
      # this replicas value is default
      # modify it according to your case
      replicas: 3
      # selector can be applied automatically
      # from the labels in the pod template if not set
      # selector:
      #   matchLabels:
      #     app: guestbook
      #     tier: frontend
      template:
        metadata:
          labels:
            app: guestbook
            tier: frontend
        spec:
          containers:
          - name: php-redis
            image: gcr.io/google-samples/gb-frontend:v4
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
            env:
            - name: GET_HOSTS_FROM
              value: dns
              # If your cluster config does not include a dns service, then to
              # instead access environment variables to find service host
              # info, comment out the 'value: dns' line above, and uncomment the
              # line below.
              # value: env
            ports:
            - containerPort: 80
    



```bash
vagrant ssh node1 -c "kubectl create -f kubernetes/examples/guestbook/all-in-one/frontend.yaml"
```

    service "frontend" created
    deployment "frontend" created
    



```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME           CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    frontend       10.254.220.26    <none>        80/TCP     2m
    kubernetes     10.254.0.1       <none>        443/TCP    2h
    redis-master   10.254.193.146   <none>        6379/TCP   23m
    redis-slave    10.254.110.110   <none>        6379/TCP   7m
    



```bash
vagrant ssh node1 -c "kubectl get deployments"
```

    NAME           DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    frontend       3         3         3            1           3m
    redis-master   1         1         1            1           15m
    redis-slave    2         2         2            2           5m
    



```bash
vagrant ssh node1 -c "kubectl get pods"
```

    NAME                            READY     STATUS    RESTARTS   AGE
    frontend-440143558-3xe8u        1/1       Running   0          3m
    frontend-440143558-5e211        0/1       Pending   0          3m
    frontend-440143558-qngwf        0/1       Pending   0          3m
    redis-master-2353460263-bd47e   1/1       Running   0          16m
    redis-slave-1691881626-1okos    1/1       Running   0          5m
    redis-slave-1691881626-1u22e    1/1       Running   0          5m
    



```bash
vagrant ssh node1 -c "kubectl get pods -L tier"
```

    NAME                            READY     STATUS    RESTARTS   AGE       TIER
    frontend-440143558-3xe8u        1/1       Running   0          3m        frontend
    frontend-440143558-5e211        0/1       Pending   0          3m        frontend
    frontend-440143558-qngwf        0/1       Pending   0          3m        frontend
    redis-master-2353460263-bd47e   1/1       Running   0          16m       backend
    redis-slave-1691881626-1okos    1/1       Running   0          6m        backend
    redis-slave-1691881626-1u22e    1/1       Running   0          6m        backend
    


#### Cleanup


```bash
vagrant ssh node1 -c "kubectl delete deployments,services -l 'app in (redis, guestbook)'"
```

    deployment "frontend" deleted
    deployment "redis-master" deleted
    deployment "redis-slave" deleted
    service "frontend" deleted
    service "redis-master" deleted
    service "redis-slave" deleted
    



```bash
vagrant ssh node1 -c "kubectl get services"
```

    NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
    kubernetes   10.254.0.1   <none>        443/TCP   2h
    

