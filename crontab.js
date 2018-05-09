var schedule = require('node-schedule');
var shell    = require('shelljs');
var config   = require('./crontab-config.json');

var j = schedule.scheduleJob(config.when, runCrontabStuff);

function runCrontabStuff() {
  if (!config.options.silent) {
    console.log(new Date() + ' - ezmaster-webserver: running cron tasks');
  }
  config.commands.forEach(function (cmd) {
    if (!config.options.silent) {
      console.log(new Date() + ' - ezmaster-webserver: running ' + cmd);
    }
    shell.exec(cmd, {
      silent: config.options.silent,
      env: Object.assign(process.env, config.env)
    });
  });
}
runCrontabStuff();