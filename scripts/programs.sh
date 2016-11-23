#bin/bash -eux

#accept the oracle license
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

#Add the WebUpd8 Team Personal Package Archive 
sudo apt-add-repository ppa:webupd8team/java

#update system packages
sudo apt-get -y update
sudo apt-get -y install zip unzip wget


#install Oracle Java 8 with the PPA installer
sudo apt-get -y install oracle-java8-installer

#set environment variables
sudo apt-get -y install oracle-java8-set-default

#install postgres database
sudo apt-get -y install postgresql

# get sonarqube
echo "deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/" | sudo tee -a /etc/apt/sources.list.d/sonarqube.list > /dev/null
sudo apt-get -y update
sudo apt-get -y --force-yes install sonar

#start Sonar
sudo update-rc.d sonar start 20 3 4 5 
sudo service sonar start

# # scanner
# mkdir -p /etc/sonar-scanner && cd /etc/sonar-scanner
# wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.1.zip
# unzip sonar-scanner-2.6.1.zip

