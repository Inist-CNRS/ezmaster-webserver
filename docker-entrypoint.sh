#!/bin/sh

cd /app

echo "Loading environnment variables..."
/app/config2vars > /app/config.env
chmod 755 /app/config.env
source /app/config.env

echo "Starting cron..."
/app/crontab &

sleep 2

echo "Starting web server..."
exec npx ws --config-file /app/ws.js $*
