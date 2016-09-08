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
  end
end
