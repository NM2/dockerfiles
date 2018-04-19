# Alien4Cloud v1.4.3.1 with Puccini Orchestrator

## Assumptions

We assume Puccini will not orchestrate Docker containers, so we let it point to external Docker daemon (it fails to enable otherwise) 

## To build the image 

    docker build -t nm2srl/alien4cloud:1.4.3.1 .

## To run it in foreground

    docker run -i --rm --publish 8088:8088 --name alien4cloud \
           -v /var/run/docker:/var/run/docker \
           -v /var/run/docker.sock:/var/run/docker.sock
           nm2srl/alien4cloud:1.4.3.1

## To run it as a service
           
    docker run -i --rm --publish 8088:8088 --name alien4cloud \
           -v /var/run/docker:/var/run/docker \
           -v /var/run/docker.sock:/var/run/docker.sock
           nm2srl/alien4cloud:1.4.3.1

## Access to Web UI

Alien4Cloud should then be accessible on `http://[ip]:8088` (i.e. if on your local machine: [http://localhost:8088](http://localhost:8088)).
 
Username: `admin`
Password: `admin`

You probably then want to follow the [Alien4Cloud Getting Started section](https://alien4cloud.github.io/index.html#/documentation/1.4.0/getting_started/new_getting_started.html).

Data is stored in the volume path `/opt/alien4cloud-data`

## Detailed configuration

The following configuration files are in volume path `/opt/alien4cloud/config`
 
 - Alien4Cloud's main: alien4cloud-config.yml
 - Alien4Cloud logging: log4j.properties
 - Elasticsearch: elasticsearch.yml
 
For details on the logging, check out the [Alien4Cloud configuration section](https://alien4cloud.github.io/index.html#/documentation/1.4.0/admin_guide/installation_configuration.html).
