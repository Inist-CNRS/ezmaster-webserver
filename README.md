# ezmaster-webserver

[![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-webserver/)

Web Server for [ezmaster](https://github.com/Inist-CNRS/ezmaster)

## Prerequisites 

[ezmaster](https://github.com/Inist-CNRS/ezmaster) ⩾ [3.8.0](https://github.com/Inist-CNRS/ezmaster#ezmaster-380)

## Usage

- Add the application in your [ezmaster](https://github.com/Inist-CNRS/ezmaster) ([inistcnrs/ezmaster-webserver:4.1.2](https://hub.docker.com/r/inistcnrs/ezmaster-webserver/tags/)) then create a new instance
- To configure your web server, have a look to nginx config:
  https://www.nginx.com/resources/wiki/start/topics/examples/full/
  - to disabled logs, just switch error_log and access_log lines with /dev/null
- To serve content, just upload your files into `/www`

### Crontab feature

You can also configure a crontab thank to the config located at the end of the [config](https://github.com/Inist-CNRS/ezmaster-webserver/blob/master/nginx.conf#L60-L71). It looks like that:

  ```
### echo '{' > /app/crontab-config.json
### echo '  "when": "* * * * *",' >> /app/crontab-config.json
### echo '  "commands": [' >> /app/crontab-config.json
### echo '    "# exemple montrant comment mettre à jour automatiquement le contenu de /www depuis un dépôt git",' >> /app/crontab-config.json
### echo '    "#test -d /www/.git || (cd /www && git init && git remote add origin https://github.com/istex/istex.github.io)",' >> /app/crontab-config.json
### echo '    "#cd /www/ && git fetch --all && git reset --hard origin/master"' >> /app/crontab-config.json
### echo '  ],' >> /app/crontab-config.json
### echo '  "options":' >> /app/crontab-config.json
### echo '  {' >> /app/crontab-config.json
### echo '    "silent": false' >> /app/crontab-config.json
### echo '  }' >> /app/crontab-config.json
### echo '}' >> /app/crontab-config.json
```

Then to enable the crontab commands, just remove the # character in front of the commands: `#test -d /www/.git [...]` and `#cd /www/ && git fetch [...]`
These commands will run periodicaly git clone and git fetch in the www folder so that it's easy to have a uptodate website synchronized with a github repository.
If you want to hide crontab logs (in the ezmaster log), set `"silent"` to true

### Authentication feature

To enable autentication, just edit this line with the wanted login/password in the config:

```
### # use http://www.htaccesstools.com/htpasswd-generator/ to generate login/mdp
### echo 'admin:$apr1$H8V0oIUl$LnpG5bBnWF4fwoCR7evtr/' > /etc/nginx/.htpasswd
```

And uncomment these 2 lines in the config:

```
      # uncomment for authentication
      # see https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04
      #auth_basic "Restricted Content";
      #auth_basic_user_file /etc/nginx/.htpasswd;
```

## Developer

To run stuff locally, just type:

```
make build
docker run -it --name ezmaster-webserver --rm -p 8080:80 inistcnrs/ezmaster-webserver:4.1.2
```

Then open your browser on http://localhost:8080
