FROM obiba/docker-gosu:latest AS gosu
FROM openjdk:8-jdk-bullseye AS server

ENV MICA_ADMINISTRATOR_PASSWORD password
ENV MICA_ANONYMOUS_PASSWORD password
ENV MICA_HOME /srv
ENV MICA_DIST /usr/share/mica2
ENV DEFAULT_PLUGINS_DIR /opt/plugins
ENV JAVA_OPTS -Xmx2G

# mica setup
WORKDIR /tmp
COPY src/mica2/mica-dist/target/mica2-*-dist.zip .
RUN cd /usr/share/ && \
    unzip -q /tmp/mica2-*-dist.zip && \
    rm /tmp/mica2-*-dist.zip && \
    mv mica2-* mica2
RUN adduser --system --home $MICA_HOME --no-create-home --disabled-password -u 1000 mica

# plugins setup
WORKDIR $DEFAULT_PLUGINS_DIR
COPY src/mica-search-es/target/mica-search-es-*-dist.zip .

COPY --from=gosu /usr/local/bin/gosu /usr/local/bin/

# launch scripts
COPY /bin /opt/mica/bin
RUN chmod +x -R /opt/mica/bin; \
    chown -R mica /opt/mica; \
    chown -R mica /srv; \
    chmod -R 777 /srv; \
    chmod +x /usr/share/mica2/bin/mica2
WORKDIR $MICA_HOME

VOLUME $MICA_HOME
EXPOSE 8082 8445

USER mica

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/bin/bash" ,"/docker-entrypoint.sh"]
CMD ["app"]
