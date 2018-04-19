FROM ubuntu:14.04

LABEL maintainer Walter de Donato <dedonato@nm-2.com>

ENV ALIEN4CLOUD_VERSION=1.4.3.1 \
    PUCCINI_VERSION=1.4.3.1 \
    FASTCONNECT_REPOSITORY=opensource \
    INSTALL_DIR=/opt \
    DEBIAN_FRONTEND=noninteractive

# Accept Oracle license terms
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# Instal system dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common \
                       python-software-properties && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    apt-get install -y oracle-java8-installer \
                       curl && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Download, unpack and install alian4cloud components
RUN cd $INSTALL_DIR && \
    curl -k -o "alien4cloud-dist.tar.gz" \
         -L "http://fastconnect.org/maven/service/local/artifact/maven/redirect?r=$FASTCONNECT_REPOSITORY&g=alien4cloud&a=alien4cloud-dist&v=${ALIEN4CLOUD_VERSION}&p=tar.gz&c=dist" && \
    curl -k -o "puccini-cli.tgz" \
         -L "http://fastconnect.org/maven/service/local/artifact/maven/redirect?r=$FASTCONNECT_REPOSITORY&g=org.alien4cloud.puccini&a=puccini-cli&v=${PUCCINI_VERSION}&e=tgz" && \
    curl -k -o "alien4cloud-puccini-plugin-${PUCCINI_VERSION}.zip" \
         -L "http://fastconnect.org/maven/service/local/artifact/maven/redirect?r=$FASTCONNECT_REPOSITORY&g=alien4cloud&a=alien4cloud-puccini-plugin&v=${PUCCINI_VERSION}&e=zip" && \
    tar zxvf alien4cloud-dist.tar.gz && \
    rm alien4cloud-dist.tar.gz && \
    tar xvzf puccini-cli.tgz && \
    rm puccini-cli.tgz && \
    mv alien4cloud-puccini-plugin-${PUCCINI_VERSION}.zip alien4cloud/init/plugins/

ADD config /opt/alien4cloud/config
COPY startup.sh /

VOLUME /opt/alien4cloud-data
VOLUME /var/run/docker /var/run/docker.sock

WORKDIR /opt/alien4cloud

CMD /startup.sh $INSTALL_DIR $PUCCINI_VERSION

EXPOSE 8088

