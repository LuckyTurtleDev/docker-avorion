FROM debian:stable-slim AS fetcher

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update \
 && apt-get install -y curl lib32gcc-s1

# Add steam user
RUN useradd -m -u 1000 steam
USER steam

# Download and extract SteamCMD
RUN mkdir -p /home/steam/steamcmd \
 && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz -C /home/steam/steamcmd

# fetch server
RUN mkdir -p /home/steam/avorion-server \
 && /home/steam/steamcmd/steamcmd.sh \
                +login anonymous \
				+force_install_dir /home/steam/avorion-server \
				+app_update 565060 validate \
				+quit


FROM debian:stable-slim

LABEL org.opencontainers.image.url="https://gitlab.com/luckyturtledev/docker-avorionldx/container_registry"
LABEL org.opencontainers.image.title="Docker image for Avorion's dedicated server"
LABEL org.opencontainers.image.source="https://gitlab.com/LuckyTurtleDev/docker-avorion"

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update \
 && apt-get install -y ca-certificates

# Add steam user
RUN useradd -m -u 1000 steam
USER steam

# install server
RUN mkdir -p /home/steam/avorion-server
COPY --from=fetcher /home/steam/avorion-server /home/steam/avorion-server

# Ports required
EXPOSE 27000
EXPOSE 27000/udp
EXPOSE 27003
EXPOSE 27003/udp
EXPOSE 27020
EXPOSE 27021

CMD ["/home/steam/avorion-server/server.sh"]
