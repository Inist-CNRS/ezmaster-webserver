FROM node:6.10.3

# to have git in the shell
# (to be able to use it in the crontab stuff)
RUN apt-get update && apt-get install -y git

RUN mkdir -p /app && mkdir -p /www
WORKDIR /app

# install npm dependencies
WORKDIR /app
COPY ./package.json /app/package.json
RUN npm install && npm cache clean

COPY ./.local-web-server.json /app
COPY ./crontab.js /app

# ezmasterization of webserver
# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 4000, \
  "configPath": "/app/.local-web-server.json", \
  "dataPath":   "/www" \
}' > /etc/ezmaster.json

EXPOSE 4000
ENTRYPOINT ["npm", "run", "start-in-docker"]
