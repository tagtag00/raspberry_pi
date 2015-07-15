#
# Cookbook Name:: UART_enable
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#

template "cmdline.txt" do
	owner "root"
	group "root"
	path "/boot/cmdline.txt"
	source "cmdline.txt.erb"
end

template "inittab" do
	owner "root"
	group "root"
	path "/etc/inittab"
	source "inittab.erb"
end

# bash "reboot" do
# 	user "root"
# 	code "reboot"
# 	action :run
# end