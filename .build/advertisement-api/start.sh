#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

env=${APP_ENV:-local}

echo $env

if [[ "$env" = "local" ]]; then
    exec apache2-foreground
elif [[ "$env" = "dev" ]]; then
    exec apache2-foreground
#    exec apache2-foreground &
#    su www-data --shell /bin/bash --preserve-environment --command "php artisan queue:listen database --queue=default --delay=600 --timeout=300 --tries=5" &

#    while [[ true ]]
#    do
#      su www-data --shell /bin/bash --preserve-environment --command "php artisan schedule:run --no-interaction" &
#      sleep 60
#    done
elif [[ "$env" = "production" ]]; then
    exec apache2-foreground &
    supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
else
    echo "Could not match the container env \"$env\""
    exit 1
fi
