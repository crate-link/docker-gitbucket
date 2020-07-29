FROM buildpack-deps:buster-curl

ENV GITBUCKET_VER=4.34.0 GITBUCKET_SUM=00a8471b19f7e86b176976935309b9e754102562f121aac17a96cedcb5269073

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

