# ezmaster-webserver

[![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-webserver/)

Web Server for [ezmaster](https://github.com/Inist-CNRS/ezmaster)

## Prerequisites 

[ezmaster](https://github.com/Inist-CNRS/ezmaster) >= [3.8.0](https://github.com/Inist-CNRS/ezmaster#ezmaster-380)

## Usage

- Add the application in your [ezmaster](https://github.com/Inist-CNRS/ezmaster) ([inistcnrs/ezmaster-webserver:4.1.2](https://hub.docker.com/r/inistcnrs/ezmaster-webserver/tags/)) then create a new instance
- To configure your web server, have a look to nginx config:
  https://www.nginx.com/resources/wiki/start/topics/examples/full/
  - to disabled logs, just switch error_log and access_log lines with /dev/null
- To serve content, just upload your files into `/www`

* You can also configure a crontab thank to the JSON located at the end of the [config](https://github.com/Inist-CNRS/ezmaster-webserver/blob/master/nginx.conf#L60-L71). It looks like that:

  ```json
  {
    "when": "* * * * *",
    "commands": [
      "# exemple montrant comment mettre à jour automatiquement le contenu de /www depuis un dépôt git",
      "test -d /www/.git || (cd /www && git init && git remote add origin https://github.com/istex/istex.github.io)",
      "cd /www/ && git pull origin master"
    ],
    "options": {
      "silent": false
    }
  }
  ```

  * If your want to disable the crontab, just remove the `"commands"` content.
  * If you want to hide crontab logs, set `"silent"` to true

## Developer

To run stuff locally, just type:

```
make build
docker run -it --name ezmaster-webserver --rm -p 8080:80 inistcnrs/ezmaster-webserver:4.1.2
```

Then open your browser on http://localhost:8080
