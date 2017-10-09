FROM nginx:1.13.3

# to help docker debugging
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install vim curl git gnupg2

# nodejs installation used for build tools
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y build-essential nodejs

# nginx config
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# demo www content
RUN mkdir -p /www && echo "ezmaster-webserver index.html example" > /www/index.html

# install npm dependencies
RUN mkdir -p /app
WORKDIR /app
COPY ./package.json /app/package.json
RUN npm install
COPY ./crontab.js /app

# ezmasterization of webserver
# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 80, \
  "configPath": "/etc/nginx/conf.d/default.conf", \
  "dataPath":   "/www" \
}' > /etc/ezmaster.json

EXPOSE 80
ENTRYPOINT ["npm", "run", "start-in-docker"]
