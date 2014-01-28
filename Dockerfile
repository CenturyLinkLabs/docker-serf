FROM ubuntu:quantal
MAINTAINER Lucas Carlson <lucas@rufy.com>

# Let's install go in order to build serf
RUN apt-get update -q
RUN apt-get install -qy build-essential curl git supervisor
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /usr/local/
RUN mkdir -p /usr/local/src/github.com/hashicorp/
RUN git clone https://github.com/hashicorp/serf.git /usr/local/src/github.com/hashicorp/serf
RUN cd /usr/local/src/github.com/hashicorp/serf && git checkout v0.3.0 && make
RUN mv /usr/local/src/github.com/hashicorp/serf/serf /usr/bin/
ADD /start.sh /start.sh
ADD /run.sh /run.sh
ADD /supervisord-serf.conf /etc/supervisor/conf.d/supervisord-serf.conf
RUN chmod 755 /*.sh

EXPOSE 7946 7373
CMD ["/run.sh"]
