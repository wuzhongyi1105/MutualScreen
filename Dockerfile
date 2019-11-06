FROM node:10.13-alpine

RUN apk upgrade --update \
 && apk add -t build-dependencies \
    build-base \
 && apk add \
    openssl \
    ca-certificates \
    git \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/* \
 && mkdir /opt/mutualscreen

COPY Server.js /opt/mutualscreen

WORKDIR /opt/mutualscreen

RUN npm install socket.io@1.4.5 \
 && npm install -g pm2

EXPOSE 8124

CMD pm2 /opt/mutualscreen/start /Server.js -i 0 && pm2 save && pm2 startup
