# Dockerized Environment for mica2

## Usage
### Clone the necessary repositories
* source `setup.sh` to download the mica source code

### Build mica
* source `build.sh` to run a docker container that will build the source code

### Run mica, mongo, opal and agate
* run `docker compose up` (or `docker-compose up` if you are using MacOS)

### Use the apps
mica is at -> `localhost:8872`
opal is at -> `localhost:8870` (default user is administrator:password)
agate is at -> `localhost:8871` (default user is administrator:password)

### Configure the apps WIP
* go to agate's application config for mica [here](http://localhost:8871/admin#/application/mica/edit)
* click on "Generate Key", and copy it to agate.application.key in config/mica/conf/application.yml (replacing "changeit")
