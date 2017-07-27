var schedule = require('node-schedule');
var shell    = require('shelljs');
var config   = require('./.local-web-server.json');

var j = schedule.scheduleJob(config.crontab.when, runCrontabStuff);

function runCrontabStuff() {
  if (!config.crontab.options.silent) {
    console.log(new Date() + ' - ezmaster-webserver: running cron tasks');
  }
  config.crontab.commands.forEach(function (cmd) {
    if (!config.crontab.options.silent) {
      console.log(new Date() + ' - ezmaster-webserver: running ' + cmd);
    }
    shell.exec(cmd, { silent: config.crontab.options.silent });
  });
}
runCrontabStuff();