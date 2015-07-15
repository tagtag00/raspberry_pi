#
# Cookbook Name:: node_setup
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#

package "git" do
  action :install
end

bash "source_nvm.sh" do
  user node["nvm"]["user"]
  code "echo source /home/#{node["nvm"]["user"]}/.nvm/nvm.sh >> /home/#{node["nvm"]["user"]}/.bash_profile"
  action :nothing
end

git "/home/#{node["nvm"]["user"]}/.nvm" do
  user node["nvm"]["user"]
  repository "git://github.com/creationix/nvm.git"
  revision "master"
  action :sync
  notifies :run, 'bash[source_nvm.sh]'
end

bash "node install" do
  user node["nvm"]["user"]
  code <<-EOC
    source /home/#{node["nvm"]["user"]}/.nvm/nvm.sh
    nvm install #{node["node"]["version"]}
    nvm use #{node["node"]["version"]}
    nvm alias default #{node["node"]["version"]}
  EOC
end

