#!/bin/bash
# Update the package list
apt-get update

# Install cloud-init
apt-get install -y cloud-init

# Install fontconfig and OpenJDK 17
apt-get install -y fontconfig openjdk-17-jre

wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install jenkins -y
systemctl enable jenkins
systemctl start jenkins

# configure autoupdate of jenkins url
echo "#!bin/bash\nsudo -u jenkins sed -i "/^  <jenkinsUrl>/c\  <jenkinsUrl>$(curl -s ifconfig.me):8080</jenkinsUrl>" /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml" | tee update_url.sh
chmod +x update_url.sh
echo "/home/ec2-user/update_url.sh" | sudo tee -a /etc/rc.local >/dev/null
chmod +x /etc/rc.d/rc.local
