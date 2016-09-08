include_recipe 'yum-epel::default'
include_recipe 'redisio::default'
include_recipe 'monit-ng::default'
include_recipe 'sysctl::default'

sysctl_param 'vm.overcommit_memory' do
  value 1
end

sysctl_param 'net.core.somaxconn' do
  value 511
end

monit_check 'redis' do
  check_type 'process'
  id_type 'matching'
  check_id 'redis-server'
  start '/bin/systemctl start redis'
  stop '/bin/systemctl stop redis'
end
