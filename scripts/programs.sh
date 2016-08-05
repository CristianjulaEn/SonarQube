#bin/bash -eux

#accept the oracle license
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

#Add the WebUpd8 Team Personal Package Archive 
sudo apt-add-repository ppa:webupd8team/java

#update system packages
sudo apt-get update

#install Oracle Java 8 with the PPA installer
sudo apt-get install oracle-java8-installer

#set environment variables
sudo apt-get install oracle-java8-set-default

#install postgres database
sudo apt-get install -y postgresql

# get sonarqube
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.1.2.zip