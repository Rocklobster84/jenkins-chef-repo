#
# Cookbook:: jenkins-agent-install
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

apt_update

package 'openjdk-11-jdk'

remote_file 'jenkins.war' do
  source 'https://get.jenkins.io/war-stable/2.401.2/jenkins.war'
end

package 'cowsay' do 
    action :install
end

execute 'nohup java -jar jenkins.war 2>&1 >> /root/jenkins.log &'

execute 'sleep 30'
execute 'show initial password' do
  command 'sudo cat /root/.jenkins/secrets/initialAdminPassword'
  live_stream true
  action :run
end

directory '/opt/jenkins'  do
    owner 'ubuntu'
    group 'ubuntu'
    recursive true
end
  
package 'docker.io' do
    action :install
end

group 'docker' do
    members  ['ubuntu']
 end
 