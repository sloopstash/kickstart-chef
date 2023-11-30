# Set attributes.
default['system']['infrastructure']['type'] = 'on-premise'
default['system']['infrastructure']['provider'] = 'host'
default['system']['infrastructure']['service'] = 'docker'
default['system']['infrastructure']['region'] = nil
default['system']['user'] = 'tuto'
default['system']['group'] = 'tuto'
default['system']['kernel']['vm.swappiness'] = 0
default['system']['kernel']['vm.overcommit_memory'] = 1
default['system']['kernel']['vm.max_map_count'] = 262144
default['system']['kernel']['net.core.somaxconn'] = 65536
default['system']['kernel']['net.ipv4.tcp_max_syn_backlog'] = 8192
default['system']['kernel']['net.bridge.bridge-nf-call-ip6tables'] = 1
default['system']['kernel']['net.ipv4.ip_forward'] = 1
default['system']['kernel']['net.bridge.bridge-nf-call-iptables'] = 1
default['system']['security_limit']['open_files'] = 65536
default['system']['security_limit']['memory_lock'] = 'unlimited'
default['system']['supervisor']['conf_dir'] = '/etc/supervisord.d'
default['system']['supervisor']['exec_dir'] = '/usr/bin'
default['system']['supervisor']['conf_path'] = '/etc/supervisord.conf'
default['system']['organization'] = 'sloopstash'