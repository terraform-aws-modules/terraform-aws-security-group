locals {
  catalog = {
    activemq = {
      display_name = "ActiveMQ"
      ingress_rules = {
        activemq-amqp      = { from_port = 5671, to_port = 5671, ip_protocol = "tcp", description = "ActiveMQ AMQP" }
        activemq-mqtt      = { from_port = 8883, to_port = 8883, ip_protocol = "tcp", description = "ActiveMQ MQTT" }
        activemq-stomp     = { from_port = 61614, to_port = 61614, ip_protocol = "tcp", description = "ActiveMQ STOMP" }
        activemq-openwire  = { from_port = 61617, to_port = 61617, ip_protocol = "tcp", description = "ActiveMQ OpenWire" }
        activemq-websocket = { from_port = 61619, to_port = 61619, ip_protocol = "tcp", description = "ActiveMQ WebSocket" }
      }
    }

    alertmanager = {
      display_name = "Alertmanager"
      ingress_rules = {
        alertmanager         = { from_port = 9093, to_port = 9093, ip_protocol = "tcp", description = "Alert Manager" }
        alertmanager-cluster = { from_port = 9094, to_port = 9094, ip_protocol = "tcp", description = "Alert Manager Cluster" }
      }
    }

    carbon-relay = {
      display_name = "Carbon Relay"
      ingress_rules = {
        carbon-line-in-tcp    = { from_port = 2003, to_port = 2003, ip_protocol = "tcp", description = "Carbon line-in" }
        carbon-line-in-udp    = { from_port = 2003, to_port = 2003, ip_protocol = "udp", description = "Carbon line-in" }
        carbon-serializer-tcp = { from_port = 2013, to_port = 2013, ip_protocol = "tcp", description = "Carbon serializer protocol" }
        carbon-serializer-udp = { from_port = 2013, to_port = 2013, ip_protocol = "udp", description = "Carbon serializer protocol" }
        carbon-admin          = { from_port = 2004, to_port = 2004, ip_protocol = "tcp", description = "Carbon admin" }
        carbon-gui            = { from_port = 8081, to_port = 8081, ip_protocol = "tcp", description = "Carbon GUI" }
      }
    }

    cassandra = {
      display_name = "Cassandra"
      ingress_rules = {
        cassandra-clients        = { from_port = 9042, to_port = 9042, ip_protocol = "tcp", description = "Cassandra clients" }
        cassandra-thrift-clients = { from_port = 9160, to_port = 9160, ip_protocol = "tcp", description = "Cassandra Thrift clients" }
        cassandra-jmx            = { from_port = 7199, to_port = 7199, ip_protocol = "tcp", description = "JMX" }
        cassandra-gossip         = { from_port = 7000, to_port = 7000, ip_protocol = "tcp", description = "Cassandra inter-node cluster gossip" }
        cassandra-gossip-tls     = { from_port = 7001, to_port = 7001, ip_protocol = "tcp", description = "Cassandra inter-node cluster gossip (TLS)" }
      }
    }

    consul = {
      display_name = "Consul"
      ingress_rules = {
        consul-server       = { from_port = 8300, to_port = 8300, ip_protocol = "tcp", description = "Consul server" }
        consul-grpc         = { from_port = 8502, to_port = 8502, ip_protocol = "tcp", description = "Consul gRPC" }
        consul-grpc-tls     = { from_port = 8503, to_port = 8503, ip_protocol = "tcp", description = "Consul gRPC TLS" }
        consul-webui-http   = { from_port = 8500, to_port = 8500, ip_protocol = "tcp", description = "Consul web UI HTTP" }
        consul-webui-https  = { from_port = 8501, to_port = 8501, ip_protocol = "tcp", description = "Consul web UI HTTPS" }
        consul-dns-tcp      = { from_port = 8600, to_port = 8600, ip_protocol = "tcp", description = "Consul DNS" }
        consul-dns-udp      = { from_port = 8600, to_port = 8600, ip_protocol = "udp", description = "Consul DNS" }
        consul-serf-lan-tcp = { from_port = 8301, to_port = 8301, ip_protocol = "tcp", description = "Serf LAN" }
        consul-serf-lan-udp = { from_port = 8301, to_port = 8301, ip_protocol = "udp", description = "Serf LAN" }
        consul-serf-wan-tcp = { from_port = 8302, to_port = 8302, ip_protocol = "tcp", description = "Serf WAN" }
        consul-serf-wan-udp = { from_port = 8302, to_port = 8302, ip_protocol = "udp", description = "Serf WAN" }
      }
    }

    docker-swarm = {
      display_name = "Docker Swarm"
      ingress_rules = {
        docker-swarm-management = { from_port = 2377, to_port = 2377, ip_protocol = "tcp", description = "Docker Swarm cluster management" }
        docker-swarm-node-tcp   = { from_port = 7946, to_port = 7946, ip_protocol = "tcp", description = "Docker Swarm node" }
        docker-swarm-node-udp   = { from_port = 7946, to_port = 7946, ip_protocol = "udp", description = "Docker Swarm node" }
        docker-swarm-overlay    = { from_port = 4789, to_port = 4789, ip_protocol = "udp", description = "Docker Swarm Overlay Network Traffic" }
      }
    }

    dynamodb-dax = {
      display_name = "DynamoDB DAX"
      ingress_rules = {
        dax-unencrypted = { from_port = 8111, to_port = 8111, ip_protocol = "tcp", description = "DAX Cluster unencrypted" }
        dax-encrypted   = { from_port = 9111, to_port = 9111, ip_protocol = "tcp", description = "DAX Cluster encrypted" }
      }
    }

    elasticsearch = {
      display_name = "Elasticsearch"
      ingress_rules = {
        elasticsearch-rest = { from_port = 9200, to_port = 9200, ip_protocol = "tcp", description = "Elasticsearch REST interface" }
        elasticsearch-java = { from_port = 9300, to_port = 9300, ip_protocol = "tcp", description = "Elasticsearch Java interface" }
      }
    }

    etcd = {
      display_name = "etcd"
      ingress_rules = {
        etcd-client = { from_port = 2379, to_port = 2379, ip_protocol = "tcp", description = "Etcd Client" }
        etcd-peer   = { from_port = 2380, to_port = 2380, ip_protocol = "tcp", description = "Etcd Peer" }
      }
    }

    grafana = {
      display_name = "Grafana"
      ingress_rules = {
        grafana = { from_port = 3000, to_port = 3000, ip_protocol = "tcp", description = "Grafana Dashboard" }
      }
    }

    graphite-statsd = {
      display_name = "Graphite/StatsD"
      ingress_rules = {
        graphite-webui                 = { from_port = 80, to_port = 80, ip_protocol = "tcp", description = "Graphite admin interface" }
        graphite-receiver-plaintext    = { from_port = 2003, to_port = 2003, ip_protocol = "tcp", description = "Carbon receiver plain text" }
        graphite-receiver-serializer   = { from_port = 2004, to_port = 2004, ip_protocol = "tcp", description = "Carbon receiver serializer" }
        graphite-aggregator-plaintext  = { from_port = 2023, to_port = 2023, ip_protocol = "tcp", description = "Carbon aggregator plaintext" }
        graphite-aggregator-serializer = { from_port = 2024, to_port = 2024, ip_protocol = "tcp", description = "Carbon aggregator serializer" }
        graphite-gunicorn              = { from_port = 8080, to_port = 8080, ip_protocol = "tcp", description = "Graphite gunicorn port" }
        graphite-statsd-tcp            = { from_port = 8125, to_port = 8125, ip_protocol = "tcp", description = "Statsd TCP" }
        graphite-statsd-udp            = { from_port = 8125, to_port = 8125, ip_protocol = "udp", description = "Statsd UDP default" }
        graphite-statsd-admin          = { from_port = 8126, to_port = 8126, ip_protocol = "tcp", description = "Statsd admin" }
      }
    }

    http-80 = {
      display_name = "HTTP (port 80)"
      ingress_rules = {
        http-80 = { from_port = 80, to_port = 80, ip_protocol = "tcp", description = "HTTP" }
      }
    }

    http-8080 = {
      display_name = "HTTP (port 8080)"
      ingress_rules = {
        http-8080 = { from_port = 8080, to_port = 8080, ip_protocol = "tcp", description = "HTTP" }
      }
    }

    https-443 = {
      display_name = "HTTPS (port 443)"
      ingress_rules = {
        https-443 = { from_port = 443, to_port = 443, ip_protocol = "tcp", description = "HTTPS" }
      }
    }

    https-8443 = {
      display_name = "HTTPS (port 8443)"
      ingress_rules = {
        https-8443 = { from_port = 8443, to_port = 8443, ip_protocol = "tcp", description = "HTTPS" }
      }
    }

    ipsec-500 = {
      display_name = "IPsec (port 500)"
      ingress_rules = {
        ipsec-500 = { from_port = 500, to_port = 500, ip_protocol = "udp", description = "IPSEC ISAKMP" }
      }
    }

    ipsec-4500 = {
      display_name = "IPsec (port 4500)"
      ingress_rules = {
        ipsec-4500 = { from_port = 4500, to_port = 4500, ip_protocol = "udp", description = "IPSEC NAT-T" }
      }
    }

    jmx = {
      display_name = "JMX"
      ingress_rules = {
        jmx = { from_port = 1099, to_port = 1099, ip_protocol = "tcp", description = "JMX" }
      }
    }

    kafka = {
      display_name = "Kafka"
      ingress_rules = {
        kafka-broker                   = { from_port = 9092, to_port = 9092, ip_protocol = "tcp", description = "Kafka PLAINTEXT broker" }
        kafka-broker-tls               = { from_port = 9094, to_port = 9094, ip_protocol = "tcp", description = "Kafka TLS broker" }
        kafka-broker-tls-public        = { from_port = 9194, to_port = 9194, ip_protocol = "tcp", description = "Kafka TLS public broker (MSK)" }
        kafka-broker-sasl-scram        = { from_port = 9096, to_port = 9096, ip_protocol = "tcp", description = "Kafka SASL/SCRAM broker (MSK)" }
        kafka-broker-sasl-scram-public = { from_port = 9196, to_port = 9196, ip_protocol = "tcp", description = "Kafka SASL/SCRAM public broker (MSK)" }
        kafka-broker-sasl-iam          = { from_port = 9098, to_port = 9098, ip_protocol = "tcp", description = "Kafka SASL/IAM broker (MSK)" }
        kafka-broker-sasl-iam-public   = { from_port = 9198, to_port = 9198, ip_protocol = "tcp", description = "Kafka SASL/IAM public broker (MSK)" }
        kafka-jmx-exporter             = { from_port = 11001, to_port = 11001, ip_protocol = "tcp", description = "Kafka JMX Exporter" }
        kafka-node-exporter            = { from_port = 11002, to_port = 11002, ip_protocol = "tcp", description = "Kafka Node Exporter" }
      }
    }

    kibana = {
      display_name = "Kibana"
      ingress_rules = {
        kibana = { from_port = 5601, to_port = 5601, ip_protocol = "tcp", description = "Kibana Web Interface" }
      }
    }

    ldap = {
      display_name = "LDAP"
      ingress_rules = {
        ldap = { from_port = 389, to_port = 389, ip_protocol = "tcp", description = "LDAP" }
      }
    }

    ldaps = {
      display_name = "LDAPS"
      ingress_rules = {
        ldaps = { from_port = 636, to_port = 636, ip_protocol = "tcp", description = "LDAPS" }
      }
    }

    logstash = {
      display_name = "Logstash"
      ingress_rules = {
        logstash = { from_port = 5044, to_port = 5044, ip_protocol = "tcp", description = "Logstash" }
      }
    }

    loki = {
      display_name = "Loki"
      ingress_rules = {
        loki      = { from_port = 3100, to_port = 3100, ip_protocol = "tcp", description = "Grafana Loki endpoint" }
        loki-grpc = { from_port = 9095, to_port = 9095, ip_protocol = "tcp", description = "Grafana Loki gRPC" }
      }
    }

    memcached = {
      display_name = "Memcached"
      ingress_rules = {
        memcached = { from_port = 11211, to_port = 11211, ip_protocol = "tcp", description = "Memcached" }
      }
    }

    minio = {
      display_name = "MinIO"
      ingress_rules = {
        minio = { from_port = 9000, to_port = 9000, ip_protocol = "tcp", description = "MinIO" }
      }
    }

    mongodb = {
      display_name = "MongoDB"
      ingress_rules = {
        mongodb               = { from_port = 27017, to_port = 27017, ip_protocol = "tcp", description = "MongoDB" }
        mongodb-shard         = { from_port = 27018, to_port = 27018, ip_protocol = "tcp", description = "MongoDB shard" }
        mongodb-config-server = { from_port = 27019, to_port = 27019, ip_protocol = "tcp", description = "MongoDB config server" }
      }
    }

    mssql = {
      display_name = "MSSQL"
      ingress_rules = {
        mssql-server    = { from_port = 1433, to_port = 1433, ip_protocol = "tcp", description = "MSSQL Server" }
        mssql-browser   = { from_port = 1434, to_port = 1434, ip_protocol = "udp", description = "MSSQL Browser" }
        mssql-analytics = { from_port = 2383, to_port = 2383, ip_protocol = "tcp", description = "MSSQL Analytics" }
        mssql-broker    = { from_port = 4022, to_port = 4022, ip_protocol = "tcp", description = "MSSQL Broker" }
      }
    }

    mysql = {
      display_name = "MySQL"
      ingress_rules = {
        mysql = { from_port = 3306, to_port = 3306, ip_protocol = "tcp", description = "MySQL/Aurora" }
      }
    }

    nfs = {
      display_name = "NFS"
      ingress_rules = {
        nfs = { from_port = 2049, to_port = 2049, ip_protocol = "tcp", description = "NFS/EFS" }
      }
    }

    nomad = {
      display_name = "Nomad"
      ingress_rules = {
        nomad-http     = { from_port = 4646, to_port = 4646, ip_protocol = "tcp", description = "Nomad HTTP" }
        nomad-rpc      = { from_port = 4647, to_port = 4647, ip_protocol = "tcp", description = "Nomad RPC" }
        nomad-serf-tcp = { from_port = 4648, to_port = 4648, ip_protocol = "tcp", description = "Nomad Serf" }
        nomad-serf-udp = { from_port = 4648, to_port = 4648, ip_protocol = "udp", description = "Nomad Serf" }
      }
    }

    ntp = {
      display_name = "NTP"
      ingress_rules = {
        ntp = { from_port = 123, to_port = 123, ip_protocol = "udp", description = "NTP" }
      }
    }

    openvpn = {
      display_name = "OpenVPN"
      ingress_rules = {
        openvpn-udp   = { from_port = 1194, to_port = 1194, ip_protocol = "udp", description = "OpenVPN" }
        openvpn-tcp   = { from_port = 943, to_port = 943, ip_protocol = "tcp", description = "OpenVPN" }
        openvpn-https = { from_port = 443, to_port = 443, ip_protocol = "tcp", description = "OpenVPN HTTPS" }
      }
    }

    oracle = {
      display_name = "Oracle"
      ingress_rules = {
        oracle = { from_port = 1521, to_port = 1521, ip_protocol = "tcp", description = "Oracle" }
      }
    }

    postgresql = {
      display_name = "PostgreSQL"
      ingress_rules = {
        postgresql = { from_port = 5432, to_port = 5432, ip_protocol = "tcp", description = "PostgreSQL" }
      }
    }

    prometheus = {
      display_name = "Prometheus"
      ingress_rules = {
        prometheus               = { from_port = 9090, to_port = 9090, ip_protocol = "tcp", description = "Prometheus" }
        prometheus-pushgateway   = { from_port = 9091, to_port = 9091, ip_protocol = "tcp", description = "Prometheus Pushgateway" }
        prometheus-node-exporter = { from_port = 9100, to_port = 9100, ip_protocol = "tcp", description = "Prometheus Node Exporter" }
      }
    }

    promtail = {
      display_name = "Promtail"
      ingress_rules = {
        promtail = { from_port = 9080, to_port = 9080, ip_protocol = "tcp", description = "Promtail endpoint" }
      }
    }

    puppet = {
      display_name = "Puppet"
      ingress_rules = {
        puppet   = { from_port = 8140, to_port = 8140, ip_protocol = "tcp", description = "Puppet" }
        puppetdb = { from_port = 8081, to_port = 8081, ip_protocol = "tcp", description = "PuppetDB" }
      }
    }

    rabbitmq = {
      display_name = "RabbitMQ"
      ingress_rules = {
        rabbitmq-epmd           = { from_port = 4369, to_port = 4369, ip_protocol = "tcp", description = "RabbitMQ epmd" }
        rabbitmq-amqp-tls       = { from_port = 5671, to_port = 5671, ip_protocol = "tcp", description = "RabbitMQ AMQP TLS" }
        rabbitmq-amqp           = { from_port = 5672, to_port = 5672, ip_protocol = "tcp", description = "RabbitMQ AMQP" }
        rabbitmq-management-tls = { from_port = 15671, to_port = 15671, ip_protocol = "tcp", description = "RabbitMQ management TLS" }
        rabbitmq-management     = { from_port = 15672, to_port = 15672, ip_protocol = "tcp", description = "RabbitMQ management" }
        rabbitmq-internode      = { from_port = 25672, to_port = 25672, ip_protocol = "tcp", description = "RabbitMQ internode/CLI" }
      }
    }

    rdp = {
      display_name = "RDP"
      ingress_rules = {
        rdp-tcp = { from_port = 3389, to_port = 3389, ip_protocol = "tcp", description = "Remote desktop protocol" }
        rdp-udp = { from_port = 3389, to_port = 3389, ip_protocol = "udp", description = "Remote desktop protocol" }
      }
    }

    redis = {
      display_name = "Redis"
      ingress_rules = {
        redis = { from_port = 6379, to_port = 6379, ip_protocol = "tcp", description = "Redis" }
      }
    }

    redshift = {
      display_name = "Redshift"
      ingress_rules = {
        redshift = { from_port = 5439, to_port = 5439, ip_protocol = "tcp", description = "Redshift" }
      }
    }

    saltstack = {
      display_name = "SaltStack"
      ingress_rules = {
        saltstack = { from_port = 4505, to_port = 4506, ip_protocol = "tcp", description = "SaltStack" }
      }
    }

    solr = {
      display_name = "Solr"
      ingress_rules = {
        solr = { from_port = 8983, to_port = 8987, ip_protocol = "tcp", description = "Solr" }
      }
    }

    splunk = {
      display_name = "Splunk"
      ingress_rules = {
        splunk-web     = { from_port = 8000, to_port = 8000, ip_protocol = "tcp", description = "Splunk Web" }
        splunk-hec     = { from_port = 8088, to_port = 8088, ip_protocol = "tcp", description = "Splunk HEC" }
        splunk-splunkd = { from_port = 8089, to_port = 8089, ip_protocol = "tcp", description = "Splunkd" }
        splunk-indexer = { from_port = 9997, to_port = 9997, ip_protocol = "tcp", description = "Splunk indexer" }
      }
    }

    squid = {
      display_name = "Squid"
      ingress_rules = {
        squid = { from_port = 3128, to_port = 3128, ip_protocol = "tcp", description = "Squid default proxy" }
      }
    }

    ssh = {
      display_name = "SSH"
      ingress_rules = {
        ssh = { from_port = 22, to_port = 22, ip_protocol = "tcp", description = "SSH" }
      }
    }

    storm = {
      display_name = "Storm"
      ingress_rules = {
        storm-nimbus     = { from_port = 6627, to_port = 6627, ip_protocol = "tcp", description = "Nimbus" }
        storm-ui         = { from_port = 8080, to_port = 8080, ip_protocol = "tcp", description = "Storm UI" }
        storm-supervisor = { from_port = 6700, to_port = 6703, ip_protocol = "tcp", description = "Supervisor" }
      }
    }

    vault = {
      display_name = "Vault"
      ingress_rules = {
        vault = { from_port = 8200, to_port = 8200, ip_protocol = "tcp", description = "Vault" }
      }
    }

    wazuh = {
      display_name = "Wazuh"
      ingress_rules = {
        wazuh-agent-connection-tcp = { from_port = 1514, to_port = 1514, ip_protocol = "tcp", description = "Agent connection (TCP)" }
        wazuh-agent-connection-udp = { from_port = 1514, to_port = 1514, ip_protocol = "udp", description = "Agent connection (UDP)" }
        wazuh-agent-enrollment     = { from_port = 1515, to_port = 1515, ip_protocol = "tcp", description = "Agent enrollment service" }
        wazuh-agent-cluster-daemon = { from_port = 1516, to_port = 1516, ip_protocol = "tcp", description = "Wazuh cluster daemon" }
        wazuh-syslog-collector-tcp = { from_port = 514, to_port = 514, ip_protocol = "tcp", description = "Wazuh Syslog collector (TCP)" }
        wazuh-syslog-collector-udp = { from_port = 514, to_port = 514, ip_protocol = "udp", description = "Wazuh Syslog collector (UDP)" }
        wazuh-restful-api          = { from_port = 55000, to_port = 55000, ip_protocol = "tcp", description = "Wazuh server RESTful API" }
        wazuh-indexer-restful-api  = { from_port = 9200, to_port = 9200, ip_protocol = "tcp", description = "Wazuh indexer RESTful API" }
        wazuh-dashboard            = { from_port = 443, to_port = 443, ip_protocol = "tcp", description = "Wazuh web user interface" }
      }
    }

    winrm = {
      display_name = "WinRM"
      ingress_rules = {
        winrm-http  = { from_port = 5985, to_port = 5985, ip_protocol = "tcp", description = "WinRM HTTP" }
        winrm-https = { from_port = 5986, to_port = 5986, ip_protocol = "tcp", description = "WinRM HTTPS" }
      }
    }

    zabbix = {
      display_name = "Zabbix"
      ingress_rules = {
        zabbix-server = { from_port = 10051, to_port = 10051, ip_protocol = "tcp", description = "Zabbix Server" }
        zabbix-proxy  = { from_port = 10051, to_port = 10051, ip_protocol = "tcp", description = "Zabbix Proxy" }
        zabbix-agent  = { from_port = 10050, to_port = 10050, ip_protocol = "tcp", description = "Zabbix Agent" }
      }
    }

    zipkin = {
      display_name = "Zipkin"
      ingress_rules = {
        zipkin-admin       = { from_port = 9990, to_port = 9990, ip_protocol = "tcp", description = "Zipkin Admin port collector" }
        zipkin-admin-query = { from_port = 9901, to_port = 9901, ip_protocol = "tcp", description = "Zipkin Admin port query" }
        zipkin-admin-web   = { from_port = 9991, to_port = 9991, ip_protocol = "tcp", description = "Zipkin Admin port web" }
        zipkin-query       = { from_port = 9411, to_port = 9411, ip_protocol = "tcp", description = "Zipkin query port" }
        zipkin-web         = { from_port = 8080, to_port = 8080, ip_protocol = "tcp", description = "Zipkin web port" }
      }
    }
  }
}
