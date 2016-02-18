FROM ubuntu:14.04
MAINTAINER Rohith Basani <r.basani@bssn-software.eu>
ENV JIRA_VERSION 5.2.11
RUN mkdir ~/jirasetup
RUN apt-get update
#RUN apt-get upgrade -y
RUN apt-get install -y wget
WORKDIR /tmp
#response.varfile contains the options specified during the previous Jira installation. We use the same configuration for installing the current version automatically.
COPY response.varfile /tmp/
COPY startscript.sh /tmp/
RUN wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-${JIRA_VERSION}-x64.bin
RUN chmod a+x atlassian-jira-${JIRA_VERSION}-x64.bin
RUN mkdir /jira 
EXPOSE 8080
RUN /tmp/atlassian-jira-${JIRA_VERSION}-x64.bin -q -varfile response.varfile
RUN rm /tmp/atlassian-jira-${JIRA_VERSION}-x64.bin
RUN rm /tmp/response.varfile
ADD groovyrunner-2.1.15.jar /opt/atlassian/jira/WEB-INF/lib
ADD idalko-igrid-1.14.2.jar /opt/atlassian/jira/WEB-INF/lib
RUN chmod a+x /tmp/startscript.sh
#CMD /opt/atlassian/jira/bin/start-jira.sh -fg
CMD /tmp/startscript.sh -fg

