#!/bin/bash
useradd --no-create-home --shell /bin/false node_exporter
# For the latest version of the package version please check here:
# https://github.com/prometheus/node_exporter/releases
wget wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar -xvzf node_exporter-1.0.1.linux-amd64.tar.gz
rm -f node_exporter-1.0.1.linux-amd64.tar.gz
cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-1.0.1.linux-amd64

touch /etc/systemd/system/node_exporter.service
echo '[Unit]' >> /etc/systemd/system/node_exporter.service
echo 'Description=Node Exporter' >> /etc/systemd/system/node_exporter.service
echo 'Wants=network-online.target' >> /etc/systemd/system/node_exporter.service
echo 'After=network-online.target' >> /etc/systemd/system/node_exporter.service

echo '[Service]' >> /etc/systemd/system/node_exporter.service
echo 'User=node_exporter' >> /etc/systemd/system/node_exporter.service
echo 'Group=node_exporter' >> /etc/systemd/system/node_exporter.service
echo 'Restart=on-failure' >> /etc/systemd/system/node_exporter.service
echo 'ExecStart=/usr/local/bin/node_exporter' >> /etc/systemd/system/node_exporter.service

echo '[Install]' >> /etc/systemd/system/node_exporter.service
echo 'WantedBy=default.target' >> /etc/systemd/system/node_exporter.service

systemctl daemon-reload && systemctl start node_exporter && systemctl enable node_exporter
systemctl status node_exporter

echo "try run this, to check node_exporter: curl 'localhost:9100/metrics'"