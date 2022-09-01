FROM jenkins/jenkins:lts-jdk8

USER root
RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
RUN apt-get update && \
    apt-get -y install docker-ce
RUN usermod -a -G docker jenkins

VOLUME ["/var/jenkins_home/logs", "/var/jenkins_home/cache"]
VOLUME ["/var/jenkins_home/jobs", "/var/jenkins_home/jenkins-jobs"]
VOLUME ["/var/jenkins_home/secrets"]
