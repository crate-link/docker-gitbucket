FROM buildpack-deps:stretch-curl

ENV GITBUCKET_VER=4.31.2 GITBUCKET_SUM=31614cdecd23948fa420d992999d279bd696897ca24387c07d7a0dfa1540ef5f

RUN set -x \
  && cd /root \
  && curl -fsSLO "https://github.com/gitbucket/gitbucket/releases/download/${GITBUCKET_VER}/gitbucket.war" \
  && echo "${GITBUCKET_SUM}  gitbucket.war" | sha256sum -c -


FROM gcr.io/distroless/java:8

COPY --from=0 /root/gitbucket.war /root/gitbucket.war

EXPOSE 8080 8022

VOLUME /root/.gitbucket

WORKDIR /root

CMD [ "gitbucket.war" ]

