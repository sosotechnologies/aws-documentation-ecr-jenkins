## Jenkins
- Ubuntu VERSION="20.04.6 LTS 
- TCP Port ***8080*** from Anywhere - IPv4 and IPv6
- Add Port 8080 to your security groups
- Create an IAM role and attach to the EC2 instance [AdministratorAccess] for Demo

### Install
- create a file called [gerard-jenkins.sh] and drop the scrips into it:
- making the script executable
- run the script: [sh gerard-jenkins.sh]

```
nano gerard-jenkins.sh
chmod +x gerard-jenkins.sh    # making the script executable
```

```sh
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

***Check and start the jenkins service***

```
sudo systemctl status jenkins
java -version
whereis git
```

### Install Docker on the EC2 instance
- create a file called [gerard-docker.sh] and drop the scrips into it:
- making the script executable
- run the script: [sh gerard-docker.sh]

```
nano gerard-docker.sh
chmod +x gerard-docker.sh    # making the script executable
```

```sh
# Install Docker
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# Add ubuntu user to the docker group
sudo usermod -aG docker jenkins
```

***Verify Installation of docker was successful***

```
docker -v
sudo systemctl status docker
id jenkins     # making sure that the Jenkins was added to the docker group
```

### Now moving to the Jenkins UI
- Get Jenkins Password

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Install plugins in the Jenkins server
***Dashboard --> Manage Jenkins --> Plugin Manager***

- docker pipeline
- docker
- Amazon ECR
- CloudBees Docker Build and Publish
- Amazon Web Services SDK :: All

### Global Tool Configuration

***Configure CI [Git, Maven, JVM, SonarQube Scanner ] on Jenkins GUI***.

In the Jenkins UI --> manage Jenkins --> Tools  [save]


| Services          |   Configured Names      |
|-------------------|:-----------------------:|
| git               |  Git                    |

### Configure Credential
- get Access-Tokens from your dockerhub
- Navigate to: ***Jenkins UI --> manage Jenkins --> Credentials --> System --> Global credentials***

| Services            |   Credential ID       | UserName/Password/secret-text   |               
|---------------------|:---------------------:|--------------------------------:|
| DockerHub           | gerarddockertoken     |    secret-text                  |
| GitHub              | gerardgithub          |    UserName/Password            |


```Dockerfile
pipeline {
    agent any

    environment {
        // Define environment variables
        DOCKER_HUB_CREDENTIALS = credentials('gerarddockertoken')
        DOCKER_IMAGE_NAME = 'sosotech/test-image-saturday'
        GIT_REPO_URL = 'https://github.com/sosotechnologies/soso_technologies_macaz_doc.io.git'
        DOCKERFILE_PATH = 'Dockerfile'  // Relative path to Dockerfile
    }

    stages {
        stage('Checkout') {
            steps {
                // Use GitHub credentials to checkout the code
                withCredentials([usernamePassword(credentialsId: 'gerardgithub', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')]) {
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], userRemoteConfigs: [[url: "${GIT_REPO_URL}", credentialsId: 'gerardgithub']]])
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def dockerImage = docker.build(DOCKER_IMAGE_NAME, "-f ${DOCKERFILE_PATH} .")
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('', DOCKER_HUB_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
```