# What are we going to achieve here?
Our developers have written some java base web-app and they are pushing that 
code to a git repo.
We need a DevOps envineer who will comein and help setup our infrastruucture, 
Build an automation mechanish, that we can
utilize to integrate this code for testing, Deliver, Deployment. 
Also, we will need these artifacts to be built into containerized application, build an ocastration and deploy this
app to our end users.

## Steps

1. ### Use IaC(terraform) to setup the required ingrastructures "EC2, IAM, EKS"
install terraform: [Link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

2. ### install jenkins server
install jenkins server [Link](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/)

3. ### Install Docker 
Install Docker [Link](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html)

4. ### Install Git 
```sudo yum install git -y```

5. ### Add Jenkins user to the Docker Group
```sudo usermod –aG docker sosojenkinsadmin```  OR  ```sudo usermod –a -G docker jenkins```

6. ### restart the Jenkins server
```sudo service jenkins restart```

7. ### Reload the system Daemon
```sudo systemctl daemon-reload```

8. ### Restart the Docker Service
```sudo service docker restart```

9. ### Return to the Jenkins UI and install these 2 plugins:
   Install the pluginn called ***Docker*** and ***Docker Pipeline***

10. ### Update IAM role and and attach to instance, To Give instance ECR permissions
Create an IAM role with Admin Or with the needed permissions for ECR and other services.

11. ### Create ECR Repo vis same link, scroll to bottom of the page
```aws ecr create-repository --repository-name soso-repository --region us-east-1```

When you create the ECR, go to the ECR in AWS Console and retreive the commands to push image.
See the link for Creating a container image: [Link](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html)

12. ### Check authentication to ECR
check to see if you can successfully login to ecr [my example ecr code below, USE YOURS ], you have to be root, 

```
sudo su -
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 088789840359.dkr.ecr.us-east-1.amazonaws.com
```

13. ### Build and Push Docker
```sudo docker build -t sosodocs .```

***Tag the sosodoc image***

```sudo docker tag sosodocs 088789840359.dkr.ecr.us-east-1.amazonaws.com/soso-repository:mkdocs-v1```

***Push image to repo***

```sudo docker push 088789840359.dkr.ecr.us-east-1.amazonaws.com/soso-repository:mkdocs-v1```

14. ### Install AWS [ CloudBees AWS Credentials ] Plugin and configure
  ***Dashboard*** --> ***Manage Jenkins*** --> ***Plugin Manager***

15. ### setup aws credentials, get your AWS Access Key ID & Secret Access Key
- Create an AWS User called: jenkins
- Give this user permission to ECR: AmazonEC2ContainerRegistryFullAccess and AmazonECS_FullAccess
- Create/Download the Access-key for this user.

Dashboard --> Manage Jenkins --> Manage Credentials --> System --> Global credentials (unrestricted)
    AWS Credentials
          |_ID
          |_Description
          |_Access Key ID
          |_Secret Access Key

16. ### Create new Pipeline Job using below pipeline script with my aws creds
- use pool scm * * * * *

```sh
pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="088789840359"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="soso-repository"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sosotechnologies/aws-nodeJs-ecr-jenkins.git']]])
            }
        }
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
         }
        }
      }
    }
}
```

## Bonus!!!
Test your pipeline with example codes

### Simple Jenkins pipeline Scripts for AWS
 Pipeline version 1

```
pipeline {
  agent any
  stages {
    stage('Welcome to sosotech') {
      steps {
        sh '''
          aws --version
        '''
      }
    }
  }
}
```

### Pipeline version 2
```
pipeline {
  agent any
  stages {
    stage('Welcome to sosotech') {
      steps {
        sh '''
          aws --version
          aws ec2 describe-instances
        '''
      }
    }
  }
}
```

### Pipeline version 3
```
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        sh '''
          aws --version
          aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
        '''
      }
    }
  }
}
```

### Pipeline version 4
```
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'all-in-one-devops', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
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
### Pipeline version 5
 For this step, i'll list buckets

```
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
  }
  stages {
    stage('Welcome to sosotech') {
      steps {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'all-in-one-devops', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws --version
            aws s3api list-buckets --query "Buckets[].Name"
          '''
        }
      }
    }
  }
}
```

### Pipeline version 6

For this step, i'll create an IRSA and save IAM role in Jenkins credentials as 'irsa-creds'

```
pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION="us-east-1"
    WE_KNOW_TECHNOLOGY=credentials('irsa-creds')
  }
  stages {
    stage('Hello') {
      steps {
        sh '''
          aws --version
          aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
        '''
      }
    }
  }
}
```