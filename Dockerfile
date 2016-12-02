FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    TERM=xterm
RUN locale-gen en_US en_US.UTF-8
RUN echo "export PS1='\e[1;31m\]\u@\h:\w\\$\[\e[0m\] '" >> /root/.bashrc
RUN echo "export PS1='\e[1;31m\]\u@\h:\w\\$\[\e[0m\] '" >> /etc/bash.bashrc
RUN apt-get update

# Runit
RUN apt-get install -y --no-install-recommends runit
CMD export > /etc/envvars && /usr/sbin/runsvdir-start
RUN echo 'export > /etc/envvars' >> /root/.bashrc

# Utilities
RUN apt-get install -y --no-install-recommends vim less net-tools inetutils-ping wget curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common jq psmisc iproute python ssh

#Node
RUN wget -O - https://nodejs.org/dist/v7.1.0/node-v7.1.0-linux-x64.tar.gz | tar xz
RUN mv node* node && \
    ln -s /node/bin/node /usr/local/bin/node && \
    ln -s /node/bin/npm /usr/local/bin/npm
ENV NODE_PATH=/usr/local/lib/node_modules PATH=$PATH:/node/bin

#Foundation Email
RUN npm install --global foundation-cli
RUN apt-get install -y bzip2
#Hack to allow root
RUN sed -i -e 's|isRoot()|false|' /node/lib/node_modules/foundation-cli/lib/commands/new.js 

#PhantomJS
RUN apt-get install -y libfontconfig1
RUN npm i -g phantomjs-prebuilt

# Add runit services
COPY sv /etc/service 
ARG BUILD_INFO
LABEL BUILD_INFO=$BUILD_INFO

