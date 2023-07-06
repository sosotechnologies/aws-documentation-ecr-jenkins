# What's Red Hat OpenShift
Red Hat OpenShift, the industry's leading hybrid cloud application platform powered by Kubernetes, 
brings together tested and trusted services to reduce the friction of developing, modernizing,
deploying, running, and managing applications. 
See official link: [Openshift](https://www.redhat.com/en/technologies/cloud-computing/openshift)

## Getting Started - Steps
- Signup/signin to Openshift account: [See-Link](https://cloud.redhat.com/openshift/install)
- Navigate to: Clusters -> Cluster Type -> Amazon Web Services -> Installer-provisioned infrastructure
   ![openshift](photos/install.png)

***Install OpenShift on AWS with user-provisioned infrastructure***
 Select the option [Full control]

See the site: [/openshift/install/aws](https://console.redhat.com/openshift/install/aws/user-provisioned)

  ![openshift](photos/openshiftl0.png)

### Install OpenShift on AWS
- Setup an AWS Instance and add security group number [6443]
- Setup a Route53 DNS
- ***make*** a new directory for the installation, mine is soso-dir

   ```mkdir soso-dir/```

AWS Openshift installation Link: [See-Link](https://console.redhat.com/openshift/install/aws/installer-provisioned)
There are ***Two*** Cluster-Setup options to choose: a customized cluster ***or*** quickly install.

  - Install the Openshift installer and client on your local computer.
  - Move that file to your remote linux machine. You're see the client and installer.
  - Extract the installer and client: 

     ```tar xvf openshift-install-linux.tar.gz```
     ```tar xvf openshift-client-linux.tar.gz```

  - Move the oc, kubectl and installer to usr/bin directoory

    ```
    sudo mv oc /usr/local/bin/
    sudo mv kubectl /usr/local/bin/
    sudo cp openshift-install /usr/local/bin/
    sudo cp openshift-install /root/
    which openshift-install
    oc help
    ```

    ***Install AWSCLI***

    ```
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    ```

  - Copy the secret content and paste in a file. This secret is from the redhad account, 
    used to Map the AWS Cluster with the redHat account.
  - ***In the AWS Console, setup the following:***
      - Route53 public Hoster Zone
      - Add OpenShift port 6443 to instance security groups
      - Create 
        - Create Access and Secret Keys for the Root-user and configure aws

          ```aws configure```

  - CD to ***ROOT*** and Create an SSH Key in the root directory
    
    ```sudo su -```

    ```ssh-keygen -t rsa -b 4096 -N '' -f id_rsa```

  - Evaluate and add to root. This will starts ssh-agent and configures the 
  environment (via eval) of the running shell to point to that agent.

    ```
    eval "$(ssh-agent -s)"
    ssh-add /root/id_rsa
    ```
     
  - Now start the prompt to install Openshift


  
  
  - ***install Openshift using the config, so you can customize***. 
    A prompt will begin. The last prompt will be the secret
    Copy and paste the secret characters that we had saved earlier.

      - ```openshift-install create install-config``` 
  
  - OPTIONAL: Make a copy of the file: 
  
  ```cp -r install-config.yaml soso-config.yaml```

  - paste the below content in the file. edit the file to suite ur options.
  ***Note***: Two keys will be added to the yaml file:
   1.  The sshKey: ```cat id_rsa.pub```
   2. The openShift Key we copied and pasted.

```yaml
apiVersion: v1
baseDomain: macazzzzz.com
controlPlane:
  hyperthreading: Enabled
  name: master
  platform:
    aws:
      zones:
      - us-east-1a
      #- us-east-1b
      #- us-east-1c
      rootVolume:
        size: 100
        type: gp2
      type: m4.xlarge
  replicas: 3
compute:
- hyperthreading: Enabled
  name: worker
  platform:
    aws:
      zones:
      - us-east-1a
      #- us-east-1b
      #- us-east-1c
      rootVolume:
        size: 100
        type: gp2
      type: m4.xlarge
  replicas: 1
metadata:
  name: openshift
networking:
  clusterNetwork:
  - cidr: 10.128.0.0/14
    hostPrefix: 23
  machineNetwork:
  - cidr: 192.168.0.0/20
  networkType: OpenShiftSDN
  serviceNetwork:
  - 172.30.0.0/16
platform:
  aws:
    region: us-east-1
    userTags:
      adminContact: Collins
      costCenter: 123
      email: cafanwi@sosotechnologies.com
publish: External
pullSecret: ''
sshKey: 
```

### Install the cluster
In the same directory of the openshift-install file, Run command to install:

```
openshift-install create cluster --log-level debug
```

***Cluster done installing, you should see as below image, your creds and url.
![openshift](photos/install12.png)

After installation, you should have your results as seen in the below image:
  ![openshift](photos/install1.png)

  ***Cat and export the konfig file***
  
  ```
    cat auth/kubeconfig
    export KUBECONFIG=/root/auth/kubeconfig
    oc whoami
  ```

 ***Get Cluster URL with the below command***

```
 oc cluster-info
 cd auth/
```

### Working on cluster
Some command commands:
***Create a new project called soso-project***
```
oc new-project soso-project --display-name 'Soso Project'
oc project soso-project
```

**Sample use case:**
- Clone this repo: [My docs dockerfile repo](https://github.com/sosotechnologies/docs_docker_io)
- Install Docker on terminal
- Create a repo in Dockerdesktop called:  sosotech/docs-repo-sosodocs

```docker build -t sosodocs .```

```docker tag sosodocs sosotech/docs-repo/sosodocs:v1```

```oc cluster-info```

***Openshift Image***
```
oc get is
oc new-app --image="sosotech/docs-repo/sosodocs:v1" --as-deployment-config
oc expose service/docs-repo-sosodocs

```

***OTHER COMMANDS***
1. Delete image string called: macaz
```oc delete is macaz```















**Sample use case:**
- Clone this repo: [My docs dockerfile repo](https://github.com/sosotechnologies/docs_docker_io)
- Install Docker/podman:  

```docker build -t sosodocs .```

```oc cluster-info```

```sudo docker tag sosodocs default-route-openshift-image-registry.apps.openshift.macazzz.com/sosorepo:v1```

```docker login```

```docker search registry.redhat.io/nginx```


For more commands on OpenShift: [See the developer-cli-commands Link](https://docs.openshift.com/container-platform/4.10/cli_reference/openshift_cli/developer-cli-commands.html)





AWS Openshift installation Link: [See-Link](https://docs.openshift.com/container-platform/4.1/installing/installing_aws/installing-aws-account.html)



  ```./openshift-install create cluster --dir /root/ --log-level debug``` 

  ### Destroy the cluster

  ```./openshift-install destroy cluster --dir /root/ --log-level debug``` 


[***web console Link:*** ](https://console.redhat.com/openshift)

https://console-openshift-console.apps.openshift.macazzz.com/k8s/ns/soso-project/image.openshift.io~v1~ImageStream
kubeadmin
7JdHf-X34nV-ubmSh-ijSA4

docker-registry-default.127.0.0.1.nip.io

[Deploy Image](https://console-openshift-console.apps.openshift.macazzz.com/deploy-image/ns/soso-project)

***Docker config path***
```
sudo vi /root/.docker/config.json
```

***OC TROUBLESHOOT***
oc get service -n default  kubernetes -o 'jsonpath={.spec.clusterIP}'