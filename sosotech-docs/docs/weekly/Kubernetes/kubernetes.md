# Minikube

```
choco install minikube
minikube start
```

```
kubectl config get-contexts
kubectl config use-context  docker-desktop
```

# KOPS
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
aws s3 mb s3://soso-kops-bucket.local
```

***OPTIONAL***
```
aws s3api create-bucket \
    --bucket soso-kops-bucket \
    --region us-east-1 
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
    --node-size t2.medium \
    --master-size t2.medium \
    --master-count 1 --node-size t2.medium --node-count=1
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




To deploy EFS-EKS-using Terraform, [clone My repo](terraform-EFS-Dynamic)

You can clone and build this Documentation and use the image [mkdocs-docker-build](https://github.com/sosotechnologies/docs_docker_io)


## EKS
- AWS Linux 2 AMD x86_64
- Install AWSCLI 
- Install Kubectl version 1.23
- EKS Version installed 1.24
- Install Git
- Install Terraform
- Configure AWS
- Install Helm

### Install AWSCLI 
  - [Right-Click to open Link in a New Tab](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Install Kubectl version 1.23
[Right-Click to open Link in a New Tab](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)

```
kubectl version --short --client
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.11/2023-03-17/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
```

### Install Terraform 
  - [Right-Click to open Link in a New Tab](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Install Git

```
Suso yum install git -y
```

### Install HelM 
  - [Right-Click to open Link in a New Tab](https://helm.sh/docs/intro/install/)
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

### Configure KubeConfig
```
aws eks update-kubeconfig --region us-east-1 --name DevOps-prod-SoSo-Eks
```


```
kubectl apply -f .
```