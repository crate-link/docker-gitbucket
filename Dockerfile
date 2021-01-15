FROM buildpack-deps:buster-curl

ENV GITBUCKET_VER=4.35.3 GITBUCKET_SUM=19cf2233f76171beda543fa11812365f409f807c07210ab83d57cb8252d66ebe

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

