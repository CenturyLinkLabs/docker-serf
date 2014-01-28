FROM ubuntu:quantal
MAINTAINER Lucas Carlson <lucas@rufy.com>

# Let's install go in order to build serf
RUN apt-get update -q
RUN apt-get install -qy build-essential git supervisor wget unzip
RUN wget https://dl.bintray.com/mitchellh/serf/0.3.0_linux_amd64.zip
RUN unzip 0.3.0_linux_amd64.zip
RUN mv serf /usr/bin/
ADD /start.sh /start.sh
ADD /run.sh /run.sh
ADD /supervisord-serf.conf /etc/supervisor/conf.d/supervisord-serf.conf
RUN chmod 755 /*.sh

EXPOSE 7946 7373
CMD ["/run.sh"]
