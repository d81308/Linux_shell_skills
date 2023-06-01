## start prometheus
# start prometheus server, and use config
cd /usr/local/Cellar/prometheus/2.44.0/bin
./prometheus --config.file=/usr/local/etc/prometheus.yml

# use google chrome
http://localhost:9090

## start grafana
#start grafana server, and use config
cd /usr/local/Cellar/grafana/9.5.2/bin
grafana-server --config=/usr/local/etc/grafana/grafana.ini --homepath /usr/local/share/grafana --packaging=brew cfg:default.paths.logs=/usr/local/var/log/grafana cfg:default.paths.data=/usr/local/var/lib/grafana cfg:default.paths.plugins=/usr/local/var/lib/grafana/plugins

#use google chrome
http://localhost:3000/
#default user and password:
  admin
  admin


