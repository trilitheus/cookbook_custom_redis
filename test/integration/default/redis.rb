describe package('redis') do
  it { should be_installed }
end

describe service('redis') do
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end

describe kernel_parameter('vm.overcommit_memory') do
  its('value') { should eq 1 }
end

describe kernel_parameter('net.core.somaxconn') do
  its('value') { should eq 511 }
end
