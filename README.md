# ARK Survival Ascended Docker Server 🦕

This image provides a ARK Survival Ascended server. After the first start it downloads the necessary files from the Steam servers. If there is an update to the server files, simply recreate the container without having to re-download/re-build the image. It will download everything again (just in new) and you can continue.
## Content🧾

* [Deployment👩‍💻](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server?tab=readme-ov-file#deployment)
* [IMPORTANT‼️](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server?tab=readme-ov-file#important%EF%B8%8F)
* [Environment Variables🔢](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server?tab=readme-ov-file#environment-variables)
* [Update⏫](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server?tab=readme-ov-file#update)
* [Support❤️](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server?tab=readme-ov-file#support%EF%B8%8F)

## Deployment👩‍💻

How to install this Docker Container

1. Install Docker on your Server. Here you can find a guide [[here]](https://duckduckgo.com/?t=ffab&q=How+to+install+Docker+on+Ubuntu)

Notice: Due to the fact that I can only upload Docker container images of up to 500MB on GitHub without paying anything and the image is 3.4GB in total, you will have to build the image yourself based on my files. It's not hard and explained below.

2. Run this command. This will retrieve the required files from the GitHub repository and create the image. (with Docker already installed)
```bash
docker build https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server.git#main -t ghcr.io/auhrus/ark-ascended-server:latest
```
3. After the process is complete, run this command.
```bash
docker run --name CONAINER_NAME -p 8888:8888/udp -p 27015:27015/udp -v VOLUME_NAME:/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server/ShooterGame/Saved ghcr.io/auhrus/ark-ascended-server:latest
```
Please replace all things written in CAPS.

3. After all data has been downloaded, the server will start and generates the save files etc.


## IMPORTANT‼️
-Make sure that the folder of the volumes for the configs and the saves have the owner and group 1000:1000.


## Environment Variables🔢

To run this project, you will need to set the following environment variables.

| Variable      | Function      | Default |
|:------------- |:-------------:|:-------------|
| `startcommands`       |Here you can add (if needed) additional commands to start the server.|TheIsland_WP?listen|
| `USER`       |(can be ignored) Defines which user is worked with.|steam|
| `HOMEDIR`       |(can be ignored) Defines where the Steam launcher is installed.|/home/steam|
| `STEAMCMDDIR`       |(can be ignored) Defines what the SteamCMD is installed in.|/home/steam/steamcmd|
| `PATH`       |(can be ignored) You can ignore this, it will be created automatically by the Ubuntu base.|/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin|

The server start command:
```bash
STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/steam/Steam/" STEAM_COMPAT_DATA_PATH="/home/steam/Steam/steamapps/compatdata/2430930" "/home/steam/Steam/compatibilitytools.d/GE-Proton8-21/proton" run "/home/steam/Steam/steamapps/common/ARK Survival Ascended Dedicated Server\ShooterGame\Binaries\Win64\ArkAscendedServer.exe" $startcommands
```


## Update⏫

How do i update my ASA Server to a newer Version?

1. First stop and remove the existing Container.
```bash
docker stop CONAINER_NAME && docker rm CONAINER_NAME
```
2. Then create him again like in the [Deployment👩‍💻](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server?tab=readme-ov-file#deployment) with the same Volumes.

## Support❤️

If you find any bugs have improvements for this Documentation or have any other suggestions/improvements, please post a bug report or feature suggestion in the 
[Issues Tab](https://github.com/Auhrus/Dockerized-ARKSurvivalAscended-Server/issues).
