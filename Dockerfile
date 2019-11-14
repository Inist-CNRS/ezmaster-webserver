FROM node:lts-alpine

RUN mkdir -p /app/data
WORKDIR /app

# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 8000, \
  "configPath": "/app/config.json", \
  "dataPath": "/app/data" \
}' > /etc/ezmaster.json

RUN npm init -y
RUN npm install local-web-server@3.0.7
RUN npm install node-schedule@1.3.1
RUN npm install shelljs@0.8.3

EXPOSE 8000
COPY config2vars /app
COPY crontab /app
COPY gitsync /app
COPY docker-entrypoint.sh /app
COPY ws.js /app
COPY config.json /app

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["--directory", "/app/data"]
