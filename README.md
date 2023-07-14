# shell script to install the following with aws-userdata. 
The server is Ubuntu server 20.04

***AFTER Docker is installed run this***

```
sudo chown ubuntu:docker /var/run/docker.sock
```

- snap
- unzip
- wget
- Kubectl
- kubens
- kubectx 
- AWSCli
- Python PiP
- Flask
- Trivy
- git
- MkDocs
- Terraform
- Helm
- Docker

```sh
#!/bin/bash
# Update package lists
apt-get update

# Install dependencies
apt-get install -y curl bash-completion snapd git unzip wget

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install kubectx and kubens
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
ln -s /opt/kubectx/completion/kubectx.bash /etc/bash_completion.d/kubectx
ln -s /opt/kubectx/completion/kubens.bash /etc/bash_completion.d/kubens
echo 'alias kx=kubectx' >> /root/.bashrc
echo 'alias kn=kubens' >> /root/.bashrc

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install Python and Pip
apt-get install -y python3 python3-pip

# Install Flask
pip3 install flask

# Install Trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list
apt-get update
apt-get install -y trivy

# Install MkDocs
pip3 install mkdocs

# Install Terraform
curl -LO "https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip"
unzip terraform_0.15.4_linux_amd64.zip
install -o root -g root -m 0755 terraform /usr/local/bin/terraform

# Install Helm
curl https://baltocdn.com/helm/signing.asc | apt-key add -
apt-get install -y apt-transport-https --no-install-recommends
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install -y helm

# Install Docker
sudo su -
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg -y
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add ubuntu user to the docker group
sudo usermod -aG docker jenkins
```

```sh
# Install Jenkins
#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo apt install maven -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
```

snap --version
unzip --version
wget --version
kubectl
kubens --version
kubectx  --version
aws --version
pip --version
flask --version
trivy --version
git --version
mkdocs --version
terraform --version
helm 
docker --version

### Setup Jenkins server
- Add Jenkins user into sudoers file to get sudo access

```
sudo su –
vi /etc/sudoers
```

[jenkins ALL=(ALL) NOPASSWD: ALL]  //add this under root

```
OR sudo usermod -aG docker jenkins 
```

============================================
NOTE: Switch to Jenkins user to install Docker
sudo su Jenkins
============================================

- Install Docker in the Jenkins server
- provide permissions to jenkins user in jenkins server to access docker

```
cat /etc/group | grep -i docker 
sudo groupadd docker      //adding Jenkins to the docker group
sudo usermod -aG docker Jenkins      //adding Jenkins to the docker group
sudo chmod 777 /var/run/docker.sock
```

### Build process that worked

```groovy
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'sosoaws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws --version
            aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
          '''
        }
      }
    }
  }
}
```

```groovy
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'sosoaws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws --version
            aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
          '''
        }
      }
    }
    stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sosotechnologies/aws-documentation-ecr-jenkins.git']]])
      }
    }
  }
}
```

```groovy
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'sosoaws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws --version
            aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
          '''
        }
      }
    }
    stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sosotechnologies/aws-documentation-ecr-jenkins.git']]])
      }
    }
    stage('Build') {
  steps {
    sh '''
      sudo docker build -t soso-repository/sosodocs:1.0.0 .
    '''
     }
  }
  }
}
```

```groovy
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'sosoaws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws --version
            aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
          '''
        }
      }
    }
    stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sosotechnologies/aws-documentation-ecr-jenkins.git']]])
      }
    }
  stage('Build') {
  steps {
    sh '''
      sudo docker build -t soso-repository/sosodocs:1.0.0 .
    '''
     }
  }
  stage('Pushing to ECR') {
      steps {
        script {
          // Retrieve ECR login command
          def ecrLoginCommand = sh(
            script: 'aws ecr get-login-password | /usr/bin/docker login --username AWS --password-stdin 088789840359.dkr.ecr.us-east-1.amazonaws.com',
            returnStdout: true
          ).trim()
       

          // Push the Docker image to ECR
          sh '''
            docker tag soso-repository/sosodocs:1.0.0 088789840359.dkr.ecr.us-east-1.amazonaws.com/soso-repository
          '''
          sh '''
            sudo docker push 088789840359.dkr.ecr.us-east-1.amazonaws.com/soso-repository
          '''
        }
      }
    }
  }
}
```
