# System monitoring

Promtheus + Alertmanager + Grafana + Telegram-bot

##Usage

1. Specify hosts for monitoring in `./prometheus/config.yml`
2. Specify telegram chat_id in `./alertmanager/config.yml`
3. Specify telegram bot token in `./telegram-sender/config.yaml`
4. Run `docker-compose up`

Now grafana is available at host:3000, prometheus at host:9090

Default grafana credentials: admin / admin 

## Install on target machine
1. Run `./install-node-exporter.sh` script
2. Add machine in `./prometheus/config.yml` 
3. Rebuild prometheus container `docker-compose up -d --force-recreate --no-deps prometheus`