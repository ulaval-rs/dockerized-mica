cd /projects/mica2
source $NVM_DIR/nvm.sh; \
    mvn clean install && \
    mvn -Prelease org.apache.maven.plugins:maven-antrun-plugin:run@make-deb

cd /projects/mica-search-es
mvn clean install
