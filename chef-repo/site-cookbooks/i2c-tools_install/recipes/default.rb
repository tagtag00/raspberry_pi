#
# Cookbook Name:: i2c-tools_install
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#

template "modules" do
	owner "root"
	group "root"
	path "/etc/modules"
	source "modules.erb"
end

package "i2c-tools" do
	action :install
end