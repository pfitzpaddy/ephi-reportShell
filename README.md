![ephiPulse](https://github.com/pfitzpaddy/ephi-reportPulse/blob/master/assets/images/ephiPulse_120px.png)
# ephiPulse
Report. Validate. Protect.
> To ensure rapid detection of public health threats, a robust early warning, preparedness and recovery system is required. To achieve this mission, the Ethiopian Public Health Institute (EPHI) established a fully integrated, adaptable, all-hazards approach called the Public Health Emergency Management (PHEM) system, adopting International Health Regulations (2005). Emergency preparedness, early detection, response and recovery from public health emergencies can minimize economic and environmental impacts. Real-time data is the key to this success.


### Requirements

- Dropbox 93.x.x
- Vagrant v2.x.x
- VirtualBox v6.x.x

# Running ephiPulse

Steps

1. In the terminal, clone this repository and navigate into ``ephi-reportShell``

2. Type ``vagrant up`` to install Ubuntu LTS 16.0.4 and server configuration detailed in ``ephi-reportShell.sh``

3. Once installation is complete;

	3a. Navigate to [http://192.168.66.12:8080](http://192.168.66.12:8080/manager/html) and Tomcat8 is running!

	3b. Navigate to [http://192.168.66.12](http://192.168.66.12) and ephiPulse is running!

3. ``ssh`` into the machine to administrate

		$ vagrant ssh