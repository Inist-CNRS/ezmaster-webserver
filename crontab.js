var schedule = require('node-schedule');
var shell    = require('shelljs');
var config   = require('./.local-web-server.json');

var j = schedule.scheduleJob(config.crontab.when, runCrontabStuff);

function runCrontabStuff() {
  console.log('ezmaster-webserver: running cron tasks');
  config.crontab.commands.forEach(function (cmd) {
    console.log('ezmaster-webserver: running ' + cmd);
    shell.exec(cmd);
  });
}
runCrontabStuff();