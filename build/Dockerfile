FROM maven:3.5.4-slim

# initial setup
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 14.17.6
RUN mkdir -p $NVM_DIR
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get install -y --no-install-recommends devscripts debhelper build-essential fakeroot git && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    npm install -g bower grunt && \
    echo '{ "allow_root": true }' > $HOME/.bowerrc

# data copy
#WORKDIR /projects
#COPY src/. /projects/.

COPY build/entrypoint.sh /
ENTRYPOINT ["/bin/bash" ,"/entrypoint.sh"]

# build mica2
#WORKDIR /projects/mica2
#RUN source $NVM_DIR/nvm.sh; \
#    mvn clean install && \
#    mvn -Prelease org.apache.maven.plugins:maven-antrun-plugin:run@make-deb
# results in /projects/mica2/mica-dist/target/mica2-*-dist.zip

# build mica-search-es
#WORKDIR /projects/mica-search-es
#RUN mvn clean install
# results in /projects/mica-search-es/target/mica-search-es-*-dist.zip
