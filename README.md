![ephiPulse](https://github.com/pfitzpaddy/ephi-reportPulse/blob/master/assets/images/ephiPulse_120px.png)
# ephiPulse
Report. Validate. Protect.
> To ensure rapid detection of public health threats, a robust early warning, preparedness and recovery system is required. To achieve this mission, the Ethiopian Public Health Institute (EPHI) established a fully integrated, adaptable, all-hazards approach called the Public Health Emergency Management (PHEM) system, adopting International Health Regulations (2005). Emergency preparedness, early detection, response and recovery from public health emergencies can minimize economic and environmental impacts. Real-time data is the key to this success.


### Requirements

- Dropbox 93.x.x
- Vagrant v2.x.x
- VirtualBox v6.x.x
- git

# Running ephiPulse

Steps

1. In the terminal, clone this repository 

		$ git https://github.com/pfitzpaddy/ephi-reportShell.git
		
2. cd into the repository

		$ cd ephi-reportShell

3. Type ``vagrant up`` to install Ubuntu LTS 16.0.4 virtual box

	3a. Wait until ``ubuntu/xenial64`` downloads....

4. Once complete, ``ssh`` into the machine

		$ vagrant ssh

5. Run each command detailed in ``ephi-reportShell.sh`` to complete server configuration

6. Once configuration is complete, navigate to ``ephi-reportPulse`` and lift the sails app

		$ cd /home/ubuntu/nginx/www/ephi-reportPulse
		$ sudo sails lift
		
7. Installation is complete!

	7a. Navigate to [http://192.168.66.12:8080](http://192.168.66.12:8080/manager/html) and Tomcat8 is running!

	7b. Navigate to [http://192.168.66.12:8080/ODKAggregate](http://192.168.66.12:8080/ODKAggregate) and ODK Aggregate is running!
	
	7c. Navigate to [http://192.168.66.12](http://192.168.66.12) and ephiPulse is running!
	
