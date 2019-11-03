FROM node:10.13-alpine

RUN apk upgrade --update \
 && apk add -t build-dependencies \
    build-base \
 && apk add \
    openssl \
    ca-certificates \
    git \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

COPY Server.js /opt/MutualScreen

WORKDIR /opt/MutualScreen

RUN npm install --save socket.io \
 && npm install -g pm2 \

EXPOSE 8124

CMD pm2 /opt/MutualScreen/start Server.js -i 0 && pm2 save && pm2 startup
