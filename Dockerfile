FROM buildpack-deps:buster-curl

ENV GITBUCKET_VER=4.32.0 GITBUCKET_SUM=8d05ea7654fdf87b86844bec56582a236e62ad18926ccbae85ed93cff451b2fd

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

