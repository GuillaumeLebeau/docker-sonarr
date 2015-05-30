FROM debian:wheezy

MAINTAINER Jonathan Kovacs <jdk@jdk.ca>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC

RUN echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr.list \
	&& apt-get update \
	&& apt-get install -y mediainfo nzbdrone \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mono --aot /opt/NzbDrone/NzbDrone.exe \
	&& for i in /opt/NzbDrone/*.dll; do mono --aot $i; done

RUN chown -R nobody /opt/NzbDrone \
	&& mkdir -p /data/config/sonarr /data/completed /data/media \
	&& chown -R nobody /data

COPY develop/start.sh /
RUN chmod +x /start.sh

COPY develop/sonarr-update.sh /
RUN chmod +x /sonarr-update.sh

USER nobody
WORKDIR /opt/NzbDrone

ENTRYPOINT ["/start.sh"]

VOLUME /data/config
VOLUME /data/completed
VOLUME /data/media

EXPOSE 8989
EXPOSE 9898

