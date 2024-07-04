#!/bin/bash

hostnamectl set-hostname tomcat
cd /opt
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
yum install git wget -y
yum install java-1.8.0-openjdk-devel -y
# install wget unzip packages.
yum install wget unzip -y

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.zip
unzip apache-tomcat-9.0.89.zip
rm -rf apache-tomcat-9.0.89.zip
### rename tomcat for good naming convention
mv apache-tomcat-9.0.89 tomcat9
### assign executable permissions to the tomcat home directory
chmod 777 -R /opt/tomcat9
chown ec2-user -R /opt/tomcat9
### start tomcat
sh /opt/tomcat9/bin/startup.sh
# create a soft link to start and stop tomcat
# This will enable us to manage tomcat as a service
ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
starttomcat
#sudo su - tomcat
