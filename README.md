Avorion for Docker
==================


### Game Info

For some information about the game see https://www.avorion.net/

This is a docker image to create a dedicated server.


## Getting started
Starting the server 

* Create a `/data` directory, this will be mounted into the container.
* Change the owner of the `/data` directory to UID 1000
* Start the server to generate the configfiles.
* Stop the server.
* Edit the configfiles as you like.
* If necessary delete the galaxy (```alliances```,```factions```,```moddata```,```players```and```sectors``` folders)
* Start the server

> **Note: if you change ports in the config, you'll need to adjust the port mappings.**

Run the following to start the server.
```
docker run --name avorion -d -v `pwd`/data:/home/steam/.avorion/galaxies/avorion_galaxy -p 27000:27000 -p 27000:27000/udp -p 27003:27003 -p 27003:27003/udp -p 27020:27020 -p 27022:27022 lukas1818/avorion
```
or use docker-compose:
```
version: '3.3'
services:
    avorion-docker:
        image: lukas1818/avorion  
        container_name: avorion
        volumes:
            - './data:/home/steam/.avorion/galaxies/avorion_galaxy'
        ports:
            - '27000:27000'
            - '27000:27000/udp'
            - '27003:27003'
            - '27003:27003/udp'
            - '27020:27020'
            - '27022:27022'
        restart: unless-stopped
```

The server data will be saved locally on the host machine within the data folder. This allows you to bring the server down, and pull the new image when needed to do any updates.



## Contributing

See [CONTRIBUTING.md](https://gitlab.com/Lukas1818/docker-avorion/-/blob/master/CONTRIBUTING.md)


