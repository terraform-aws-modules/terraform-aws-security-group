#################
# Security group
#################
variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "create_sg" {
  description = "Whether to create security group"
  type        = bool
  default     = true
}

variable "security_group_id" {
  description = "ID of existing security group whose rules we will manage"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of security group - not required if create_sg is false"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "Time to wait for a security group to be created"
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "Time to wait for a security group to be deleted"
  type        = string
  default     = "15m"
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_with_self" {
  description = "List of ingress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_ipv6_cidr_blocks" {
  description = "List of ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_with_prefix_list_ids" {
  description = "List of ingress rules to create where 'prefix_list_ids' is used only"
  type        = list(map(string))
  default     = []
}

###################
# Computed Ingress
###################
variable "computed_ingress_rules" {
  description = "List of computed ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "computed_ingress_with_self" {
  description = "List of computed ingress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "computed_ingress_with_cidr_blocks" {
  description = "List of computed ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_ingress_with_ipv6_cidr_blocks" {
  description = "List of computed ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_ingress_with_source_security_group_id" {
  description = "List of computed ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

###################################
# Number of computed ingress rules
###################################
variable "number_of_computed_ingress_rules" {
  description = "Number of computed ingress rules to create by name"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_self" {
  description = "Number of computed ingress rules to create where 'self' is defined"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_cidr_blocks" {
  description = "Number of computed ingress rules to create where 'cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_ipv6_cidr_blocks" {
  description = "Number of computed ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_source_security_group_id" {
  description = "Number of computed ingress rules to create where 'source_security_group_id' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_prefix_list_ids" {
  description = "Number of computed ingress rules to create where 'prefix_list_ids' is used"
  type        = number
  default     = 0
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_self" {
  description = "List of egress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_ipv6_cidr_blocks" {
  description = "List of egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_prefix_list_ids" {
  description = "List of egress rules to create where 'prefix_list_ids' is used only"
  type        = list(map(string))
  default     = []
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["::/0"]
}

variable "egress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules"
  type        = list(string)
  default     = []
}

##################
# Computed Egress
##################
variable "computed_egress_rules" {
  description = "List of computed egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "computed_egress_with_self" {
  description = "List of computed egress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_cidr_blocks" {
  description = "List of computed egress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_ipv6_cidr_blocks" {
  description = "List of computed egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_source_security_group_id" {
  description = "List of computed egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_prefix_list_ids" {
  description = "List of computed egress rules to create where 'prefix_list_ids' is used only"
  type        = list(map(string))
  default     = []
}

##################################
# Number of computed egress rules
##################################
variable "number_of_computed_egress_rules" {
  description = "Number of computed egress rules to create by name"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_self" {
  description = "Number of computed egress rules to create where 'self' is defined"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_cidr_blocks" {
  description = "Number of computed egress rules to create where 'cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_ipv6_cidr_blocks" {
  description = "Number of computed egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_source_security_group_id" {
  description = "Number of computed egress rules to create where 'source_security_group_id' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_prefix_list_ids" {
  description = "Number of computed egress rules to create where 'prefix_list_ids' is used only"
  type        = number
  default     = 0
}

variable "putin_khuylo" {
  description = "Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo!"
  type        = bool
  default     = true
}

##################################
# Rules
##################################

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers (from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml):
  # All = -1, IPV4-ICMP = 1, TCP = 6, UDP = 17, IPV6-ICMP = 58
  default = {
    # ActiveMQ
    activemq-5671-tcp  = [5671, 5671, "tcp", "ActiveMQ AMQP"]
    activemq-8883-tcp  = [8883, 8883, "tcp", "ActiveMQ MQTT"]
    activemq-61614-tcp = [61614, 61614, "tcp", "ActiveMQ STOMP"]
    activemq-61617-tcp = [61617, 61617, "tcp", "ActiveMQ OpenWire"]
    activemq-61619-tcp = [61619, 61619, "tcp", "ActiveMQ WebSocket"]
    # Alert Manager
    alertmanager-9093-tcp = [9093, 9093, "tcp", "Alert Manager"]
    alertmanager-9094-tcp = [9094, 9094, "tcp", "Alert Manager Cluster"]
    # Carbon relay
    carbon-line-in-tcp = [2003, 2003, "tcp", "Carbon line-in"]
    carbon-line-in-udp = [2003, 2003, "udp", "Carbon line-in"]
    carbon-pickle-tcp  = [2013, 2013, "tcp", "Carbon pickle"]
    carbon-pickle-udp  = [2013, 2013, "udp", "Carbon pickle"]
    carbon-admin-tcp   = [2004, 2004, "tcp", "Carbon admin"]
    carbon-gui-udp     = [8081, 8081, "tcp", "Carbon GUI"]
    # Cassandra
    cassandra-clients-tcp        = [9042, 9042, "tcp", "Cassandra clients"]
    cassandra-thrift-clients-tcp = [9160, 9160, "tcp", "Cassandra Thrift clients"]
    cassandra-jmx-tcp            = [7199, 7199, "tcp", "JMX"]
    # Consul
    consul-tcp             = [8300, 8300, "tcp", "Consul server"]
    consul-grpc-tcp        = [8502, 8502, "tcp", "Consul gRPC"]
    consul-grpc-tcp-tls    = [8503, 8503, "tcp", "Consul gRPC TLS"]
    consul-webui-http-tcp  = [8500, 8500, "tcp", "Consul web UI HTTP"]
    consul-webui-https-tcp = [8501, 8501, "tcp", "Consul web UI HTTPS"]
    consul-dns-tcp         = [8600, 8600, "tcp", "Consul DNS"]
    consul-dns-udp         = [8600, 8600, "udp", "Consul DNS"]
    consul-serf-lan-tcp    = [8301, 8301, "tcp", "Serf LAN"]
    consul-serf-lan-udp    = [8301, 8301, "udp", "Serf LAN"]
    consul-serf-wan-tcp    = [8302, 8302, "tcp", "Serf WAN"]
    consul-serf-wan-udp    = [8302, 8302, "udp", "Serf WAN"]
    # DAX Cluster
    dax-cluster-unencrypted-tcp = [8111, 8111, "tcp", "DAX Cluster unencrypted"]
    dax-cluster-encrypted-tcp   = [9111, 9111, "tcp", "DAX Cluster encrypted"]
    # Docker Swarm
    docker-swarm-mngmt-tcp   = [2377, 2377, "tcp", "Docker Swarm cluster management"]
    docker-swarm-node-tcp    = [7946, 7946, "tcp", "Docker Swarm node"]
    docker-swarm-node-udp    = [7946, 7946, "udp", "Docker Swarm node"]
    docker-swarm-overlay-udp = [4789, 4789, "udp", "Docker Swarm Overlay Network Traffic"]
    # DNS
    dns-udp = [53, 53, "udp", "DNS"]
    dns-tcp = [53, 53, "tcp", "DNS"]
    # Etcd
    etcd-client-tcp = [2379, 2379, "tcp", "Etcd Client"]
    etcd-peer-tcp   = [2380, 2380, "tcp", "Etcd Peer"]
    # NTP - Network Time Protocol
    ntp-udp = [123, 123, "udp", "NTP"]
    # Elasticsearch
    elasticsearch-rest-tcp = [9200, 9200, "tcp", "Elasticsearch REST interface"]
    elasticsearch-java-tcp = [9300, 9300, "tcp", "Elasticsearch Java interface"]
    # Grafana
    grafana-tcp = [3000, 3000, "tcp", "Grafana Dashboard"]
    # Graphite Statsd
    graphite-webui    = [80, 80, "tcp", "Graphite admin interface"]
    graphite-2003-tcp = [2003, 2003, "tcp", "Carbon receiver plain text"]
    graphite-2004-tcp = [2004, 2004, "tcp", "Carbon receiver pickle"]
    graphite-2023-tcp = [2023, 2023, "tcp", "Carbon aggregator plaintext"]
    graphite-2024-tcp = [2024, 2024, "tcp", "Carbon aggregator pickle"]
    graphite-8080-tcp = [8080, 8080, "tcp", "Graphite gunicorn port"]
    graphite-8125-tcp = [8125, 8125, "tcp", "Statsd TCP"]
    graphite-8125-udp = [8125, 8125, "udp", "Statsd UDP default"]
    graphite-8126-tcp = [8126, 8126, "tcp", "Statsd admin"]
    # HTTP
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    http-8080-tcp = [8080, 8080, "tcp", "HTTP"]
    # HTTPS
    https-443-tcp  = [443, 443, "tcp", "HTTPS"]
    https-8443-tcp = [8443, 8443, "tcp", "HTTPS"]
    # IPSEC
    ipsec-500-udp  = [500, 500, "udp", "IPSEC ISAKMP"]
    ipsec-4500-udp = [4500, 4500, "udp", "IPSEC NAT-T"]
    # Kafka
    kafka-broker-tcp                   = [9092, 9092, "tcp", "Kafka PLAINTEXT enable broker 0.8.2+"]
    kafka-broker-tls-tcp               = [9094, 9094, "tcp", "Kafka TLS enabled broker 0.8.2+"]
    kafka-broker-tls-public-tcp        = [9194, 9194, "tcp", "Kafka TLS Public enabled broker 0.8.2+ (MSK specific)"]
    kafka-broker-sasl-scram-tcp        = [9096, 9096, "tcp", "Kafka SASL/SCRAM enabled broker (MSK specific)"]
    kafka-broker-sasl-scram-public-tcp = [9196, 9196, "tcp", "Kafka SASL/SCRAM Public enabled broker (MSK specific)"]
    kafka-broker-sasl-iam-tcp          = [9098, 9098, "tcp", "Kafka SASL/IAM access control enabled (MSK specific)"]
    kafka-broker-sasl-iam-public-tcp   = [9198, 9198, "tcp", "Kafka SASL/IAM Public access control enabled (MSK specific)"]
    kafka-jmx-exporter-tcp             = [11001, 11001, "tcp", "Kafka JMX Exporter"]
    kafka-node-exporter-tcp            = [11002, 11002, "tcp", "Kafka Node Exporter"]
    # Kibana
    kibana-tcp = [5601, 5601, "tcp", "Kibana Web Interface"]
    # Kubernetes
    kubernetes-api-tcp = [6443, 6443, "tcp", "Kubernetes API Server"]
    # LDAP
    ldap-tcp = [389, 389, "tcp", "LDAP"]
    # LDAPS
    ldaps-tcp = [636, 636, "tcp", "LDAPS"]
    # Logstash
    logstash-tcp = [5044, 5044, "tcp", "Logstash"]
    # Loki
    loki-grafana      = [3100, 3100, "tcp", "Grafana Loki endpoint"]
    loki-grafana-grpc = [9095, 9095, "tcp", "Grafana Loki GRPC"]
    # Memcached
    memcached-tcp = [11211, 11211, "tcp", "Memcached"]
    # MinIO
    minio-tcp = [9000, 9000, "tcp", "MinIO"]
    # MongoDB
    mongodb-27017-tcp = [27017, 27017, "tcp", "MongoDB"]
    mongodb-27018-tcp = [27018, 27018, "tcp", "MongoDB shard"]
    mongodb-27019-tcp = [27019, 27019, "tcp", "MongoDB config server"]
    # MySQL
    mysql-tcp = [3306, 3306, "tcp", "MySQL/Aurora"]
    # MSSQL Server
    mssql-tcp           = [1433, 1433, "tcp", "MSSQL Server"]
    mssql-udp           = [1434, 1434, "udp", "MSSQL Browser"]
    mssql-analytics-tcp = [2383, 2383, "tcp", "MSSQL Analytics"]
    mssql-broker-tcp    = [4022, 4022, "tcp", "MSSQL Broker"]
    # NFS/EFS
    nfs-tcp = [2049, 2049, "tcp", "NFS/EFS"]
    # Nomad
    nomad-http-tcp = [4646, 4646, "tcp", "Nomad HTTP"]
    nomad-rpc-tcp  = [4647, 4647, "tcp", "Nomad RPC"]
    nomad-serf-tcp = [4648, 4648, "tcp", "Serf"]
    nomad-serf-udp = [4648, 4648, "udp", "Serf"]
    # OpenVPN
    openvpn-udp       = [1194, 1194, "udp", "OpenVPN"]
    openvpn-tcp       = [943, 943, "tcp", "OpenVPN"]
    openvpn-https-tcp = [443, 443, "tcp", "OpenVPN"]
    # PostgreSQL
    postgresql-tcp = [5432, 5432, "tcp", "PostgreSQL"]
    # Puppet
    puppet-tcp   = [8140, 8140, "tcp", "Puppet"]
    puppetdb-tcp = [8081, 8081, "tcp", "PuppetDB"]
    # Prometheus
    prometheus-http-tcp               = [9090, 9090, "tcp", "Prometheus"]
    prometheus-pushgateway-http-tcp   = [9091, 9091, "tcp", "Prometheus Pushgateway"]
    prometheus-node-exporter-http-tcp = [9100, 9100, "tcp", "Prometheus Node Exporter"]
    # Promtail
    promtail-http = [9080, 9080, "tcp", "Promtail endpoint"]
    # Oracle Database
    oracle-db-tcp = [1521, 1521, "tcp", "Oracle"]
    # Octopus Tentacles
    octopus-tentacle-tcp = [10933, 10933, "tcp", "Octopus Tentacle"]
    # RabbitMQ
    rabbitmq-4369-tcp  = [4369, 4369, "tcp", "RabbitMQ epmd"]
    rabbitmq-5671-tcp  = [5671, 5671, "tcp", "RabbitMQ"]
    rabbitmq-5672-tcp  = [5672, 5672, "tcp", "RabbitMQ"]
    rabbitmq-15672-tcp = [15672, 15672, "tcp", "RabbitMQ"]
    rabbitmq-25672-tcp = [25672, 25672, "tcp", "RabbitMQ"]
    # RDP
    rdp-tcp = [3389, 3389, "tcp", "Remote Desktop"]
    rdp-udp = [3389, 3389, "udp", "Remote Desktop"]
    # Redis
    redis-tcp = [6379, 6379, "tcp", "Redis"]
    # Redshift
    redshift-tcp = [5439, 5439, "tcp", "Redshift"]
    # SaltStack
    saltstack-tcp = [4505, 4506, "tcp", "SaltStack"]
    # SMTP
    smtp-tcp                 = [25, 25, "tcp", "SMTP"]
    smtp-submission-587-tcp  = [587, 587, "tcp", "SMTP Submission"]
    smtp-submission-2587-tcp = [2587, 2587, "tcp", "SMTP Submission"]
    smtps-465-tcp            = [465, 465, "tcp", "SMTPS"]
    smtps-2456-tcp           = [2465, 2465, "tcp", "SMTPS"]
    # Solr
    solr-tcp = [8983, 8987, "tcp", "Solr"]
    # Splunk
    splunk-indexer-tcp = [9997, 9997, "tcp", "Splunk indexer"]
    splunk-web-tcp     = [8000, 8000, "tcp", "Splunk Web"]
    splunk-splunkd-tcp = [8089, 8089, "tcp", "Splunkd"]
    splunk-hec-tcp     = [8088, 8088, "tcp", "Splunk HEC"]
    # Squid
    squid-proxy-tcp = [3128, 3128, "tcp", "Squid default proxy"]
    # SSH
    ssh-tcp = [22, 22, "tcp", "SSH"]
    # Storm
    storm-nimbus-tcp     = [6627, 6627, "tcp", "Nimbus"]
    storm-ui-tcp         = [8080, 8080, "tcp", "Storm UI"]
    storm-supervisor-tcp = [6700, 6703, "tcp", "Supervisor"]
    # Vault
    vault-tcp = [8200, 8200, "tcp", "Vault"]
    # Wazuh
    wazuh-server-agent-connection-tcp = [1514, 1514, "tcp", "Agent connection service(TCP)"]
    wazuh-server-agent-connection-udp = [1514, 1514, "udp", "Agent connection service(UDP)"]
    wazuh-server-agent-enrollment     = [1515, 1515, "tcp", "Agent enrollment service"]
    wazuh-server-agent-cluster-daemon = [1516, 1516, "tcp", "Wazuh cluster daemon"]
    wazuh-server-syslog-collector-tcp = [514, 514, "tcp", "Wazuh Syslog collector(TCP)"]
    wazuh-server-syslog-collector-udp = [514, 514, "udp", "Wazuh Syslog collector(UDP)"]
    wazuh-server-restful-api          = [55000, 55000, "tcp", "Wazuh server RESTful API"]
    wazuh-indexer-restful-api         = [9200, 9200, "tcp", "Wazuh indexer RESTful API"]
    wazuh-dashboard                   = [443, 443, "tcp", "Wazuh web user interface"]
    # Web
    web-jmx-tcp = [1099, 1099, "tcp", "JMX"]
    # WinRM
    winrm-http-tcp  = [5985, 5985, "tcp", "WinRM HTTP"]
    winrm-https-tcp = [5986, 5986, "tcp", "WinRM HTTPS"]
    # Zabbix
    zabbix-server = [10051, 10051, "tcp", "Zabbix Server"]
    zabbix-proxy  = [10051, 10051, "tcp", "Zabbix Proxy"]
    zabbix-agent  = [10050, 10050, "tcp", "Zabbix Agent"]
    # Zipkin
    zipkin-admin-tcp       = [9990, 9990, "tcp", "Zipkin Admin port collector"]
    zipkin-admin-query-tcp = [9901, 9901, "tcp", "Zipkin Admin port query"]
    zipkin-admin-web-tcp   = [9991, 9991, "tcp", "Zipkin Admin port web"]
    zipkin-query-tcp       = [9411, 9411, "tcp", "Zipkin query port"]
    zipkin-web-tcp         = [8080, 8080, "tcp", "Zipkin web port"]
    # Zookeeper
    zookeeper-2181-tcp     = [2181, 2181, "tcp", "Zookeeper"]
    zookeeper-2182-tls-tcp = [2182, 2182, "tcp", "Zookeeper TLS (MSK specific)"]
    zookeeper-2888-tcp     = [2888, 2888, "tcp", "Zookeeper"]
    zookeeper-3888-tcp     = [3888, 3888, "tcp", "Zookeeper"]
    zookeeper-jmx-tcp      = [7199, 7199, "tcp", "JMX"]
    # Open all ports & protocols
    all-all       = [-1, -1, "-1", "All protocols"]
    all-tcp       = [0, 65535, "tcp", "All TCP ports"]
    all-udp       = [0, 65535, "udp", "All UDP ports"]
    all-icmp      = [-1, -1, "icmp", "All IPV4 ICMP"]
    all-ipv6-icmp = [-1, -1, 58, "All IPV6 ICMP"]
    # This is a fallback rule to pass to lookup() as default. It does not open anything, because it should never be used.
    _ = ["", "", ""]
  }
}