FROM jenkins/jenkins:lts-jdk8

ARG jenkins_usr=admin
ARG jenkins_psswrd=admin
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_HOME=/var/jenkins_home
ENV JENKINS_USER ${jenkins_usr}
ENV JENKINS_PASS ${jenkins_psswrd}
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false


COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
USER root

RUN apt-get update \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update -qq  && \
    apt-get -y --no-install-recommends install docker-ce && \
    apt-get clean && \
    usermod -aG docker jenkins

RUN chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref
