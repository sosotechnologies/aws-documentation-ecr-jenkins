kubectl exec -i -t my-pod --container main-app -- /bin/bash

[ec2-user@ip-172-31-201-145 ~]$ sudo cp agent.jar ../../opt

sudo chmod 777 -R /opt

java -jar agent.jar -jnlpUrl http://ab5223ff23ed749b3ac51f92d244edcb-183061686.us-east-1.elb.amazonaws.com:8080/manage/computer/macaz/jenkins-agent.jnlp -secret 32d9d58f3296eb3d80c4d37836f5ed5ee6ed6cbfba258ad7e5c7c6e291f0ac37 -workDir "/opt/build" &


Install Jdk [click-here](https://techviewleo.com/install-java-openjdk-on-amazon-linux-system/)

https://www.ashnik.com/install-jenkins-on-aws-ec2-instance-using-terraform/

after installing, you have to connect slave with the master



if your jenkins server restarts and you forgot the password, run this command:

```sudo cat /var/lib/jenkins/users```