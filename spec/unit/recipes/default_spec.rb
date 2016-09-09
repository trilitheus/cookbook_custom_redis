#
# Cookbook Name:: custom_redis
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'custom_redis::default' do
  context 'When all attributes are default, on RHEL7' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(file_cache_path: '/tmp') do |node|
        node.automatic['memory']['total'] = 4096
        node.automatic['os'] = 'linux'
        node.automatic['platform_family'] = 'rhel'
        node.automatic['virtualization']['system'] = 'vmware'
      end.converge(described_recipe)
    end

    it 'includes the yum-epel cookbook' do
      expect(chef_run).to include_recipe('yum-epel::default')
    end

    it 'includes the redisio cookbook' do
      expect(chef_run).to include_recipe('redisio::default')
    end

    it 'includes the monit-ng cookbook' do
      expect(chef_run).to include_recipe('monit-ng::default')
    end

    it 'includes the sysctl cookbook' do
      expect(chef_run).to include_recipe('sysctl::default')
    end

    it 'sets net.core.somaxconn to 511' do
      expect(chef_run).to apply_sysctl_param('net.core.somaxconn').with_value('511')
    end

    it 'sets net.ipv4.tcp_max_syn_backlog to 511' do
      expect(chef_run).to apply_sysctl_param('net.ipv4.tcp_max_syn_backlog').with_value('511')
    end

    it 'sets vm.overcommit_memory to 1' do
      expect(chef_run).to apply_sysctl_param('vm.overcommit_memory').with_value('1')
    end
  end
end
