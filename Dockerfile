FROM debian:stretch-slim
LABEL maintainer="lrdarknesss@yahoo.de"

#default environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV fahUser=Anonymous
ENV fahTeam=0
ENV fahGpu=true
ENV fahSmp=true

# download and install FAHClient
RUN cd /tmp &&\
    apt-get update && apt-get install --no-install-recommends -y wget adduser bzip2 &&\
    wget --no-check-certificate  -Ofahclient.deb https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/fahclient_7.5.1_amd64.deb &&\
	# echo -e '#!/bin/bash \nset -e \nexit 0;' > /var/lib/dpkg/info/fahclient.postinst &&\
    dpkg -i --force-depends fahclient.deb; exit 0

# expose port for webservice
EXPOSE 7396

# start folding
CMD FAHClient --user=${fahUser} --team=${fahTeam} --passkey=${fahPasskey} --gpu=${fahGpu} --smp=${fahSmp} --web-allow=0/0:7396  
