FROM ubuntu

ENV TERM=xterm

# Install curl and net-stats for XAMPP 
RUN apt-get update && \
 apt install -yq curl net-tools psmisc

RUN apt install wget unzip -y
RUN apt install openjdk-11-jdk -y

ENV VERSION=9.0.60
RUN wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz -P /tmp
RUN mkdir -p /opt/tomcat
RUN tar -xf /tmp/apache-tomcat-${VERSION}.tar.gz -C /opt/tomcat/
RUN ln -s /opt/tomcat/apache-tomcat-${VERSION} /opt/tomcat/latest
RUN chmod +x /opt/tomcat/latest/bin/*.sh

ENV CATALINA_HOME=/opt/tomcat/latest
ENV CATALINA_BASE=/opt/tomcat/latest
ENV CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

RUN apt install emacs -y

ADD emacs-conf /root/.emacs

RUN echo "PS1=\"\[\033[38;5;11m\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;172m\][\w]\[$(tput sgr0)\]\[\033[38;5;9m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]\"" >> /root/.bashrc

EXPOSE 8080

ENTRYPOINT ["/bin/bash"]
