FROM nginx:1.13.3

# to help docker debugging
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install vim curl gnupg2 git cron

# nodejs installation used for startup scripts
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y build-essential nodejs

# install npm dependencies
RUN mkdir -p /app
WORKDIR /app
COPY ./package.json /app/package.json
RUN npm install

# crontab script
COPY ./crontab.js /app/crontab.js

# nginx config
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint-scripts-runner /bin/entrypoint-scripts-runner

# empty www content
RUN mkdir -p /www

# ezmasterization of webserver
# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 80, \
  "configPath": "/etc/nginx/nginx.conf", \
  "configType": "text", \
  "dataPath":   "/www" \
}' > /etc/ezmaster.json

EXPOSE 80
ENTRYPOINT ["npm", "start"]
