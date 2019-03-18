FROM buildpack-deps:stretch-curl

ENV GITBUCKET_VER=4.31.1 GITBUCKET_SUM=37bd054e8fe5f1e72a40e252f2e8182d319da76574403edcbe345c43d6eccc44

RUN set -x \
  && cd /root \
  && curl -fsSLO "https://github.com/gitbucket/gitbucket/releases/download/${GITBUCKET_VER}/gitbucket.war" \
  && echo "${GITBUCKET_SUM}  gitbucket.war" | sha256sum -c -


FROM gcr.io/distroless/java:8

COPY --from=0 /root/gitbucket.war /home/gitbucket.war

EXPOSE 8080 8022

VOLUME /home/.gitbucket

WORKDIR /home

CMD [ "gitbucket.war" ]

