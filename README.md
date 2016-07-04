## SonarQube Server AMI Description and Requirements

This project contains Packer configuration (that is, a Packer file and scripts to be run) for an image that meets the requirements for installing a working SonarQube server on AWS

* The Packer configuration creates an Amazon Machine Image that meets the [technical specifications](http://docs.sonarqube.org/display/SONAR/Requirements) that would allow SonarQube to be installed. That is, the created VM contains:
  * The requisite hardware provisioned.
  * An appropriate JRE (Oracle JRE). The latest supported version
  * An appropriate SQL Server (PostgreSQL)

Runnig the packer file **sonar.json** can eventually run the SonarQube software.

* The AWS Cloud credentials are provided as environment variables. **Replace them with your own AWS credentials** 