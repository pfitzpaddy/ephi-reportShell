![ephiPulse](https://github.com/pfitzpaddy/ephi-reportPulse/blob/master/assets/images/ephiPulse_120px.png)
# ephiPulse
Report. Validate. Protect.
> To ensure rapid detection of public health threats, a robust early warning, preparedness and recovery system is required. To achieve this mission, the Ethiopian Public Health Institute (EPHI) established a fully integrated, adaptable, all-hazards approach called the Public Health Emergency Management (PHEM) system, adopting International Health Regulations (2005). Emergency preparedness, early detection, response and recovery from public health emergencies can minimize economic and environmental impacts. Real-time data is the key to this success.


### Requirements

- git
- Dropbox v93.x.x
- Vagrant v2.x.x
- VirtualBox v6.x.x

# Running ephiPulse

Steps

1. On your local machine, create a project folder

		$ mkdir ephiPulse

2. On your local machine, create a ``data`` folder within your project folder (i.e. ``ephiPulse/data``). This is for mounting the shared drive between host machine and the Virtual Machine

		$ cd ephiPulse
		$ mkdir data
		
3. In the terminal, clone this repository 

		$ git https://github.com/pfitzpaddy/ephi-reportShell.git
		
4. cd into the repository

		$ cd ephi-reportShell

5. Type ``vagrant up`` to install Ubuntu LTS 16.0.4 virtual box

	5a. Wait until ``ubuntu/xenial64`` downloads....

6. Once complete, ``ssh`` into the machine

		$ vagrant ssh

7. Run each command detailed in ``ephi-reportShell.sh`` to complete server configuration

8. Once configuration is complete, navigate to ``ephi-reportPulse`` and lift the sails app

		$ cd /home/ubuntu/nginx/www/ephi-reportPulse
		$ sudo sails lift
		
9. Installation is complete!

	9a. Navigate to [http://192.168.66.12:8080](http://192.168.66.12:8080/manager/html) and Tomcat8 is running!

	9b. Navigate to [http://192.168.66.12:8080/ODKAggregate](http://192.168.66.12:8080/ODKAggregate) and ODK Aggregate is running!
	
	9c. Navigate to [http://192.168.66.12](http://192.168.66.12) and ephiPulse is running!
	
