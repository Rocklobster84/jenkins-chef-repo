#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

apt_update

package 'net-tools' do
    action :install
end

package 'apache2' do
    action :install
end

file '/var/www/html/index.html' do
    action :create
    content 'Hello World!'
end

service 'apache2' do
    action [ :enable, :start ]
end