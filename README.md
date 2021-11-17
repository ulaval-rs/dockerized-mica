# Dockerized Environment for mica2
Tested with docker 20.10.8 build 3967b7d and compose 1.29.2, build 5becea4c

## Usage
### Clone the necessary repositories
* source `setup.sh` to download the mica source code

### Build mica
* source `build.sh` to run a docker container that will build the source code

### Run mica, mongo, opal and agate
* run `docker compose up` (or `docker-compose up` if you are using MacOS)

### Use the apps
* mica is at -> `localhost:8872`
* opal is at -> `localhost:8870` (default user is administrator:password)
* agate is at -> `localhost:8871` (default user is administrator:password)

### Configure the apps WIP
* TODO: `sudo chmod -R 777 config/*` until I figure out how to do this automatically
* go to agate's application config for mica [here](http://localhost:8871/admin#/application/mica/edit)
* click on "Generate Key", and copy it to agate.application.key in config/mica/conf/application.yml (replacing "changeit")

## How it works
This project clones ulaval-rs/mica2, builds it using a dockerized environment, then deploys it using a docker-compose file. When you execute setup.sh, mica2's and its search plugin sources are git pulled into the src/ folder. Then, when you run build.sh, the Dockerfile and entrypoint inside build/ are run, and the resulting zip builds copied from src/.../target/mica2...zip to the build/ folder. Finally, when you run docker-compose up, ./Dockerfile is executed, which fetches the built projects and deploy them locally. The compose file also runs opal, agate and a mongo instance. Those are pulled from docker hub.

Not that on the first run, mica's, opal's and agate's configs are created inside the config/ folder. There, you'll need to configure the apps to make them work with each other. While the compose file makes sure the hosts and ports are correct, there is still the step of linking mica and agate through agate's application key system.

On a sidenote, the gitignore is configured to ignore the src/ and build/ folders with the exception of the build/'s Dockerfile and entrypoint. This is because the build/ folder is created by the build.sh script, and the src/ folder is created by the setup.sh script.

## How to clean
* to clean the current configuration, delete all folders inside config/, docker compose down then docker compose up a new setup
* to rebuild, simply execute build.sh again

## Alternative build process (without docker)
Prerequisites:
```bash
sudo mkdir -p /root/.nvm
sudo apt-get update && \
    apt-get install -y --no-install-recommends devscripts debhelper build-essential fakeroot && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    source /root/.nvm/nvm.sh && \
    nvm install 14.17.6 && \
    npm install -g bower grunt && \
    echo '{ "allow_root": true }' > $HOME/.bowerrc
```
Build the project:
```bash
cd src/mica2
source $NVM_DIR/nvm.sh; \
    mvn clean install && \
    mvn -Prelease org.apache.maven.plugins:maven-antrun-plugin:run@make-deb

# optional if no need to rebuild it
cd ../../src/mica-search-es
mvn clean install
```
