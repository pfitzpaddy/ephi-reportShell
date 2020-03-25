# [ephiPulse]
> 
> Developer documentation for local project setup

### Requirements

- Dropbox 33.4.xx
- Vagrant v1.9.xx
- VirtualBox v5.1.xx

# Running ephiPulse

Once the VirtualBox is completed installation, you can access the configured ephiPulse Ubuntu LTS 16.0.4 Virtual Machine via the ``vagrant ssh`` command

Steps

1. Within the ``ephi-reportShell`` folder, ssh into machine

		$ vagrant ssh
		
2. Within the server, navigate to the ``ephi-reportEngine`` repository

		$ cd /home/ubuntu/nginx/www/ephi-reportEngine
		
3. Start the Sails RestAPI application

		$ sudo sails lift

4. Navigate to [http://192.168.66.12](http://192.168.66.12) and ephiPulse is running!
