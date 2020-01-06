FROM buildpack-deps:buster-curl

ENV GITBUCKET_VER=4.33.0 GITBUCKET_SUM=35e190ddb7a2f9760d43617d2e6325c2a745ba66061daa3fa95cc9d871423506

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

