include_recipe 'yum-epel::default'
include_recipe 'redisio::default'
include_recipe 'monit-ng::default'
include_recipe 'sysctl::default'

sysctl_param 'vm.overcommit_memory' do
  value 1
end

%w(
net.core.somaxconn
net.ipv4.tcp_max_syn_backlog 
).each do |kern|
  sysctl_param kern do
    value 511
  end
end

file '/etc/redis.conf' do
  action :delete
  not_if { ::File.symlink?('/etc/redis.conf') }
end

link '/etc/redis.conf' do
  to '/etc/redis/6379.conf'
end

monit_check 'redis' do
  check_type 'process'
  id_type 'matching'
  check_id 'redis-server'
  start '/bin/systemctl start redis'
  stop '/bin/systemctl stop redis'
end
