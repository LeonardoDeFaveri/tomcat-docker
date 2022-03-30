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

# Installs and configure emacs for root user
RUN apt install emacs -y
ADD emacs-conf /root/.emacs

# Enable ssh access to user remote with password remote
RUN apt install openssh-server -y
RUN useradd -m remote
RUN echo "remote:remote" | chpasswd
ADD emacs-conf /home/remote/.emacs

# Sets fancy PS1 for both root and remote user
RUN echo "PS1=\"\[\033[38;5;11m\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;172m\][\w]\[$(tput sgr0)\]\[\033[38;5;9m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]\"" >> /root/.bashrc
RUN echo "PS1=\"\[\033[38;5;11m\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;172m\][\w]\[$(tput sgr0)\]\[\033[38;5;9m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]\"" >> /home/remote/.bashrc

# Add alias for emacs to allow colorized themes
RUN echo "alias emacs='TERM=xterm-256color emacs -nw'" >> /root/.bashrc
RUN echo "alias emacs='TERM=xterm-256color emacs -nw'" >> /home/remote/.bashrc

# Creates a group called code and add both root and remote users to it
# This group will be used to grant access to directories holding user code
RUN groupadd code
RUN usermod -a -G code root
RUN usermod -a -G code remote

# Creates the folder in which every webapps should be placed
RUN mkdir /data
RUN chown -R root:code /data 
RUN chmod -R 755 /data

# Links /data folder into root and remote home folders
RUN ln -s /data /root/data
RUN ln -s /data /home/remote/data

# Makes root user bash to open on home folder


EXPOSE 8080 22

# Adds init script
ADD init.sh /root/.init.sh
RUN chmod +x /root/.init.sh

ENTRYPOINT ["/root/.init.sh"]
RUN echo "cd /root" >> /root/.bashrc
