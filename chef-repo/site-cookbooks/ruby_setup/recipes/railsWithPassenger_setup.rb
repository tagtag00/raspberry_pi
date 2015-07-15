#
# Cookbook Name:: rubyWithRbenv_setup
# Recipe:: railsWithPassenger_setup
#
# Copyright 2015, GIC Co.,Ltd.
#

# bash "gems install passenger" do
# 	user "root"
# 	code "gem install passenger --no-rdoc --no-ri"
# 	action :run
# end

%w[openssl-devel readline-devel zlib-devel libcurl-devel libyaml-devel mysql-devel httpd-devel].each do |pkg|
	package pkg do
		action :install
	end
end

gem_package "passenger" do
  gem_binary "/usr/local/bin/gem"
  options "--no-rdoc --no-ri"
  action :install
end

bash "passenger setup" do
	user "root"
	code "passenger-install-apache2-module --auto"
	action :run
end

template "passenger.conf" do
	owner "root"
	group "root"
	mode 0644
	path "/etc/httpd/conf.d/passenger.conf"
	source "passenger.conf.erb"
end

execute "passenger snippet" do
	command "passenger-install-apache2-module --snippet > /etc/httpd/conf.d/passenger.conf"
	action :run
end

service "httpd" do
	action [:start,:enable]
end

service "httpd" do
	action [:restart]
end
