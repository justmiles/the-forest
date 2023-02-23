FROM ubuntu:18.04

# Insert Steam prompt answers
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

# Update the repository and install SteamCMD
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
    # update registry
    && apt-get update -y \
    # install dependencies
    && apt-get install -y --no-install-recommends ca-certificates locales steamcmd gnupg software-properties-common curl winbind xvfb \
    # Create symlink for executable
    && ln -s /usr/games/steamcmd /usr/bin/steamcmd \
    # Update SteamCMD and verify latest version
    && steamcmd +quit \
    # install envtemplate
    && curl -sfLo /usr/local/bin/envtemplate https://github.com/orls/envtemplate/releases/download/0.0.3/envtemplate \
    && chmod +x /usr/local/bin/envtemplate \
    # Add unicode support
    && locale-gen en_US.UTF-8 \
    # install wine
    && curl -fLo - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
    && apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ \
    && apt-get update \
    && apt-get install -y winehq-stable \
    # clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG 'en_US.UTF-8'
ENV LANGUAGE 'en_US:en'

COPY server.cfg /tmp/server.cfg
COPY entrypoint.sh /usr/bin/entrypoint.sh

# set defaults
ENV SERVER_IP=0.0.0.0 \
    SERVER_STEAM_PORT=8766 \
    SERVER_GAME_PORT=27015 \
    SERVER_QUERY_PORT=27016 \
    SERVER_NAME=the-forest \
    SERVER_PLAYERS=8 \
    ENABLE_VAC=off \
    SERVER_PASSWORD= \
    SERVER_PASSWORD_ADMIN= \
    SERVER_STEAM_ACCOUNT= \
    SERVER_AUTOSAVE_INTERVAL=30 \
    DIFFICULTY=Normal \
    INIT_TYPE=Continue \
    SLOT=1 \
    SHOW_LOGS=off \
    SERVER_CONTACT=email@gmail.com \
    VEGAN_MODE=off \
    VEGETARIAN_MODE=off \
    RESET_HOLES_MODE=off \
    TREE_REGROW_MODE=off \
    ALLOW_BUILDING_DESTRUCTION=on \
    ALLOW_ENEMIES_CREATIVE_MODE=off \
    ALLOW_CHEATS=off \
    REALISTIC_PLAYER_DAMAGE=off \
    SAVE_FOLDER_PATH= \
    TARGET_FPS_IDLE=0 \
    TARGET_FPS_ACTIVE=0 \
    UPDATE_SERVER=false

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

VOLUME ["/save", "/game"]
