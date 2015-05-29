FROM mono:3.10

MAINTAINER Jonathan Kovacs <jdk@jdk.ca>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC

RUN echo "deb http://apt.sonarr.tv/ master main" > sudo tee /etc/apt/sources.list.d/sonarr.list \
	&& apt-get update \
	&& apt-get install mediainfo nzbdrone \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN for i in /usr/lib/mono/*/mscorlib.dll; do mono --aot $i; done \ 
	&& for i in /usr/lib/mono/gac/*/*/*.dll; do mono --aot $i; done \
	&& mono --aot /opt/NzbDrone/NzbDrone.exe \
	&& for i in /opt/NzbDrone/*.dll; do mono --aot $i; done

RUN mkdir -p /volumes/config/sonarr \
	&& /volumes/completed \
	&& /volumes/media

COPY develop/start.sh /
RUN chmod +x /start.sh

COPY develop/sonarr-update.sh /
RUN chmod +x /sonarr-update.sh

WORKDIR /opt/NzbDrone

ENTRYPONT ["/start.sh"]

VOLUME /volumes/config
VOLUME /volumes/completed
VOLUME /volumes/media

EXPOSE 8989
EXPOSE 9898

