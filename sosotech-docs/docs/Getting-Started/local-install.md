# Locally
 System Requirements

 Windows OS systems will be the preferred OS that will be used throughout 
 this program. Students with MaC OS can still use their MAC pcs, but may have 
 some diffuculties with running some Windows-specific commands.

## Install WSL
Requirments:

- windows 10 or greater

  In the windows search, Type: 'feat'  

  Click -> Turning windows features off or on, and check

   ***select***

   - [x] virtual machine platform
   - [x] windows Subsystem for Linux

     Some common WSL commands, use PowerShell

  ```
  $ winver
  $ wsl -l -v
  $ wsl --set-version Ubuntu-20.04 2
  $ wsl --set-default-version 2
  ```

See Youtube link: [Click link](https://www.youtube.com/watch?v=_fntjriRe48)

Install Linux Kernel [Step 4 - Download the Linux kernel update package](https://learn.microsoft.com/en-us/windows/wsl/install-manual)

Now go to searchBar and search ***store***
 
## Install Chocolatey
Open Powershell as Administrative user
Link [Click-Link](https://docs.chocolatey.org/en-us/choco/setup)

Run Command: 
   ```Get-ExecutionPolicy```

If it returns Restricted, then run: 
   
  ```Set-ExecutionPolicy AllSigned```

Now run the following command:

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
## Install AWSCli
***Run command:*** msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi

## Install Choco Packages
- choco install kubectl

- choco install k9s

- choco install terraform

- choco install kubens kubectx

## Install Docker Desktop/k8s   
use link: [Click link to install](https://docs.docker.com/desktop/install/windows-install/)


***Restart System***