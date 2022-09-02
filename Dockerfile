FROM jenkins/jenkins:lts-alpine-jdk8

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root

RUN apk update

RUN chown jenkins:jenkins -R /usr/share/jenkins && \
    chown jenkins:jenkins -R /var/jenkins_home

USER jenkins

VOLUME ["/var/jenkins_home/logs", "/var/jenkins_home/cache"]
VOLUME ["/var/jenkins_home/jobs", "/var/jenkins_home/jenkins-jobs"]
VOLUME ["/var/jenkins_home/secrets"]
