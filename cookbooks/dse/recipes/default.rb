#
# Cookbook Name:: dse
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#rpm_package 'jdk-8u51-linux-x64' do
#  source "/opt/sources/jdk-8u51-linux-x64"
#  action :install
#end

bash 'mountSources' do
  action :run
  user 'root'
  cwd '/opt/'
  code <<-EOH
    mount -t vboxsf sources /opt/sources
  EOH
  #only_if { ::File.exists?("/opt/sources/AMBARI-1.7.1-87-centos6.tar") }
end

bash 'installJDK' do
  action :run
  user 'root'
  cwd '/opt/'
  code <<-EOH
    yum install /opt/sources/jdk-8u51-linux-x64.rpm -y
  EOH
  only_if { ::File.exists?("/opt/sources/jdk-8u51-linux-x64.rpm") }
  not_if { ::File.exists?("/usr/java/default/bin/java") }
end