# Inception Project

The Inception project was an incredibly enriching experience for me, and I've decided to document my journey through it in the form of a comprehensive guide.  

The guide begins with the utilization of official Docker images sourced directly from Docker Hub. This initial step is crucial in gaining a fundamental understanding of how the system operates.  

Following this, I delve into the process of setting up each container manually. This involves creating custom Docker images based on Alpine Linux, a lightweight and security-oriented distribution. This hands-on approach provides a deeper insight into the inner workings of the system.  
<br>

## SETTING UP THE WORKING ENVIRONMENT WITH VM and VSCode

<br>

### Setting up the VM.

If you are doing this project on the school's computers, you have to use VirtualBox to create a Virtual Machine (VM) with a LINUX OS of your choice since you don't have `sudo` rights on the school's computers. I personally used the latest version of Debian at the time, mostly because it is lighter than Ubuntu.  

If you choose Ubuntu, be aware that most likely you won't have enough space to download it on any of the school's computers `Download` folder, so you will have to download it to your `sgoinfre` instead.  

A better choice would be to use `Debian` for your VM, since it is lighter than Ubuntu and the `.iso` image is much smaller.  

here is the link to the download: (Installing Debian)[https://www.debian.org/distrib/netinst]  


Creating a VM from the downloaded ISO image should not be a problem. Make sure to allocate at least 10GB of space to the VM, and at least 2GB of `Base memory`, better 8. And about the same for CPU.  

**NOTE**: *VM image must be installed in `sgoinfre` folder as well.*  

Once the OS is installed and running, make sure to install the `ssh` server, so you can connect right away to the VM from your host/school machine.  

**NOTE**: 
- *`SSH` can be installed during the installation of `Debian` OS, so you don't have to do it later. On page `Software selection`, make sure to check the box for `SSH server`.*   
- *It is better to use your school username when installing the OS, so you can connect to the VM using the same username.* 
- *For the best experience you might want to clone the VM after its installation into `/tmp/` folder and work on the cloned version so you have the fastest possible VM on the school's computers. NOTE: that you would need to clone the VM every day you work on it, since the `/tmp/` folder is cleared every day.*   


#### Manual `ssh` setup on the VM:

```bash
sudo apt update

sudo apt upgrade

sudo apt install openssh-server

sudo systemctl start ssh

sudo systemctl enable ssh
```

<br> 

### Setting up the network in the VM settings.

In order to connect to the VM from your host/school machine, you have to set up the network on the VM.  

- Go to the VM settings, and in the `Network` tab on the `Adapter 1`.  

- Make sure the `Enable Network Adapter` is checked, and the `Attached to` is set to `NAT`.  

- Click on the `Advanced` button, and then on the `Port Forwarding` button.  

- On the new window, click on the `+` button on the top right corner to add a new rule.  

- Rule 1 >>  
Protocol: `TCP`  
Host IP: `127.0.0.1`  
Host Port: `1111`  
Guest IP: `10.0.2.15`  
Guest Port: `22`  

*NOTE*: *The `Host Port` can be any port you want (except the reserved numbers from 0 to 1024 and also 4242).*  
*Other fields should be as indicated.*

- Click `OK` on all windows to save the changes.  

<br> 

## Connecting to the VM from your host/school machine

Once the network is set up, you should be able to connect to the VM from your host/school machine using the following command:

```bash
ssh -p 1111 user@localhost
```

**NOTE**: *The `user` is the username you created when installing the OS on the VM.*  

*If you used your school username, you can connect to the VM using the following command:*  

```bash
ssh -p 1111 localhost
```
or 
```bash
ssh localhost -p 1111
```
<br>

## Installing Necessary Packages

Once connected from the host to the VM make sure the current user can run sudo commands.  

For that to happen first switch to `root` with:
```
su
```

and add your `user` to `/etc/sudoers` file with the following line:  
```
vi /etc/sudoers

...
'your_username'    ALL=(ALL:ALL) ALL

```
Save the file and exit.  
`exit` to exit the `root` user.

Then add the user to the `sudo` group:
```
sudo usermod -aG sudo $(whoami)
```


Install the necessary packages:

```bash
sudo apt install git make curl
```

Install `Docker` by following official documentation: (install docker on debian)[https://docs.docker.com/engine/install/debian/#install-using-the-repository]   

step 1 and 2 are enough.

Check if `Docker` is installed and running:

```bash
sudo systemctl status docker
```

Add the current user to the `docker` group:

```bash
sudo usermod -aG docker $(whoami)
```

..restart the terminal.  


Install `Docker Compose`:

```bash
‌sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
```


**That should be it for setting up the working environment for this project.**  
<br>

## Setting up the VSCode ssh connection to the VM.

In order to connect to the VM from VSCode, you have to install the `Remote - SSH` extension (look for `ssh` in the extensions tab, it should be the first one).  

After installing the extension, click on the green icon on the very bottom left corner of VSCode, and select `Remote-SSH: Connect to Host...`. Using the same command as above, you should be able to connect to the VM `ssh user@localhost -p 1111`.  

The very first time, you should see a new window with the `ssh` configuration file. Click on the `+` button on the top right corner to add a new configuration (you can just choose the first option). This is done only once.  

Then you can click on the green icon on the very bottom left corner of VSCode once more, and select `localhost` from the list. This should connect VSCode to the VM OS.  

That should be it for setting up the working environment for this project.  

If you are interested in following along with the guide I have created while doing this project, you can find it in this repo: [Docker Wordpress Nginx Setup](https://github.com/svvoii/Docker_WordPress_Nginx)

I strongly recommend undertaking each step individually. This segmented approach will allow for a more thorough comprehension of the setup process.

---
This project was submitted in January 2024 as a part of 42 Common Core curriculum.  
[sbocanci](https://github.com/svvoii)  
