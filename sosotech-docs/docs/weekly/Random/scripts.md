# All Scripts

### Get Secrets expiration dates
```sh
#!/bin/sh
 DAYS="604800" 
 YOUR_WEBHOOK_URL="collins-slack-channel"
 echo "Input the cluster name"
 read -r cluster
 echo "Input the namespace"
 read -r namespace
 for i in `kubectl --context $cluster get cm -n $namespace | awk '{print $1}' | grep -vi name`
 do
     filename="cm_$i'_'$namespace.pem"
     if `kubectl --context $cluster  -n $namespace get cm $i -o yaml | grep pem `
     then
         kubectl --context $cluster  -n $namespace get cm $i -o yaml | yq .data > $filename
         cert_expr_date=$(openssl x509 -enddate -noout -in $filename | awk -F"=" '{print $2}')
         openssl x509 -enddate -noout -in $filename  -checkend "$DAYS" | grep -q 'Certificate will expire'
         if [ $? -eq 0 ]
         then
             curl -X POST -H 'Content-type: application/json' --data '{"text":"Certificate in configmap with name '$i' in namespace '$namespace' will expire in 7 days "}' $YOUR_WEBHOOK_URL
             curl -X POST -H 'Content-type: application/json' --data '{"text":"Certificate in configmap with name '$i' in namespace '$namespace' will expire on '$cert_expr_date' "}' $YOUR_WEBHOOK_URL
         fi
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Certificate in configmap with name '$i' in namespace '$namespace' will expire on '$cert_expr_date' "}' $YOUR_WEBHOOK_URL 
     fi
 done
 for i in `kubectl --context $cluster get secret -n $namespace | awk '{print $1}' | grep -vi name`
 do
      filename="secret_$i'_'$namespace.pem"
     if `kubectl --context $cluster  -n $namespace get secret $i -o yaml | grep pem `
     then
         kubectl --context $cluster  -n $namespace get secret $i -o yaml |yq .data | grep crt | awk -F":" '{print $2}' | base64 -d > $filename
         cert_expr_date=$(openssl x509 -enddate -noout -in $filename | awk -F"=" '{print $2}')
         openssl x509 -enddate -noout -in $filename  -checkend "$DAYS" | grep -q 'Certificate will expire'
         if [ $? -eq 0 ]
         then
             curl -X POST -H 'Content-type: application/json' --data '{"text":"Certificate in secret with name '$i' in namespace '$namespace' will expire in 7 days "}' $YOUR_WEBHOOK_URL
             curl -X POST -H 'Content-type: application/json' --data '{"text":"Certificate in configmap with name '$i' in namespace '$namespace' will expire on '$cert_expr_date' "}' $YOUR_WEBHOOK_URL
         fi
             curl -X POST -H 'Content-type: application/json' --data '{"text":"Certificate in configmap with name '$i' in namespace '$namespace' will expire on '$cert_expr_date' "}' $YOUR_WEBHOOK_URL
     fi
 done
```

### SonarQube - Ubuntu VERSION="18.04"

```sh
#!/bin/bash
cp /etc/sysctl.conf /root/sysctl.conf_backup
cat <<EOT> /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=65536
ulimit -n 65536
ulimit -u 4096
EOT
cp /etc/security/limits.conf /root/sec_limit.conf_backup
cat <<EOT> /etc/security/limits.conf
sonarqube   -   nofile   65536
sonarqube   -   nproc    409
EOT
sudo apt-get update -y
sudo apt-get install openjdk-11-jdk -y
sudo update-alternatives --config java
java -version
sudo apt update
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt install postgresql postgresql-contrib -y
#sudo -u postgres psql -c "SELECT version();"
sudo systemctl enable postgresql.service
sudo systemctl start  postgresql.service
sudo echo "postgres:admin123" | chpasswd
runuser -l postgres -c "createuser sonar"
sudo -i -u postgres psql -c "ALTER USER sonar WITH ENCRYPTED PASSWORD 'admin123';"
sudo -i -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar;"
systemctl restart  postgresql
#systemctl status -l   postgresql
netstat -tulpena | grep postgres
sudo mkdir -p /sonarqube/
cd /sonarqube/
sudo curl -O https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.3.0.34182.zip
sudo apt-get install zip -y
sudo unzip -o sonarqube-8.3.0.34182.zip -d /opt/
sudo mv /opt/sonarqube-8.3.0.34182/ /opt/sonarqube
sudo groupadd sonar
sudo useradd -c "SonarQube - User" -d /opt/sonarqube/ -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube/ -R
cp /opt/sonarqube/conf/sonar.properties /root/sonar.properties_backup
cat <<EOT> /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonar
sonar.jdbc.password=admin123
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
sonar.web.host=0.0.0.0
sonar.web.port=9000
sonar.web.javaAdditionalOpts=-server
sonar.search.javaOpts=-Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError
sonar.log.level=INFO
sonar.path.logs=logs
EOT
cat <<EOT> /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536
LimitNPROC=4096
[Install]
WantedBy=multi-user.target
EOT
systemctl daemon-reload
systemctl enable sonarqube.service
#systemctl start sonarqube.service
#systemctl status -l sonarqube.service
apt-get install nginx -y
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default
cat <<EOT> /etc/nginx/sites-available/sonarqube
server{
    listen      80;
    server_name sonarqube.groophy.in;
    access_log  /var/log/nginx/sonar.access.log;
    error_log   /var/log/nginx/sonar.error.log;
    proxy_buffers 16 64k;
    proxy_buffer_size 128k;
    location / {
        proxy_pass  http://127.0.0.1:9000;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;
              
        proxy_set_header    Host            \$host;
        proxy_set_header    X-Real-IP       \$remote_addr;
        proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto http;
    }
}
EOT
ln -s /etc/nginx/sites-available/sonarqube /etc/nginx/sites-enabled/sonarqube
systemctl enable nginx.service
#systemctl restart nginx.service
sudo ufw allow 80,9000,9001/tcp
echo "System reboot in 30 sec"
sleep 30
reboot
```

### Jenkins - Ubuntu VERSION="20.04.6 LTS 

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

### Multiple install script

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
curl -LO "https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip"
unzip terraform_1.5.2_linux_amd64.zip
sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform

# Install Helm
curl https://baltocdn.com/helm/signing.asc | apt-key add -
apt-get install -y apt-transport-https --no-install-recommends
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install -y helm

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

# Install Docker
sudo su -
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

