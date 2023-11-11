https://www.zowe.org/learn
https://docs.zowe.org/stable/user-guide/installandconfig/
https://docs.zowe.org/stable/extend/packaging-zos-extensions/


## Zowe consists of the following components:
Zowe Application Framework
API Mediation Layer
Zowe CLI
Zowe Explorer
Zowe Client Software Development Kits SDKs
Zowe Launcher
ZEBRA (Zowe Embedded Browser for RMF/SMF and APIs) - Incubator

***Focus:*** Zowe CLI

## System requirements

1. Client-side requirements
Node.js: Install a currently supported version of Node.js LTS.

use the script [nodejs.sh]

```
chmod +x nodejs.sh
sh nodejs.sh
```

Get more info about installation: [System requirements](https://docs.zowe.org/stable/user-guide/systemrequirements-cli/)

```
node --version
npm --version
```

2. Server-side requirements

Zowe CLI requires the following mainframe configuration:
  - IBM z/OSMF configured and running: 
  - Plug-in services configured and running:
  - Zowe CLI on z/OS is not supported: 

Get more info about installation: [System requirements](https://docs.zowe.org/stable/user-guide/systemrequirements-cli/)

## NEXT: Configuring Secure Credential Store on headless Linux operating systems
See Link: [https://docs.zowe.org/stable/user-guide/cli-configure-scs-on-headless-linux-os/](https://docs.zowe.org/stable/user-guide/cli-configure-scs-on-headless-linux-os/)

### Unlocking the keyring automatically
***Note:*** The following steps were tested on CentOS, SUSE, and Ubuntu operating systems. The steps do not work on WSL (Windows Subsystem for Linux) because it bypasses TTY login.

***STEPS:***

1. Install the PAM module for [libpam-gnome-keyring:] for Debian, Ubuntu:

```
vi /etc/pam.d/login
```

- Add the following statement to the end of the auth section:

```sh
auth optional pam_gnome_keyring.so
```

- Add the following statement to end of the session section:

```sh
session optional pam_gnome_keyring.so auto_start
```

- Add the following commands to ~/.bashrc:

```py
if [[ $- == *i* ]]; then  # Only run in interactive mode
  if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    exec dbus-run-session -- $SHELL
  fi

  gnome-keyring-daemon --start --components=secrets
fi
```

- Restart your computer:

```
sudo reboot
```

***NOTE:*** If trying to Configure Zowe CLI on operating systems where the Secure Credential Store is not available:

See this Link to guide you with Implementing: [https://docs.zowe.org/stable/user-guide/cli-configure-cli-on-os-where-scs-unavailable](https://docs.zowe.org/stable/user-guide/cli-configure-cli-on-os-where-scs-unavailable)

### Install Zowe CLI from npm
Follow this Link: [Install Zowe CLI from npm](https://docs.zowe.org/stable/user-guide/cli-installcli/#install-zowe-cli-from-npm)

Prerequisite notes:

```
sudo npm install -g prebuild-install
```

You will see a message like this:


***THIS IS JUST OUTPUT, NOT NOTE***

> ubuntu@ip-172-31-253-82:~/zowe$ sudo npm install -g prebuild-install
> /usr/bin/prebuild-install -> /usr/lib/node_modules/prebuild-install/bin.js + prebuild-install@7.1.1
> added 37 packages from 34 contributors in 2.307s

***NOW,*** Install @zowe/cli:

```
npm install -g @zowe/cli@zowe-v2-lts
```

***NOTE: If you face issues, then Do the Following:***

1. 
Change npm's default directory where global npm packages are installed.
This will prevent the need for elevated privileges when installing global packages.

Type thie 2 commands to your uubuntu terminal 

```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
```

2. 
Add .bashrc or .bash_profile file (located in your home directory) to ensure that the newly configured npm directory is in your PATH:

```bash
export PATH=~/.npm-global/bin:$PATH
```

If Zowe CLI is Installed, Get the Zowe Version:

```
zowe --version
```

***OPTIONALLY***: You can clear your cache with command:

```
npm cache clean --force
```

***NOW,*** Install the Zowe Plugin:

```
zowe plugins install @zowe/cics-for-zowe-cli@zowe-v2-lts @zowe/db2-for-zowe-cli@zowe-v2-lts @zowe/ims-for-zowe-cli@zowe-v2-lts @zowe/mq-for-zowe-cli@zowe-v2-lts @zowe/zos-ftp-for-zowe-cli@zowe-v2-lts
```

***NOOOOOOOOO!***: Only this plugin installed so far:

> Installed plugin name = '@zowe/cics-for-zowe-cli'
> _____ Validation results for plugin '@zowe/cics-for-zowe-cli' _____
> This plugin was successfully validated. Enjoy the plugin.


List the installed plugins:

```
zowe plugins list
```

## DOcker Implementation
- Build a Dockerfile

```Dockerfile
FROM ubuntu:latest # Use Ubuntu as the base image

ENV DEBIAN_FRONTEND=noninteractive   # Set environment variables

RUN apt-get update && apt-get install -y \    # Install required dependencies
    curl \
    nodejs \
    npm

RUN npm install -g @zowe/cli && \      # Install Zowe CLI and plugins
    zowe plugins install @zowe/cics-for-zowe-cli@zowe-v2-lts @zowe/db2-for-zowe-cli@zowe-v2-lts @zowe/ims-for-zowe-cli@zowe-v2-lts @zowe/mq-for-zowe-cli@zowe-v2-lts @zowe/zos-ftp-for-zowe-cli@zowe-v2-lts

CMD ["/bin/bash"]
```


- Build the Docker image, run the container

```
docker build -t cafanwi/zowe:1.0.0 .
docker run -it cafanwi/zowe:1.0.0
```

enter the shell:

```
docker run -it cafanwi/zowe:1.0.0
```

run test commands:

```
zowe --version
zowe plugins list
```