# [ephiPulse]
> 
> Developer documentation for local project setup

### Requirements

- Dropbox 33.4.xx
- Vagrant v1.9.xx
- VirtualBox v5.1.xx

# Running ephiPulse

Steps

1. In the terminal, clone this repository and navigate into ``ephi-reportShell``

2. Type ``vagrant up`` to install Ubuntu LTS 16.0.4 and server configuration detailed in ``ephi-reportShell.sh``

3. Once installation is complete, ``ssh`` into the machine

		$ vagrant ssh
		
4. Within the server, navigate to the ``ephi-reportPulse`` repository

		$ cd /home/ubuntu/nginx/www/ephi-reportEngine
		
5. Start the Sails RestAPI application

		$ sudo sails lift

6. Navigate to [http://192.168.66.12:8080](http://192.168.66.12:8080) and Tomcat8 is running!

7. Navigate to [http://192.168.66.12](http://192.168.66.12) and ephiPulse is running!
