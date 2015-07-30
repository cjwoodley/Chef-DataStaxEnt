
selinux_state "Disabled" do
  action :disabled
end

execute "Disable IPtables" do
  command "sudo /etc/init.d/iptables save && sudo /etc/init.d/iptables stop && sudo /sbin/chkconfig iptables off"
  creates "/tmp/iptables_disabled"
  action :run
end

hostsfile_entry '192.168.56.120' do
  hostname  'dse00.local.com'
  aliases   ['dse00']
  action    :create_if_missing
end

hostsfile_entry '192.168.56.121' do
  hostname  'dse01.local.com'
  aliases   ['dse01']
  action    :create_if_missing
end

hostsfile_entry '192.168.56.122' do
  hostname  'dse02.local.com'
  aliases   ['dse02']
  action    :create_if_missing
end

hostsfile_entry '192.168.56.123' do
  hostname  'dse03.local.com'
  aliases   ['dse03']
  action    :create_if_missing
end

hostsfile_entry '192.168.56.124' do
  hostname  'dse04.local.com'
  aliases   ['dse04']
  action    :create_if_missing
end

group 'casadm' do
  action :create
end

user 'casadm' do
  #supports :manage_home => true
  comment 'Cassandra Admin'
  #uid 1234
  gid 'casadm'
  home '/home/casadm'
  shell '/bin/bash'
  password 'Passw0rd'
end


directory '/opt/sources' do
  owner 'casadm'
  group 'casadm'
  mode '0755'
  action :create
end

directory '/opt/dse' do
  owner 'casadm'
  group 'casadm'
  mode '0755'
  action :create
end

directory '/opt/dse/opscenter' do
  owner 'casadm'
  group 'casadm'
  mode '0755'
  action :create
end

#mount "/opt/sources/" do
#  device "sources"
#  fstype "vboxsf"
#  options "rw"
#  action :mount
#end

