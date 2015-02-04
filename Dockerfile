FROM debian:7.7
MAINTAINER Mhawila Mhawila <a.mhawila@gmail.com>

# Build: docker build -t hubzero .
# Run:   docker run -d -p 80:80 --name hubzero hubzero

COPY ./hubzerokey /opt/hubzerokey
RUN echo "hubexample.org" > /etc/hostname; \
  echo "127.0.0.1  hubexample.org hubexample" >> /etc/hosts; \
  echo "deb http://packages.hubzero.org/deb diego-deb7 main" >> /etc/apt/sources.list; \
  echo "deb http://download.openvz.org/debian wheezy main" >> /etc/apt/sources.list; \
  apt-get update; \
  apt-get install -y wget; \
  apt-key add /opt/hubzerokey; \
  wget http://ftp.openvz.org/debian/archive.key -q -O - | apt-key add - ;\
  apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install --yes \
      hubzero-mysql apache2; \
  service mysql start; \
  apt-get install -y hubzero-cms-1.3.0;\
  hzcms install example; a2dissite default default-ssl; a2ensite hubexample hubexample-ssl

EXPOSE -p 80
ADD ./run.sh /run.sh
CMD /run.sh
