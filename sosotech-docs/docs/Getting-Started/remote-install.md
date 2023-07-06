# Remote Server

## Installation links

### Install IAM EKS authenticator 
  - [Right-Click to open Link in a New Tab](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
```
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
sudo mv ./aws-iam-authenticator /usr/local/bin
aws-iam-authenticator help
```
### Install docker in ec2 
  - [Right-Click to open Link in a New Tab](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html)

### Install AWSCLI 
  - [Right-Click to open Link in a New Tab](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

***Install AWCLI on Ubuntu***

```
sudo apt update -y
sudo apt install awscli -y
```

### Install Terraform 
  - [Right-Click to open Link in a New Tab](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Install Kubens + kubectx 
  - [Right-Click to open Link in a New Tab](https://github.com/ahmetb/kubectx#installation) 

### Install HelM 
  - [Right-Click to open Link in a New Tab](https://helm.sh/docs/intro/install/)
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

### Install Kubectl 
  - [Right-Click to open Link in a New Tab](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl)
```
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.11/2023-03-17/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

***More Troubleshooting Options***

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
[OR] sudo install -o root -g root -m 0755 kubectl /home/ec2-user/bin/kubectl
kubectl version --client --output=yaml
```

### Install MkDocs 
  - [Right-Click to open Link in a New Tab](https://www.mkdocs.org/user-guide/installation/)
```
pip install mkdocs
mkdocs helm
mkdocs new my-soso-package
cd my-soso-package
tree
```

### Install PiP on RHeL
```
REDHAT
sudo yum info python*-pip     //get the pip version, then install the version
sudo yum install python3-pip
python3 --version
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
```

### Install python-pip in ubuntu
```
sudo apt install python3-pip
```

### Install Trivy 
  - [Right-Click to open Link in a New Tab](https://aquasecurity.github.io/trivy/v0.18.3/installation/)

```
sudo yum -y update

sudo wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.deb
sudo dpkg -i trivy_0.18.3_Linux-64bit.deb
trivy i nginx    //scanning nginx image
trivy i nginx | grep -i critical
trivy i nginx:alpine | grep -i critical
```

### Install KOPs on Ubuntu

- [Right-Click to open Link in a New Tab](https://kops.sigs.k8s.io/getting_started/aws/)


***Add KOPS User***

```
sudo adduser kops
sudo echo "kops  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/kops
sudo su - kops
```
***Installing kOps***

```
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/
```
***Install Python PiP***

```
sudo apt -y update
sudo apt install python3-pip
```

***Install AWSCli***

```
 sudo apt  install awscli -y
```

***Install Kubectl***

```
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

***Create S3 Bucket***

```
aws s3 ls

aws s3api create-bucket \
    --bucket soso-kops-bucket \
    --region us-east-1 \
    --acl public-read
```

***Add env variables in bashrc***

```
vi .bashrc

export NAME=soso-kops-bucket.k8s.local                               
export KOPS_STATE_STORE=s3://soso-kops-bucket.local 
 
source .bashrc
```

***Generate an sshkeys before creating cluster***

```
ssh-keygen
```

***Install Cluster preconfig file***

```
kops create cluster \
    --name=${NAME} \
    --cloud=aws \
    --zones=us-west-2a \
    --discovery-store=s3://soso-kops-bucket/${NAME}/discovery
```

***Edit the cluster name- OPTIONAL***

```
kops edit cluster --name ${NAME}
```

***Install Cluster***

```
kops update cluster --name ${NAME} --yes --admin
```
**NOTE: WAIT 10 Mins before Checking Nodes and Validating cluster***

***Get nodes***

```
kubectl get nodes
```

***Validate Cluster***

```
kops validate cluster --wait 10m
```

***Delete cluster***

```
kops delete cluster --name ${NAME}
               [OR]
kops delete cluster --name ${NAME} --yes
```

***Install pyton and pup on libux AWS***

```
python --version
sudo yum install python37
python3 --version
```

***To install pip and the EB CLI***

```
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

echo $SHELL

ls -a ~

export PATH=/bin/bash:$PATH

source .bashrc
```