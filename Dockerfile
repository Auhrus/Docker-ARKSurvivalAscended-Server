FROM cm2network/steamcmd:root

LABEL org.opencontainers.image.source="https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server"
LABEL maintainer="https://github.com/Auhrus"

EXPOSE 7777-7777 27015-27015/udp

ENV startcommands="TheIsland_WP?listen -WinLiveMaxPlayers=5"
ENV updateonstart=false

RUN apt update && dpkg --add-architecture i386 && apt install software-properties-common apt-transport-https dirmngr ca-certificates -y

RUN curl -s http://repo.steampowered.com/steam/archive/stable/steam.gpg > /usr/share/keyrings/steam.gpg \
    && echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] http://repo.steampowered.com/steam/ stable steam" > /etc/apt/sources.list.d/steam.list

RUN apt update && apt install steam-launcher -y && apt clean

RUN mkdir -p "/home/steam/Steam/compatibilitytools.d" \
    && curl -o "GE-Proton.tar.gz" -sLOJ "$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | egrep .tar.gz)" \
    && tar -xvf "GE-Proton.tar.gz" -C "/home/steam/Steam/compatibilitytools.d"

RUN mkdir -p "/home/steam/Steam/steamapps/compatdata/2430930" \
    && mkdir -p "/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server/" \
    && cp /home/steam/Steam/compatibilitytools.d/GE-Proton*-*/files/share/default_pfx /home/steam/Steam/steamapps/compatdata/2430930 -r

COPY ./serverstart.sh /home/steam/serverstart.sh

RUN chmod +x /home/steam/serverstart.sh \
    && chown 1000:1000 -R /home/steam/Steam/steamapps/

USER steam
WORKDIR /home/steam/
CMD ["/home/steam/serverstart.sh"]