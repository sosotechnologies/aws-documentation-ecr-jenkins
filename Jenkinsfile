// Build STEP 1

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
---

// Build STEP 2

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
---

// Build STEP 3
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
---

// Build STEP 4
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
