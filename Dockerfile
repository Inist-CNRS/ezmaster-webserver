FROM node:argon

RUN mkdir -p /app && mkdir -p /www
WORKDIR /app

RUN npm install https://github.com/touv/local-web-server -g -q
RUN npm install supervisor@0.12 -g -q

COPY ./.local-web-server.json /app

# ezmasterization of webserver
# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 4000, \
  "configPath": "/app/.local-web-server.json", \
  "dataPath":   "/www" \
}' > /etc/ezmaster.json

EXPOSE 4000
ENTRYPOINT ["supervisor", "-x", "ws", "-e", "json", "-w", "/app", "--", "-d", "/www"]
