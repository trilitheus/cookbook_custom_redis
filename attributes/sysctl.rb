default['custom_redis']['sysctl']['net.ipv4.tcp_max_syn_backlog'] = '511' unless node['virtualization']['system'] == 'docker'
default['custom_redis']['sysctl']['net.core.somaxconn'] = '511'
default['custom_redis']['sysctl']['vm.overcommit_memory'] = '1'
