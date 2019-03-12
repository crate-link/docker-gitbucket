FROM buildpack-deps:stretch-curl

ENV GITBUCKET_VER=4.30.1 GITBUCKET_SUM=52fb4f585fcdb3e98b106dc8e97479be05693c2d5829f234825be27dde490779

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

