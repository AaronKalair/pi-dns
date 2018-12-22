#
# Cookbook:: pi-dns
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

python_runtime '2' do
  pip_version '9'
end
python_package 'docker-compose' do
  action :install
end

directory '/pihole-data' do
  action :create
end
directory '/pihole-data/pihole' do
  action :create
end
directory '/pihole-data/dnsmasq' do
  action :create
end

cookbook_file '/pihole-data/docker-compose.yaml' do
  action :create
  notifies :restart, 'service[pihole]', :delayed
end

execute 'systemctl daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

cookbook_file '/etc/systemd/system/pihole.service' do
  action :create
  notifies :run, 'execute[systemctl daemon-reload]', :delayed
end

service 'pihole' do
  action [:enable]
end


ip = node['network']['interfaces']['eth0']['addresses'].keys[1]
if ip == nil
  ip = node['network']['interfaces']['wlan0']['addresses'].keys[1]
end
file '/pihole-data/.env' do
  content "ServerIP=#{ip}"
end
