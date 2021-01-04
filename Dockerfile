FROM buildpack-deps:buster-curl

ENV GITBUCKET_VER=4.35.2 GITBUCKET_SUM=c7e94c76cb0e73e8488660fee794b3f3366bea2c7d155703bb71e9faedac61b2

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

