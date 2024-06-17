# Inception Project

The Inception project was an incredibly enriching experience for me, and I've decided to document my journey through it in the form of a comprehensive guide.  

The guide begins with the utilization of official Docker images sourced directly from Docker Hub. This initial step is crucial in gaining a fundamental understanding of how the system operates.  

Following this, I delve into the process of setting up each container manually. This involves creating custom Docker images based on Alpine Linux, a lightweight and security-oriented distribution. This hands-on approach provides a deeper insight into the inner workings of the system.  

## SETTING UP THE WORKING ENVIRONMENT WITH VM and VSCode

1. Setting up the VM.

If you are doing this project on the school's computers, you have to use VirtualBox to create a Virtual Machine (VM) with a LINUX OS of your choice since you don't have `sudo` rights on the school's computers. I personally used the latest version of Debian at the time, mostly because it is lighter than Ubuntu.  

If you choose Ubuntu, be aware that most likely you won't have enough space to download it on any of the school's computers `Download` folder, so you will have to download it to your `sgoinfre` instead.  

Creating a VM from the downloaded ISO image should not be a problem. Make sure to allocate around 30GB of space to the VM, and at least 2GB of RAM. **NOTE**: *VM image must be installed in `sgoinfre` folder as well.*  

Once the OS is installed and running, make sure to install the `ssh` server, so you can connect to the VM from your host/school machine.  

Dont forget to delete the installation ISO file once the OS is installed, to free up some space.  

2. Installing `ssh` server on the VM (Ubuntu).

```bash
sudo apt update

sudo apt upgrade

sudo apt install openssh-server
```

3. Enabling `ssh` server on the VM (Ubuntu).

```bash
sudo systemctl start ssh

sudo systemctl enable ssh
```

4. Setting up the network in the VM settings.

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
