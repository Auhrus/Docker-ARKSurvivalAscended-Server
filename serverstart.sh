#!/bin/bash
if [ ! -e "/home/steam/CONTAINER_ALREADY_STARTED_PLACEHOLDER" ]; then
    echo "***Downloading ARK Ascended Server"
    ./steamcmd.sh +force_install_dir "/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server" +login anonymous +app_update 2430930 +quit
    touch "/home/steam/CONTAINER_ALREADY_STARTED_PLACEHOLDER"
else
    echo "***Starting ARK Ascended Server"
	tail -F "/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server/ShooterGame/Saved/Logs/ShooterGame.log" &
    STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/steam/Steam/" STEAM_COMPAT_DATA_PATH="/home/steam/Steam/steamapps/compatdata/2430930" "/home/steam/Steam/compatibilitytools.d/GE-Proton8-21/proton" run "/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server\ShooterGame\Binaries\Win64\ArkAscendedServer.exe" $startcommands
fi
exit
