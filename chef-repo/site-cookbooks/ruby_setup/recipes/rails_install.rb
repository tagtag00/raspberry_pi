#
# Cookbook Name:: rubyWithRbenv_setup
# Recipe:: rails_install
# Copyright 2015, GIC Co.,Ltd.
#

%w[openssl-devel readline-devel zlib-devel libcurl-devel libyaml-devel mysql-devel httpd-devel sqlite-devel].each do |pkg|
	package pkg do
		action :install
	end
end

bash "/etc/resolv.conf edit" do
  user 'root'
  code <<-EOC
    echo options single-request-reopen >> /etc/resolv.conf
  EOC
end

gem_package "rails" do
  gem_binary "/usr/local/bin/gem"
  options "--no-rdoc --no-ri"
  action :install
end

gem_package "sqlite3" do
  gem_binary "/usr/local/bin/gem"
  options "--no-rdoc --no-ri"
  action :install
end