FROM cm2network/steamcmd:root

MAINTAINER "https://github.com/Auhrus"

LABEL org.opencontainers.image.source https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server
LABEL maintainer https://github.com/Auhrus

EXPOSE 7777-7777/udp
EXPOSE 8888-8888 27015-27015 27020-27020/tcp

ENV startcommands="TheIsland_WP?listen"


RUN apt update && dpkg --add-architecture i386 && apt install software-properties-common apt-transport-https dirmngr ca-certificates wget -y

RUN curl -s http://repo.steampowered.com/steam/archive/stable/steam.gpg > /usr/share/keyrings/steam.gpg \
	&& echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] http://repo.steampowered.com/steam/ stable steam" > /etc/apt/sources.list.d/steam.list

RUN apt update \
	&& apt install steam-launcher -y

RUN mkdir -p "/home/steam/Steam/compatibilitytools.d" \
	&& wget -O "GE-Proton.tar.gz" -P "/home/steam/Steam/compatibilitytools.d" "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton8-21/GE-Proton8-21.tar.gz" \
	&& tar -xvf "GE-Proton.tar.gz" -C "/home/steam/Steam/compatibilitytools.d"

RUN mkdir -p "/home/steam/Steam/steamapps/compatdata/2430930" \
	mkidir -p "/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server/ShooterGame/Saved/" \
	&& cp "/home/steam/Steam/compatibilitytools.d/GE-Proton8-21/files/share/default_pfx" "/home/steam/Steam/steamapps/compatdata/2430930" -r


COPY ./serverstart.sh /home/steam/serverstart.sh

RUN chmod +x /home/steam/serverstart.sh \
	&& chown 1000:1000 -R /home/steam/Steam/steamapps/

USER steam
CMD ["/home/steam/serverstart.sh"]
