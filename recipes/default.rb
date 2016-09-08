include_recipe 'yum-epel::default'
include_recipe 'redisio::default'
include_recipe 'monit-ng::default'

#monit_check 'redis' do
#  check_id
