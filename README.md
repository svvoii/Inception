# Inception Project

_This project is part of the Common Core curriculum at 42 School. It is designed to provide a comprehensive understanding of containerization using Docker, focusing on manual setup and configuration of Docker containers for each service separately._ 

_It is a comprehensive guide for setting up and working environment, which involves creating and managing Docker containers manually. It includes instructions for setting up a Virtual Machine (VM), configuring Docker, and connecting to the VM using VSCode._

---

## Overview

This project is a hands-on learning experience designed to teach the fundamentals of containerization using Docker. It solves the problem of understanding container orchestration by guiding users through the process of creating and managing custom Docker images and containers.  

- Target audience: Students and developers learning Docker and containerization.
- Key outcomes: A fully functional environment for containerized applications, including a VM setup, Docker installation, and container management.

---

## Features

- Step-by-step guide for setting up a Virtual Machine (VM) using VirtualBox.
- Manual configuration of Docker and Docker Compose on a Debian-based VM.
- SSH setup for seamless connection between the host machine and the VM.
- Integration with VSCode for remote development using the `Remote - SSH` extension.
- Comprehensive instructions for managing user permissions and installing necessary packages.

---

## Tech Stack

| **Category**   | **Technologies**                        |
|----------------|-----------------------------------------|
| Virtualization | VirtualBox                              |
| OS             | Debian Linux, Ubuntu Linux              |
| Deployment     | Docker, Docker Compose, Bash, Shell     |
| Dev Tools      | Git, Make, Curl, VSCode                 |

---


## Lessons Learned

This project has improved my skills in several areas, including:

- Setting up and configuring Virtual Machines for development.
- Installing and managing Docker and Docker Compose on Linux systems.
- Establishing SSH connections and integrating remote development environments with VSCode.
- Overcoming challenges related to resource constraints on school computers.
- Understanding the workings of Docker containers and images, including how to build custom images from scratch using Dockerfiles and bash scripts to automate the configuration of the containers.

---

## Try it out!

Follow these steps to set up the project working environment locally:

### Pre-requisites

- VirtualBox installed on your machine.
- Debian `.iso` image downloaded from [Debian Official Site](https://www.debian.org/distrib/netinst).
- VSCode with the `Remote - SSH` extension installed.

### Steps

1. **Create a Virtual Machine**:
- Allocate at least 10GB of disk space and 2GB of memory.
- Install Debian OS and enable the SSH server during installation.

2. **Configure the VM Network**:

To connect to the VM from your host or school machine, you need to configure the network settings on the VM:  
- Open the VM settings, and go to the Network tab.  
- Under Adapter 1, ensure that Enable Network Adapter is checked and Attached to is set to NAT.  
- Click Advanced, then click Port Forwarding.  
- In the Port Forwarding window, click the + icon (top right) to add a new rule.  

Configure the rule as follows:

```
Rule 1
Protocol:   TCP
Host IP:    127.0.0.1
Host Port:  1111
Guest IP:   10.0.2.15
Guest Port: 22
```

*Note:* 
*The Host Port can be any number above 1024, except for commonly used ports like 4242. All other fields should be set exactly as shown.*

#### SSH setup recommendations:

- `SSH` can be installed during the `Debian` OS installation, so you don’t need to install it manually later. On the `Software selection` page, make sure to check the box for `SSH server`.

- It is better to use your school username when installing the OS, so you can connect to the VM using the same username.  

- For the best experience you might want to clone the VM after its installation into `/tmp/` folder and work on the cloned version so you have the fastest possible VM on the school's computers. NOTE: that you would need to clone the VM every day you work on it, since the `/tmp/` folder is cleared every day.  

- Doing this on the workstation at 42, it’s recommended to use your school username during the OS installation. This allows you to connect to the VM using the same username later.  

- For optimal performance on school computers, consider cloning the VM into the `/tmp/` folder after installation and working on the cloned version. This setup provides the fastest experience. Otherwise, the Docker containers build slower.  
Note: The `/tmp/` folder is cleared daily, so you will need to save your progress and clone the VM again each day you plan to work on it.  


#### Manual `ssh` setup on the VM:

```bash
sudo apt update
sudo apt upgrade
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
```

3. **Connect to the VM**:
```bash
ssh -p 1111 user@localhost
```

Once connected from the host to the VM make sure the current user can run sudo commands.  
In case you are not able to run `sudo` commands, you need to add your user to the `sudoers` file.

switching to `root` with and `user_name` to `/etc/sudoers` file:
```bash
su

vi /etc/sudoers
```
in this file look for the line:
```bash
...
'your_username'    ALL=(ALL:ALL) ALL
```

type `exit` to quit the `root` user.

And add the user to the `sudo` group:
```bash
sudo usermod -aG sudo $(whoami)
```

4. **Install Necessary Packages:**
```bash
sudo apt update
sudo apt upgrade
sudo apt install git make curl
```

5. **Installing Docker**

Install `Docker` following the official [install docker on debian](https://docs.docker.com/engine/install/debian/#install-using-the-repository).  

to check if `docker` is installed correctly: 

```bash
sudo systemctl status docker
```

Add current user to the `docker` group to avoid using `sudo` with `docker` commands. Restart the terminal connection to apply changes:
```bash
sudo usermod -aG docker $(whoami)
```

6. **Install Docker Compose**

Install `Docker Compose` by following the official [install docker compose](https://docs.docker.com/compose/install/linux/) documentation.

or with the following command:
```bash
‌sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
```

#### Setting Up the VSCode SSH Connection to the VM

To connect to the VM from VSCode, follow these steps:

1.	Install the `Remote - SSH` extension
Open the Extensions tab in VSCode and search for ssh. The extension named `Remote - SSH` should appear first. Install it.

2.	Initiate the SSH connection
After installation, click the green icon in the bottom-left corner of VSCode and select `Remote-SSH: Connect to Host…`
Use the following command to connect to VM:  

```bash
ssh user@localhost -p 1111
```

3. Configure the SSH host (first time only)  
The first time you connect, a window will open displaying your SSH configuration file.
Click the `+` icon in the top right corner to add a new configuration. Or select the default (first) option.
This setup step is only needed once. (Make sure the username is correct in the configuration file.)  

4. Connect to the VM.  
After the configuration is saved, click the green icon again and select localhost from the host list. VSCode will then connect to VM’s OS.

That’s it! Your working environment should now be ready for this project.  


---

## Usage (Clone the repo and run the containers)

- Clone the repository and navigate to the project directory.
```bash
git clone
cd Docker_WordPress_Nginx
```

- Build and run the Docker containers using the provided `Makefile`:
```bash
make build
make up
```

This will start the containers and set up the environment for the project. You can access the application in your web browser at `http://localhost:8080`.

NOTE: The following folders are created in the home directory of the user on the machine where repo is cloned.  
```bash
mkdir -p /home/$(USER)/data/wordpress_data
mkdir -p /home/$(USER)/data/mariadb_data
```

- To stop the containers, use:
```bash
make down
```

- To remove the containers and volumes, use:
```bash
make clean
```

- To view the logs of the containers, use:
```bash
make logs
```

- To list all Docker images, containers, volumes, and networks, use:
```bash
make ls
```

- To access the WordPress admin panel, navigate to `http://localhost:8080/wp-admin` in the web browser.


## References

To see the full details of the project — including how each container was built from scratch using a `Dockerfile`, `docker-compose.yml`, and a `Makefile` for easy build and run commands, along with `nginx` configuration and custom `bash` scripts — visit the following repository: [Docker Wordpress Nginx Setup](https://github.com/svvoii/Docker_WordPress_Nginx).


For similar setup instructions to setup development environment for Wordpress with Nginx and MySQL, based on the official Docker images from Docker Hub (no customization needed), check out this repository: [Docker Wordpress Deveopment Setup](https://github.com/svvoii/Docker_WordPress_Site).  


## Author

[My GitHub](https://github.com/svvoii)  
[My LinkedIn](https://www.linkedin.com/in/bocancia/)  
[My Portfolio](https://sbocanci.me/)  

---
